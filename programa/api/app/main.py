from fastapi import FastAPI
from app.db import Database

app = FastAPI()


@app.get("/")
def read_root():
    return {"Postgresql API feita por Matheus Costa e Felipe Bertoglio"}


app = FastAPI(title='Postgres API')
db = Database(
    host='host.docker.internal',
    port=5432,
    database='postgres',
    user='postgres',
    password='mypassword'
)


@app.on_event('startup')
async def startup_event():
    db.connect()


@app.on_event('shutdown')
async def shutdown_event():
    db.close()


# 1. buscar administrador por id e as Lojas que ele administra
@app.get('/admin')
async def get_admin(idAdmin: int):
    result = db.execute(
        f'''
SELECT DISTINCT A.nome nome_administrador, AL.idloja, L.nome nome_administrador
FROM Administradores_Lojas AL
JOIN Administradores A ON A.idUser = AL.idadministrador
JOIN Lojas L ON L.idloja = AL.idloja
WHERE AL.idadministrador = {idAdmin}
ORDER BY AL.idloja;
            '''
    )
    lojas = []
    for row in result:
        lojas.append({'nome': row[0], 'idLoja': row[1], 'Loja': row[2]})
    return {'result': lojas}


# 2. buscar loja por nome e a lista de seus administradores
@app.get('/admin-loja')
async def get_admins(nomeLoja: object):
    result = db.execute(
        f'''
SELECT DISTINCT L.idloja, L.nome nome_loja, A.idUser, A.nome nome_administrador
FROM Administradores_Lojas AL
JOIN Administradores A ON A.idUser = AL.idAdministrador
JOIN Lojas L ON L.idloja = AL.idloja
WHERE L.nome like '%{nomeLoja}%'
ORDER BY A.idUser;            '''
    )
    admins = []
    for row in result:
        admins.append(
            {'idLoja': row[0], 'nomeLoja': row[1], 'idAdmin': row[2], 'nomeAdmin': row[3]})
    return {'result': admins}


# 3. buscar cliente por id e mostrar as compras que ele realizou
@app.get('/compras-cliente')
async def get_compras_cliente(idCliente: int):
    result = db.execute(
        f'''
SELECT DISTINCT Cli.iduser, Cli.nome nome_cliente,
Com.idCarrinho, Com.datahora, Com.valor, Pag.foiConfirmado, Pag.dataHoraPagamento
FROM Clientes Cli
JOIN Compras Com ON Com.idCliente = Cli.idUser
JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
where Cli.idUser = {idCliente};'''
    )
    compras = []
    for row in result:
        compras.append(
            {'idCliente': row[0], 'nomeCliente': row[1], 'idCarrinho': row[2],
             'dataHora': row[3], 'valor': row[4],  'confirmado': row[5], 'dataHoraPagamento': row[6]
             })
    return {'result': compras}

# 4. buscar cliente por id e mostrar as avaliações que ele realizou


@app.get('/avaliacoes-cliente')
async def get_avaliacoes_cliente(idCliente: int):
    result = db.execute(
        f'''
SELECT DISTINCT Cli.iduser, Cli.nome nome_cliente, AL.idloja, L.nome nome_loja, AL.nota, AL.comentario
FROM Clientes Cli
JOIN AvaliacoesLoja AL ON AL.idCliente = Cli.idUser
JOIN Lojas L ON L.idloja = AL.idloja
WHERE Cli.idUser = {idCliente};
        '''
    )
    avaliacoes = []
    for row in result:
        avaliacoes.append(
            {'idCliente': row[0], 'nomeCliente': row[1], 'idLoja': row[2],
             'nomeLoja': row[3], 'nota': row[4],  'comentario': row[5]})
    return {'result': avaliacoes}


# 5. Listar pagamentos pendentes de um cliente, ou seja, que não foram confirmados
# SUBCONSULTA


@app.get('/pendente-cliente')
async def get_pendente_cliente(idCliente: int):
    result = db.execute(
        f'''
SELECT DISTINCT Cli.iduser, cli.nome nome_cliente, Pendentes.idCarrinho, L.nome nome_loja, Pendentes.valor, Pendentes.datahora Data_compra
FROM Clientes Cli
JOIN (
  SELECT DISTINCT Com.idCliente, Com.idCarrinho, Com.datahora, Com.valor, Pag.foiConfirmado, Pag.dataHoraPagamento, Com.idloja
  FROM Compras Com
  JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
  WHERE Pag.foiConfirmado = false
) AS Pendentes
JOIN Lojas L ON L.idloja = Pendentes.idloja
ON Pendentes.idCliente = Cli.idUser
WHERE Cli.iduser ={idCliente} ;
        '''
    )
    pendentes = []
    for row in result:
        pendentes.append(
            {'idCliente': row[0], 'nomeCliente': row[1], 'idCarrinho': row[2],
             'nomeLoja': row[3], 'valorPendente': row[4],  'dataHora': row[5]})
    return {'result': pendentes}

# 6. Listar vendas de um uma loja


@app.get('/vendas-loja')
async def get_vendas_loja(idLoja: int):
    result = db.execute(
        f'''
SELECT DISTINCT L.idloja, L.nome nome_loja, Conf.idCarrinho, Conf.datahora, Conf.valor, conf.dataHoraPagamento
FROM Lojas L
JOIN (
SELECT DISTINCT Com.idloja, Com.idCarrinho, Com.datahora, Com.valor, Pag.dataHoraPagamento
FROM Compras Com
JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
WHERE Pag.foiConfirmado = true
) AS conf ON Conf.idloja = L.idloja
  WHERE L.idloja = {idLoja};
        '''
    )
    vendas = []
    for row in result:
        vendas.append(
            {'idLoja': row[0], 'nomeLoja': row[1], 'idCarrinho': row[2],
             'dataHora': row[3], 'valor': row[4],  'dataHoraPagamento': row[5]})
    return {'result': vendas}

# 7. Somar lucro de vendas de uma loja
# GROUP BY, SUBCONSULTA


@app.get('/lucro-loja')
async def get_lucro_loja(idLoja: int):
    result = db.execute(
        f'''
SELECT DISTINCT L.idloja, L.nome nome_loja, SUM(Conf.valor) lucro
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Com.idCarrinho, Com.datahora, Com.valor, Pag.dataHoraPagamento
    FROM Compras Com
    JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
      WHERE Pag.foiConfirmado = true
  ) AS conf ON Conf.idloja = L.idloja
  WHERE L.idloja = {idLoja}
  GROUP BY L.idloja, L.nome;
        '''
    )
    lucro = []
    for row in result:
        lucro.append(
            {'idLoja': row[0], 'nomeLoja': row[1], 'lucro': row[2]})
    return {'result': lucro}


# 8. Listar clientes devedores de uma loja (que tem compras não confirmadas)
# SUBCONSULTA

@app.get('/clientes-devedores')
async def get_clientes_devedores(idLoja: int):
    result = db.execute(
        f'''
SELECT DISTINCT L.idloja, L.nome nome_loja, Cli.iduser, Cli.nome nome_cliente, Pendentes.idCarrinho, Pendentes.datahora, Pendentes.valor
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Com.idCarrinho, Com.datahora, Com.valor, Pag.foiConfirmado, Pag.dataHoraPagamento, Com.idCliente
    FROM Compras Com
    JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
      WHERE Pag.foiConfirmado = false
  ) AS Pendentes ON Pendentes.idloja = L.idloja
  JOIN Clientes Cli ON Cli.idUser = Pendentes.idCliente
  WHERE L.idloja = {idLoja};
        '''
    )
    devedores = []
    for row in result:
        devedores.append(
            {'idLoja': row[0], 'nomeLoja': row[1], 'idCliente': row[2],
             'nomeCliente': row[3], 'carrinhoPendente': row[4],  'dataHoraPendente': row[5], 'valorDevido': row[6]})
    return {'result': devedores}


# 9. Listar produtos com filtro de mais vendidos de uma loja
# SUBCONSULTA, GROUP BY

@app.get('/produtos')
async def get_produtos(idLoja: int = -1):
    filter = f" WHERE L.idloja = {idLoja}" if idLoja != -1 else ""
    result = db.execute(
        f'''
        SELECT DISTINCT L.idloja, L.nome nome_loja, Prod.idproduto, Prod.nome nome_produto, SUM(Prod.quantidade) quantidade_vendida
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Prod.idproduto, Prod.nome, Prod.quantidade
    FROM Produtos_Carrinho PD
    JOIN Produtos Prod ON (Prod.idproduto = PD.idproduto AND Prod.idloja = PD.idloja)
    JOIN Compras Com ON Com.idCarrinho = PD.idCarrinho
  ) AS Prod ON Prod.idloja = L.idloja
  {filter}
  GROUP BY L.idloja, L.nome, Prod.idproduto, Prod.nome
  ORDER BY quantidade_vendida DESC;

        '''
    )
    produtos = []
    for row in result:
        produtos.append(
            {'idLoja': row[0], 'nomeLoja': row[1], 'idProduto': row[2],
             'nomeProduto': row[3], 'quantidadeVendida': row[4]})
    return {'result': produtos}

# 10. Listar clientes de uma loja (que tem compras confirmadas) e que não realizaram avaliação
# NOT EXISTS, SUBCONSULTA


@app.get('/clientes-sem-avaliacao')
async def get_clientes_sem_avaliacao(idLoja: int = -1):
    filter = f" WHERE L.idloja = {idLoja}" if idLoja != -1 else ""
    result = db.execute(
        f'''
   SELECT DISTINCT L.idloja, L.nome nome_loja, Cli.iduser, Cli.nome nome_cliente, confirmadas.idCarrinho idCompra, confirmadas.datahora, confirmadas.valor
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Com.idCliente, Com.idCarrinho, Com.datahora, Com.valor, Pag.foiConfirmado, Pag.dataHoraPagamento
    FROM Compras Com
    JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
    WHERE Pag.foiConfirmado = TRUE
  ) AS confirmadas ON confirmadas.idloja = L.idloja
  JOIN Clientes Cli ON Cli.idUser = confirmadas.idCliente
  {filter}
  AND NOT EXISTS (
    SELECT *
    FROM AvaliacoesLoja AL
    WHERE AL.idCliente = confirmadas.idCliente AND AL.idloja = confirmadas.idloja
  );        '''
    )

    clientes = []
    for row in result:
        clientes.append(
            {'idLoja': row[0], 'nomeLoja': row[1], 'idCliente': row[2],
             'nomeCliente': row[3], 'idConfirmado': row[4], 'dataConfirmado': row[5], 'valorConfirmado': row[6]})
    return {'result': clientes}


# 11. Listar lojas que possuem avaliação maior ou igual a 3 que tenham produtos de uma determinada categoria
# SUBCONSULTA, GROUP BY, HAVING

@app.get('/melhores-lojas')
async def get_melhores_lojas(categoria: object):
    result = db.execute(
        f'''
  SELECT L.idloja, L.nome, AVG(AL.nota) media
    FROM Lojas L
    JOIN AvaliacoesLoja AL ON AL.idloja = L.idloja
    JOIN (
      SELECT Prod.idloja, Prod.idproduto, Prod.nome, Prod.categoria, Prod.valor
      FROM Produtos Prod
      WHERE Prod.categoria = '{categoria}'
    ) AS Prod ON Prod.idloja = L.idloja
    GROUP BY L.idloja, L.nome
    HAVING AVG(AL.nota) >= 3
    ORDER BY AVG(AL.nota) DESC;
        ''')
    lojas = []
    for row in result:
        lojas.append(
            {'idLoja': row[0], 'nomeLoja': row[1], 'notaMedia': row[2]})
    return {'result': lojas}

  #  12. Listar produtos que possuem avaliação maior ou igual a 3
  #  VIEW


@app.get('/melhores-produtos')
async def get_melhores_produtos(idLoja: int):
    result = db.execute(
        f'''
  SELECT *
    FROM Visao_Geral_Produtos
    WHERE mediaAvaliacoes >= 3 AND idloja = {idLoja}
    ORDER BY mediaAvaliacoes DESC;
        ''')
    produtos = []
    for row in result:
        produtos.append(
            {
                'idLoja': row[0], 'idProduto': row[1], 'nomeProduto': row[2], 'nomeLoja': row[3],
                'descricao': row[4], 'valor': row[5], 'quantidade': row[6], 'categoria': row[7],
                'mediaAvaliacoes': row[8], 'numAvaliacoes': row[9]
            })
    return {'result': produtos}

  #  13. Listar produtos de menor à maior valor
  # VIEW


@app.get('/ordenar-produtos')
async def get_produtos_ordenados(idLoja: int):
    result = db.execute(
        f'''
          SELECT *
    FROM Visao_Geral_Produtos
    WHERE idloja = {idLoja}
    ORDER BY valor ASC;
        ''')
    produtos = []
    for row in result:
        produtos.append(
            {
                'idLoja': row[0], 'idProduto': row[1], 'nomeProduto': row[2], 'nomeLoja': row[3],
                'descricao': row[4], 'valor': row[5], 'quantidade': row[6], 'categoria': row[7],
                'mediaAvaliacoes': row[8], 'numAvaliacoes': row[9]
            })
    return {'result': produtos}


# FUNCAO
# SELECT confirma_pagamento(1);

@app.get('/confirma-pagamento')
async def confirma_pagamento(idCompra: int):
    db.execute(f''' SELECT confirma_pagamento({idCompra});''')
    return {'Status': 'Confirmado'}

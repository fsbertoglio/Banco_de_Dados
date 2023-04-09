
-- Usando subconsultas
	-- sem subconsulta
SELECT L.nome, COUNT(*), MAX(AL.nota) MaiorNota, MIN(AL.nota), AVG(AL.nota)
FROM AvaliacoesLoja AL
JOIN Lojas L ON AL.idloja = L.idloja
GROUP BY L.nome;

	-- com subconsulta
SELECT DISTINCT L.nome, AL.nota
FROM avaliacoesloja AL
NATURAL JOIN Lojas L
WHERE AL.nota IN (
  SELECT MAX(AL.nota)
  FROM AvaliacoesLoja AL
  GROUP BY AL.idloja
);



-- ### CONSULTAS PARA A PARTE 2 DO TRABALHO FINAL ###



-- 1. buscar administrador por id e as Lojas que ele administra
SELECT DISTINCT A.nome nome_administrador, AL.idloja, L.nome nome_administrador
FROM Administradores_Lojas AL
JOIN Administradores A ON A.idUser = AL.idadministrador
JOIN Lojas L ON L.idloja = AL.idloja
WHERE AL.idadministrador = 2
ORDER BY AL.idloja;

-- 2. buscar loja por nome e a lista de seus administradores
SELECT DISTINCT L.idloja, L.nome nome_loja, A.idUser, A.nome nome_administrador
FROM Administradores_Lojas AL
JOIN Administradores A ON A.idUser = AL.idAdministrador
JOIN Lojas L ON L.idloja = AL.idloja
WHERE L.nome like '%Farmacia%'
ORDER BY A.idUser;

-- 3. buscar cliente por id e mostrar as compras que ele realizou
SELECT DISTINCT Cli.iduser, Cli.nome nome_cliente, Com.idCarrinho, Com.datahora, Com.valor, Pag.foiConfirmado, Pag.dataHoraPagamento
FROM Clientes Cli
JOIN Compras Com ON Com.idCliente = Cli.idUser
JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
where Cli.idUser = 1;

-- 4. buscar cliente por id e mostrar as avaliações que ele realizou
SELECT DISTINCT Cli.iduser, Cli.nome nome_cliente, AL.idloja, L.nome nome_loja, AL.nota, AL.comentario
FROM Clientes Cli
JOIN AvaliacoesLoja AL ON AL.idCliente = Cli.idUser
JOIN Lojas L ON L.idloja = AL.idloja
WHERE Cli.idUser = 1;

-- 5. Listar pagamentos pendentes de um cliente, ou seja, que não foram confirmados
SELECT DISTINCT Cli.iduser, cli.nome nome_cliente, Pendentes.idCarrinho, Pendentes.datahora, Pendentes.valor
  FROM Clientes Cli
  JOIN (
    SELECT DISTINCT Com.idCliente, Com.idCarrinho, Com.datahora, Com.valor, Pag.foiConfirmado, Pag.dataHoraPagamento
    FROM Compras Com
    JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
    WHERE Pag.foiConfirmado = false
  ) AS Pendentes ON Pendentes.idCliente = Cli.idUser
  WHERE Cli.idUser = 1;

-- 6. Listar vendas de um uma loja (pode colocar filtros por mês, ano, etc)
SELECT DISTINCT L.idloja, L.nome nome_loja, Conf.idCarrinho, Conf.datahora, Conf.valor, conf.dataHoraPagamento
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Com.idCarrinho, Com.datahora, Com.valor, Pag.dataHoraPagamento
    FROM Compras Com
    JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
      WHERE Pag.foiConfirmado = true
  ) AS conf ON Conf.idloja = L.idloja
  WHERE L.idloja = 1;


-- 7. Somar lucro de vendas de uma loja (pode colocar filtros por mês, ano, etc)


-- 8. Listar clientes devedores de uma loja (que tem compras não confirmadas)




--  VIEWS
-- View para facilitar visão das notas atribuidas a cada loja

CREATE OR REPLACE VIEW Visao_Produtos AS
  SELECT P.idproduto, P.nome nome_produto, L.idloja, L.nome nome_loja, P.descricao, P.valor, P.quantidade, P.categoria
    FROM produtos P
      JOIN lojas L ON L.idloja = P.idloja;

CREATE OR REPLACE VIEW Visao_Avaliacoes_Produtos AS
    SELECT DISTINCT P.idproduto, P.idloja, avg(ap.nota) mediaAvaliacoes, COUNT(ap.nota) numAvaliacoes
    FROM avaliacoesproduto ap
      JOIN produtos P ON p.idproduto = ap.idproduto
	GROUP BY P.idproduto, P.idloja;

  --Visão FInal
CREATE OR REPLACE VIEW Visao_Geral_Produtos AS
  SELECT DISTINCT P.idloja, P.idproduto, P.nome nome_produto, L.nome nome_loja, P.descricao, P.valor, P.quantidade, P.categoria, VAP.mediaavaliacoes, VAP.numavaliacoes
    FROM produtos P
      JOIN lojas L ON L.idloja = P.idloja
      JOIN Visao_Avaliacoes_Produtos VAP ON (P.idproduto = VAP.idproduto AND P.idloja = VAP.idloja);

SELECT *
FROM Visao_Geral_Produtos
ORDER BY idloja

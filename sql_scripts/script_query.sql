-- 2.a) Visão Útil  ##################
-- View para facilitar visão das notas atribuidas a cada loja
CREATE OR REPLACE VIEW Visao_Avaliacoes_Produtos AS
    SELECT DISTINCT P.idproduto, P.idloja, avg(ap.nota) mediaAvaliacoes, COUNT(ap.nota) numAvaliacoes
    FROM avaliacoesproduto ap
      JOIN produtos P ON p.idproduto = ap.idproduto
	GROUP BY P.idproduto, P.idloja;

  --Visão FInal co informações completas das avaliações
CREATE OR REPLACE VIEW Visao_Geral_Produtos AS
  SELECT DISTINCT P.idloja, P.idproduto, P.nome nome_produto, L.nome nome_loja, P.descricao, P.valor, P.quantidade, P.categoria, VAP.mediaavaliacoes, VAP.numavaliacoes
    FROM produtos P
      JOIN lojas L ON L.idloja = P.idloja
      JOIN Visao_Avaliacoes_Produtos VAP ON (P.idproduto = VAP.idproduto AND P.idloja = VAP.idloja);

-- 2.b) CONSULTAS PARA A PARTE 2 DO TRABALHO FINAL ##################
-- 1. buscar administrador por id e as Lojas que ele administra
SELECT DISTINCT A.nome nome_administrador, AL.idloja, L.nome nome_administrador
FROM Administradores_Lojas AL
JOIN Administradores A ON A.idUser = AL.idadministrador
JOIN Lojas L ON L.idloja = AL.idloja
WHERE AL.idadministrador = 2 --PARAMETRO
ORDER BY AL.idloja;

-- 2. buscar loja por nome e a lista de seus administradores
SELECT DISTINCT L.idloja, L.nome nome_loja, A.idUser, A.nome nome_administrador
FROM Administradores_Lojas AL
JOIN Administradores A ON A.idUser = AL.idAdministrador
JOIN Lojas L ON L.idloja = AL.idloja
WHERE L.nome like '%Farmacia%' --PARAMETRO
ORDER BY A.idUser;

-- 3. buscar cliente por id e mostrar as compras que ele realizou
SELECT DISTINCT Cli.iduser, Cli.nome nome_cliente, Com.idCarrinho, Com.datahora, Com.valor, Pag.foiConfirmado, Pag.dataHoraPagamento
FROM Clientes Cli
JOIN Compras Com ON Com.idCliente = Cli.idUser
JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
where Cli.idUser = 1; --PARAMETRO

-- 4. buscar cliente por id e mostrar as avaliações que ele realizou
SELECT DISTINCT Cli.iduser, Cli.nome nome_cliente, AL.idloja, L.nome nome_loja, AL.nota, AL.comentario
FROM Clientes Cli
JOIN AvaliacoesLoja AL ON AL.idCliente = Cli.idUser
JOIN Lojas L ON L.idloja = AL.idloja
WHERE Cli.idUser = 1; --PARAMETRO

-- 5. Listar pagamentos pendentes de um cliente, ou seja, que não foram confirmados
-- SUBCONSULTA
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
WHERE Cli.iduser = 2; --PARÂMETRO

-- 6. Listar vendas de um uma loja (pode colocar filtros por mês, ano, etc)
SELECT DISTINCT L.idloja, L.nome nome_loja, Conf.idCarrinho, Conf.datahora, Conf.valor, conf.dataHoraPagamento
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Com.idCarrinho, Com.datahora, Com.valor, Pag.dataHoraPagamento
    FROM Compras Com
    JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
      WHERE Pag.foiConfirmado = true
  ) AS conf ON Conf.idloja = L.idloja
  WHERE L.idloja = 1; --PARAMETRO

-- 7. Somar lucro de vendas de uma loja (pode colocar filtros por mês, ano, etc)
-- GROUP BY, SUBCONSULTA
SELECT DISTINCT L.idloja, L.nome nome_loja, SUM(Conf.valor) lucro
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Com.idCarrinho, Com.datahora, Com.valor, Pag.dataHoraPagamento
    FROM Compras Com
    JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
      WHERE Pag.foiConfirmado = true
  ) AS conf ON Conf.idloja = L.idloja
  WHERE L.idloja = 8 --PARAMETRO
  GROUP BY L.idloja, L.nome;

-- 8. Listar clientes devedores de uma loja (que tem compras não confirmadas)
-- SUBCONSULTA
SELECT DISTINCT L.idloja, L.nome nome_loja, Cli.iduser, Cli.nome nome_cliente, Pendentes.idCarrinho, Pendentes.datahora, Pendentes.valor
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Com.idCarrinho, Com.datahora, Com.valor, Pag.foiConfirmado, Pag.dataHoraPagamento, Com.idCliente
    FROM Compras Com
    JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
      WHERE Pag.foiConfirmado = false
  ) AS Pendentes ON Pendentes.idloja = L.idloja
  JOIN Clientes Cli ON Cli.idUser = Pendentes.idCliente
  WHERE L.idloja = 2; --PARAMETRO


-- 9. Listar produtos con filtro de mais vendidos de uma loja (pode colocar filtros por mês, ano, etc)
-- SUBCONSULTA, GROUP BY
SELECT DISTINCT L.idloja, L.nome nome_loja, Prod.idproduto, Prod.nome nome_produto, SUM(Prod.quantidade) quantidade_vendida
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Prod.idproduto, Prod.nome, Prod.quantidade
    FROM Produtos_Carrinho PD
    JOIN Produtos Prod ON (Prod.idproduto = PD.idproduto AND Prod.idloja = PD.idloja)
    JOIN Compras Com ON Com.idCarrinho = PD.idCarrinho
  ) AS Prod ON Prod.idloja = L.idloja
  --WHERE L.idloja = 8 --PARAMETRO
  GROUP BY L.idloja, L.nome, Prod.idproduto, Prod.nome
  ORDER BY quantidade_vendida DESC;

-- 10. Listar clientes de uma loja (que tem compras confirmadas) e que não realizaram avaliação
-- NOT EXISTS, SUBCONSULTA
SELECT DISTINCT L.idloja, L.nome nome_loja, Cli.iduser, Cli.nome nome_cliente, confirmadas.idCarrinho idCompra, confirmadas.datahora, confirmadas.valor
  FROM Lojas L
  JOIN (
    SELECT DISTINCT Com.idloja, Com.idCliente, Com.idCarrinho, Com.datahora, Com.valor, Pag.foiConfirmado, Pag.dataHoraPagamento
    FROM Compras Com
    JOIN Pagamentos Pag ON Com.idCarrinho = Pag.idCompra
    WHERE Pag.foiConfirmado = TRUE
  ) AS confirmadas ON confirmadas.idloja = L.idloja
  JOIN Clientes Cli ON Cli.idUser = confirmadas.idCliente
    --WHERE L.idloja = 1 -- PODEMOS POR PARAMETRO E SELECIONAR UMA LOJA
  AND NOT EXISTS (
    SELECT *
    FROM AvaliacoesLoja AL
    WHERE AL.idCliente = confirmadas.idCliente AND AL.idloja = confirmadas.idloja
  );

  -- 11. Listar lojas que possuem avaliação maior ou igual a 3 que tenham produtos de uma determinada categoria
  -- SUBCONSULTA, GROUP BY, HAVING
  SELECT L.idloja, L.nome, AVG(AL.nota) media
    FROM Lojas L
    JOIN AvaliacoesLoja AL ON AL.idloja = L.idloja
    JOIN (
      SELECT Prod.idloja, Prod.idproduto, Prod.nome, Prod.categoria, Prod.valor
      FROM Produtos Prod
      WHERE Prod.categoria = 'Eletrônico' --PARAMETRO Para escolha da categoria
    ) AS Prod ON Prod.idloja = L.idloja
    GROUP BY L.idloja, L.nome
    HAVING AVG(AL.nota) >= 3
    ORDER BY AVG(AL.nota) DESC;

  -- 12. Listar produtos que possuem avaliação maior ou igual a 3
  -- VIEW
  SELECT *
    FROM Visao_Geral_Produtos
    WHERE mediaAvaliacoes >= 3 AND idloja = 1 --PARAMETRO
    ORDER BY mediaAvaliacoes DESC; 

  -- 13. Listar produtos de menor à maior valor
  --VIEW
  SELECT *
    FROM Visao_Geral_Produtos
    WHERE idloja = 1 --PARAMETRO
    ORDER BY valor ASC;

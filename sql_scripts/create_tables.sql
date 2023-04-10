-- !
DROP SCHEMA IF EXISTS public  CASCADE;
CREATE SCHEMA public;

CREATE TABLE Usuarios (
  idUser INTEGER NOT NULL,
  senha CHAR(32) NOT NULL,
  nome VARCHAR(60) NOT NULL,
  email VARCHAR(60) NOT NULL,
  telefone VARCHAR(20),
  PRIMARY KEY (idUser)
);

CREATE TABLE Administradores (
  cnpj char(14) NOT NULL,
  PRIMARY KEY (idUser)
) INHERITS (Usuarios);

CREATE TABLE Clientes (
  cep CHAR(8) NOT NULL,
  rua VARCHAR(60) NOT NULL,
  numeroEnd SMALLINT NOT NULL,
  PRIMARY KEY (idUser)
) INHERITS (Usuarios);

CREATE TABLE Lojas (
  idLoja INTEGER NOT NULL,
  nome VARCHAR(60) NOT NULL UNIQUE,
  link VARCHAR(60) NOT NULL UNIQUE,
  telefone VARCHAR(11),
  ramo VARCHAR(20) NOT NULL,
  PRIMARY KEY (idLoja)
);

CREATE TABLE Administradores_Lojas -- TABELA DE RELAÇÂO N:N
(
  idAdministrador INTEGER NOT NULL,
  idLoja INTEGER NOT NULL,
  FOREIGN KEY (idAdministrador) REFERENCES Administradores (idUser),
  FOREIGN KEY (idLoja) REFERENCES Lojas (idLoja)
);

CREATE TABLE Produtos (
  idProduto INTEGER NOT NULL,
  idLoja INTEGER NOT NULL,
  nome VARCHAR(30) NOT NULL,
  quantidade INTEGER NOT NULL,
  categoria VARCHAR(20) NOT NULL,
  valor FLOAT NOT NULL,
  descricao TEXT NOT NULL,
  cor VARCHAR(20),
  tamanho VARCHAR(20),
  FOREIGN KEY (idLoja) REFERENCES Lojas (idLoja),
  PRIMARY KEY (
    idProduto,
    idLoja
  )
);

CREATE TABLE Carrinhos (
  idCarrinho INTEGER NOT NULL,
  idCliente INTEGER NOT NULL,
  idLoja INTEGER NOT NULL,
  FOREIGN KEY (idLoja) REFERENCES Lojas (idLoja),
  FOREIGN KEY (idCliente) REFERENCES Clientes (idUser),
  PRIMARY KEY (idCarrinho)
);

CREATE TABLE Produtos_Carrinho -- TABELA DE RELAÇÂO N:N
(
  idCarrinho INTEGER NOT NULL,
  idProduto INTEGER NOT NULL,
  idLoja INTEGER NOT NULL,
  quantidade INTEGER NOT NULL,
  FOREIGN KEY (idCarrinho) REFERENCES Carrinhos (idCarrinho),
  FOREIGN KEY (idLoja, idProduto) REFERENCES Produtos (idLoja, idProduto)
);

CREATE TABLE Metodos (
  idMetodo INTEGER NOT NULL,
  nome VARCHAR(20) NOT NULL,
  parcelas INTEGER NOT NULL,
  PRIMARY KEY (idMetodo),
  CONSTRAINT Metodo_tipos CHECK (
    nome in (
      'Credito',
      'Debito',
      'Pix',
      'Boleto'
    )
  ),
  CONSTRAINT check_parcelas CHECK (
    (
      nome <> 'Credito'
      AND parcelas = 1
    )
    OR (
      nome = 'Credito'
      AND parcelas >= 1
      AND parcelas <= 12
    )
  )
);

CREATE TABLE Compras (
  dataHora TIMESTAMP NOT NULL,
  valor FLOAT NOT NULL DEFAULT 0,
  idMetodo INTEGER NOT NULL  DEFAULT 1,
  PRIMARY KEY (idCarrinho),
  FOREIGN KEY (idCarrinho) REFERENCES Carrinhos (idCarrinho),
    FOREIGN KEY (idMetodo) REFERENCES Metodos (idMetodo)
) INHERITS (Carrinhos);

CREATE TABLE Pagamentos (
  idCompra INTEGER NOT NULL,
  foiConfirmado BOOLEAN NOT NULL,
  dataHoraPagamento TIMESTAMP,
  FOREIGN KEY (idCompra) REFERENCES Compras (idCarrinho),
  PRIMARY KEY (idCompra)
);

CREATE TABLE Avaliacoes (
  idCliente INTEGER NOT NULL,
  nota SMALLINT NOT NULL,
  comentario TEXT,
  FOREIGN KEY (idCliente) REFERENCES Clientes (idUser),
  PRIMARY KEY (idCliente), 
  CONSTRAINT check_nota CHECK (
    nota >= 0
    AND nota <= 5
  )
);

CREATE TABLE AvaliacoesLoja (
  idLoja INTEGER NOT NULL,
  FOREIGN KEY (idLoja) REFERENCES Lojas (idLoja),
  PRIMARY KEY (
    idCliente,
    idLoja
  )
) INHERITS (Avaliacoes);
CREATE TABLE AvaliacoesProduto (
  idLojaProduto INTEGER NOT NULL,
  idProduto INTEGER NOT NULL,
  FOREIGN KEY (
    idProduto,
    idLojaProduto
  ) REFERENCES Produtos (idProduto, idLoja),
  PRIMARY KEY (
    idCliente,
    idLojaProduto,
    idProduto
  )
) INHERITS (Avaliacoes);

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


-- 2.c) DEFINIÇÃO DE PROCEDURE > TRIGGER + FUNCTION ##################

-- 1. Definição de uma função de inserção automatica na tabela Pagamentos à medida que uma compra é realizada, usando as informação provenientes da compra.
CREATE OR REPLACE FUNCTION insere_pagamento() RETURNS TRIGGER AS $$
DECLARE
  id_compra INTEGER;
BEGIN
  id_compra := NEW.idcarrinho;
  INSERT INTO Pagamentos (idCompra, foiConfirmado, dataHoraPagamento)
  VALUES (id_compra, false, NULL);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

  -- 1.1. Trigger
CREATE OR REPLACE TRIGGER cria_pagamento AFTER INSERT ON Compras
FOR EACH ROW EXECUTE PROCEDURE insere_pagamento();

-- 2. Definição de uma função que atualiza o valor da compra com base no custo dos produtos e quantidade.
CREATE OR REPLACE FUNCTION atualiza_valor_compra() 
RETURNS TRIGGER AS $$
DECLARE 
  valor_compra FLOAT;
BEGIN
  SELECT SUM(P.valor * P_C.quantidade) INTO valor_compra
  FROM Produtos_Carrinho P_C
  JOIN Produtos P ON (P.idProduto = P_C.idProduto AND P.idLoja = P_C.idLoja)
  WHERE P_C.idCarrinho = NEW.idCarrinho;

  UPDATE Compras SET valor = valor_compra WHERE idCarrinho = NEW.idCarrinho;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

  -- 2.1. Trigger
CREATE OR REPLACE TRIGGER atualiza_valor AFTER INSERT ON Compras
FOR EACH ROW EXECUTE PROCEDURE atualiza_valor_compra();

-- 3. Definição de uma função que confirma o pagamento de uma compra.
CREATE OR REPLACE FUNCTION confirma_pagamento(id_compra INTEGER)
RETURNS INTEGER AS $$
DECLARE 
  sel_id_compra INTEGER;
BEGIN  
  sel_id_compra = id_compra;
  UPDATE Pagamentos SET foiConfirmado = true, dataHoraPagamento = NOW()
  WHERE idCompra = sel_id_compra;
RETURN 1;
END;
$$ LANGUAGE plpgsql;
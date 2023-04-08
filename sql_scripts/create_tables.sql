-- !
DROP SCHEMA public CASCADE;

CREATE SCHEMA public;

CREATE TABLE
  Usuarios (
    idUser INTEGER NOT NULL,
    senha CHAR(32) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(60) NOT NULL,
    telefone VARCHAR(20),
    PRIMARY KEY (idUser)
  );

CREATE TABLE
  Administradores (
    cnpj char(14) NOT NULL,
    PRIMARY KEY (idUser)
  ) INHERITS (Usuarios);

CREATE TABLE
  Clientes (
    cep CHAR(8) NOT NULL,
    rua VARCHAR(60) NOT NULL,
    numeroEnd SMALLINT NOT NULL,
    PRIMARY KEY (idUser)
  ) INHERITS (Usuarios);

CREATE TABLE
  Lojas (
    idLoja INTEGER NOT NULL,
    nome VARCHAR(60) NOT NULL UNIQUE,
    link VARCHAR(60) NOT NULL UNIQUE,
    telefone VARCHAR(11),
    ramo VARCHAR(20) NOT NULL,
    PRIMARY KEY (idLoja)
  );

CREATE TABLE
  Administradores_Lojas -- TABELA DE RELAÇÂO N:N
  (
    idAdministrador INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    FOREIGN KEY (idAdministrador) REFERENCES Administradores (idUser),
    FOREIGN KEY (idLoja) REFERENCES Lojas (idLoja)
  );

CREATE TABLE
  Produtos (
    idProduto INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL UNIQUE,
    quantidade INTEGER NOT NULL,
    categoria VARCHAR(20) NOT NULL,
    valor FLOAT NOT NULL,
    descricao TEXT NOT NULL,
    cor VARCHAR(20),
    tamanho VARCHAR(20),
    FOREIGN KEY (idLoja) REFERENCES Lojas (idLoja),
    PRIMARY KEY (idProduto, idLoja)
  );

CREATE TABLE
  Carrinhos (
    idCarrinho INTEGER NOT NULL,
    idCliente INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    FOREIGN KEY (idLoja) REFERENCES Lojas (idLoja),
    FOREIGN KEY (idCliente) REFERENCES Clientes (idUser),
    PRIMARY KEY (idCarrinho)
  );

CREATE TABLE
  Produtos_Carrinho -- TABELA DE RELAÇÂO N:N
  (
    idCarrinho INTEGER NOT NULL,
    idProduto INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    FOREIGN KEY (idCarrinho) REFERENCES Carrinhos (idCarrinho),
    FOREIGN KEY (idLoja, idProduto) REFERENCES Produtos (idLoja, idProduto)
  );

CREATE TABLE
  Compras (
    dataHora TIMESTAMP NOT NULL,
    valor FLOAT NOT NULL,
    PRIMARY KEY (idCarrinho),
    FOREIGN KEY (idCarrinho) REFERENCES Carrinhos (idCarrinho)
  ) INHERITS (Carrinhos);

CREATE TABLE
  Metodos (
    idMetodo INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    parcelas INTEGER NOT NULL,
    PRIMARY KEY (idMetodo)
  );

CREATE TABLE
  Pagamentos (
    idCompra INTEGER NOT NULL,
    foiConfirmado BOOLEAN NOT NULL,
    idMetodo INTEGER NOT NULL,
    dataHoraPagamento TIMESTAMP NOT NULL,
    FOREIGN KEY (idCompra) REFERENCES Compras (idCarrinho),
    FOREIGN KEY (idMetodo) REFERENCES Metodos (idMetodo),
    PRIMARY KEY (idCompra)
  );

CREATE TABLE
  Avaliacoes (
    idCliente INTEGER NOT NULL,
    nota SMALLINT NOT NULL,
    comentario TEXT,
    FOREIGN KEY (idCliente) REFERENCES Clientes (idUser),
    PRIMARY KEY (idCliente)
  );

CREATE TABLE
  AvaliacoesLoja (
    idLoja INTEGER NOT NULL,
    FOREIGN KEY (idLoja) REFERENCES Lojas (idLoja),
    PRIMARY KEY (idCliente, idLoja)
  ) INHERITS (Avaliacoes);

CREATE TABLE
  AvaliacoesProduto (
    idLojaProduto INTEGER NOT NULL,
    idProduto INTEGER NOT NULL,
    FOREIGN KEY (idProduto, idLojaProduto) REFERENCES Produtos (idProduto, idLoja),
    PRIMARY KEY (idCliente, idLojaProduto, idProduto)
  ) INHERITS (Avaliacoes);

ALTER TABLE Metodos ADD CONSTRAINT Metodo_tipos CHECK (nome in ('Credito', 'Debito', 'Pix', 'Boleto'));

ALTER TABLE Metodos
ALTER COLUMN parcelas
SET DEFAULT 1;

ALTER TABLE Metodos ADD CONSTRAINT check_parcelas CHECK (
  (
    nome <> 'Credito'
    AND parcelas = 1
  )
  OR (
    nome = 'Credito'
    AND parcelas >= 1
    AND parcelas <= 12
  )
);

ALTER TABLE Avaliacoes ADD CONSTRAINT check_nota CHECK (
  nota >= 0
  AND nota <= 5
);

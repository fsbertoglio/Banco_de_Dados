-- !

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE Administradores
(
    id INTEGER NOT NULL,
    senha VARCHAR(20) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(60) NOT NULL,
    telefone VARCHAR(20),
    PRIMARY KEY(id)
);

CREATE TABLE Clientes
(
    id INTEGER NOT NULL,
    senha VARCHAR(20) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(60) NOT NULL,
    telefone VARCHAR(20),
    cep VARCHAR(10),
    rua VARCHAR(60) NOT NULL,
    numeroEnd INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Lojas
(
    id INTEGER NOT NULL,
    nome VARCHAR(60) NOT NULL,
    link VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    ramo VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Administradores_Lojas -- TABELA DE RELAÇÂO N:N
(
    idAdministrador INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    FOREIGN KEY (idAdministrador) REFERENCES Administradores(id),
    FOREIGN KEY (idLoja) REFERENCES Lojas(id)
);

CREATE TABLE Produtos
(
    id INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    quantidade INTEGER NOT NULL,
    categoria VARCHAR(20) NOT NULL,
    valor FLOAT NOT NULL,
    descricao TEXT NOT NULL,
    cor VARCHAR(20),
    tamanho VARCHAR(20),
    FOREIGN KEY(idLoja) REFERENCES Lojas(id),
    PRIMARY KEY (id, idLoja)
);

CREATE TABLE Carrinhos
(
    id INTEGER NOT NULL,
    idCliente INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    FOREIGN KEY(idLoja) REFERENCES Lojas(id),
    FOREIGN KEY(idCliente) REFERENCES Clientes(id),
    PRIMARY KEY(id)
);

CREATE TABLE Produtos_Carrinho -- TABELA DE RELAÇÂO N:N
(
    idCarrinho INTEGER NOT NULL,
    idProduto INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    FOREIGN KEY(idCarrinho) REFERENCES Carrinhos(id),
    FOREIGN KEY(idLoja, idProduto) REFERENCES Produtos(idLoja, id)
);
 
CREATE TABLE Compras
(
    dataHora TIMESTAMP NOT NULL,
    valor FLOAT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES Carrinhos(id)
) INHERITS(Carrinhos);

CREATE TABLE Metodos
(
    id INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    parcelas INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Pagamentos
(
    foiConfirmado BOOLEAN NOT NULL,
    idMetodo INTEGER NOT NULL,
    dataHoraPagamento TIMESTAMP NOT NULL,
    FOREIGN KEY(id) REFERENCES Compras(id),
    FOREIGN KEY (idMetodo) REFERENCES Metodos(id),
    PRIMARY KEY(id)
) INHERITS(Compras);

CREATE TABLE Avaliacoes
(
    idCliente INTEGER NOT NULL,
    nota INTEGER NOT NULL,
    comentario TEXT,
    FOREIGN KEY(idCliente) REFERENCES Clientes(id),
    PRIMARY KEY (idCliente)
);

CREATE TABLE AvaliacoesLoja
(
    idLoja INTEGER NOT NULL,
    FOREIGN KEY(idLoja) REFERENCES Lojas(id),
    PRIMARY KEY(idCliente, idLoja)
) INHERITS(Avaliacoes);

CREATE TABLE AvaliacoesProduto
(
    idLojaProduto INTEGER NOT NULL,
    idProduto INTEGER NOT NULL,
    FOREIGN KEY(idProduto, idLojaProduto) REFERENCES Produtos(id, idLoja),
    PRIMARY KEY(idCliente, idLojaProduto, idProduto)
) INHERITS(Avaliacoes);

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
    idAdministrador INTEGER NOT NULL,
    ramo VARCHAR(20) NOT NULL,
    FOREIGN KEY (idAdministrador) REFERENCES Administradores(id),
    PRIMARY KEY (id)
);

CREATE TABLE Produtos
(
    id INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    categoria VARCHAR(20) NOT NULL,
    valor FLOAT NOT NULL,
    descricao TEXT NOT NULL,
    cor VARCHAR(20),
    tamanho VARCHAR(20),
    FOREIGN KEY(idLoja) REFERENCES Lojas(id),
    PRIMARY KEY (id, idLoja)
);

CREATE TABLE Estoques
(
    idLoja INTEGER NOT NULL,
    FOREIGN KEY(idLoja) REFERENCES Lojas(id),
    PRIMARY KEY (idLoja)
);

CREATE TABLE Carrinhos
(
    idLoja INTEGER NOT NULL,
    idCliente INTEGER NOT NULL,
    dataHora TIMESTAMP NOT NULL,
    FOREIGN KEY(idLoja) REFERENCES Lojas(id),
    FOREIGN KEY(idCliente) REFERENCES Clientes(id),
    PRIMARY KEY(idLoja, idCliente, dataHora)
);
 
CREATE TABLE Compras
(
    dataHora TIMESTAMP NOT NULL,
    valor FLOAT NOT NULL
) INHERITS(Carrinhos);

CREATE TABLE Pagamentos
(
    foiConfirmado BOOLEAN NOT NULL,
    idMetodo INTEGER NOT NULL,
    dataHoraPagamento TIMESTAMP NOT NULL
) INHERITS(Compras);

CREATE TABLE Metodos
(
    id INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    parcelas INTEGER NOT NULL,
    PRIMARY KEY(id)
);
 


-- Necessario criar tabela de relação n-n entre estoque_produto
-- Necessário criar tabela de relação n-n entre produto-carrinho
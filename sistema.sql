

-- drop table if exists Administradores;
-- drop table if exists Clientes;
-- drop table if exists Lojas;
-- drop table if exists Produtos;
-- drop table if exists Estoques;
-- drop table if exists Carrinhos;
-- drop table if exists Compras;
-- drop table if exists Pagamentos;
-- drop table if exists Metodos;



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
    id INTEGER NOT NULL,
    idCliente INTEGER NOT NULL,
    idLoja INTEGER NOT NULL,
    FOREIGN KEY(idLoja) REFERENCES Lojas(id),
    FOREIGN KEY(idCliente) REFERENCES Clientes(id),
    PRIMARY KEY(id)
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


-- Necessario criar tabela de relação n-n entre estoque_produto
-- Necessário criar tabela de relação n-n entre produto-carrinho
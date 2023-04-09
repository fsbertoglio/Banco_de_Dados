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


-- Fill tables

-- Clientes VALUES (id,senha,nome,email,'telefone', 'cep', 'endereço', numEndereço);
INSERT INTO Clientes VALUES (1,'aaaaa','João da Silva','joão@gmail.com','51999999999', '00000000', 'av. joão pessoa', 200);
INSERT INTO Clientes VALUES (2,'bb12','Ana','ana@gmail.com','51999999999', '00000000', 'av. joão pessoa', 200);
INSERT INTO Clientes VALUES (3,'vcccc','cleber antonio','ca@gmail.com','51999999999', '04440000', 'av. joão pessoa', 250);
INSERT INTO Clientes VALUES (4,'12345','Maria Souza','maria@gmail.com','51988888888', '01001000', 'Rua Augusta', 100);
INSERT INTO Clientes VALUES (5,'pass123','Lucas Pereira','lucas@hotmail.com','51977777777', '90230060', 'Rua Doutor Timóteo', 500);
INSERT INTO Clientes VALUES (6,'senha123','Larissa Ferreira','larissa@gmail.com','51966666666', '90610030', 'Avenida Protásio Alves', 1500);
INSERT INTO Clientes VALUES (7,'qwerty','Pedro Henrique','pedroh@gmail.com','51955555555', '91520000', 'Avenida Assis Brasil', 2500);
INSERT INTO Clientes VALUES (8,'123abc','Camila Oliveira','camila@gmail.com','51944444444', '90830350', 'Rua Marechal Floriano', 700);
INSERT INTO Clientes VALUES (9,'abcd123','Rafael Rodrigues','rafaelr@hotmail.com','51933333333', '90420120', 'Rua Gonçalo de Carvalho', 400);
INSERT INTO Clientes VALUES (10,'senha1234','Fernanda Nunes','fernanda@gmail.com','51922222222', '90550070', 'Rua Ramiro Barcelos', 800);
INSERT INTO Clientes VALUES (11,'pass1234','Paulo Souza','paulosouza@gmail.com','51911111111', '90880210', 'Rua Cel. Bordini', 200);
INSERT INTO Clientes VALUES (12,'teste123','Bruna Lima','bruna@hotmail.com','51888888888', '91760010', 'Avenida do Forte', 1500);
INSERT INTO Clientes VALUES (13,'abc123','Mateus Alves','mateusalves@gmail.com','51877777777', '90810280', 'Rua Castro Alves', 350);
INSERT INTO Clientes VALUES (14,'1234abcd','Júlia Pereira','julia@hotmail.com','51866666666', '90050140', 'Rua Gen. Lima e Silva', 1000);
INSERT INTO Clientes VALUES (15,'abcd1234','Luiz Felipe','luizfelipe@gmail.com','51855555555', '90820210', 'Rua Anita Garibaldi', 300);
INSERT INTO Clientes VALUES (16,'senha12345','Isabella Santos','isabella@hotmail.com','51844444444', '90880180', 'Rua Luciana de Abreu', 700);
INSERT INTO Clientes VALUES (17,'abc12345','Guilherme Silva','guilherme@gmail.com','51833333333', '90550100', 'Rua Casemiro de Abreu', 800);
INSERT INTO Clientes VALUES (18,'pass12345','Mariana Torres','mariana@hotmail.com','51822222222', '90620120', 'Rua Coronel Feijó', 200);
INSERT INTO Clientes VALUES (19,'abcd12345','Leonardo Almeida','leonardoalmeida@gmail.com','51811111111', '90050350', 'Rua Sarmento Leite', 900);
INSERT INTO Clientes VALUES (20,'senha123456','Carla Pereira','carlapereira@hotmail.com','51888888888', '91320390', 'Avenida Goethe', 1000);


-- Administradores VALUES (id,'senha','nome','email','telefone', 'cnpj');
INSERT INTO Administradores VALUES (1,'aaaaa','André da Silva','andré@gmail.com','51999999999', '00000000011223');
INSERT INTO Administradores VALUES (2,'aaaaa','Bruno da Silva','bruno@gmail.com','51999999999', '00000000004567');
INSERT INTO Administradores VALUES (3,'ccccc','Cleber da Silva','cleber@gmail.com','51999999999', '00000000005672');
INSERT INTO Administradores VALUES (4,'senha123','Carla Santos','carla@gmail.com','51988888888', '11111111000101');
INSERT INTO Administradores VALUES (5,'adm123','Lucas Oliveira','lucas@gmail.com','51977777777', '22222222000102');
INSERT INTO Administradores VALUES (6,'admin','Fernanda Martins','fernanda@gmail.com','51966666666', '33333333000103');
INSERT INTO Administradores VALUES (7,'123456','Rafael Souza','rafael@gmail.com','51955555555', '44444444000104');
INSERT INTO Administradores VALUES (8,'senhaadmin','Juliana Pereira','juliana@gmail.com','51944444444', '55555555000105');
INSERT INTO Administradores VALUES (9,'admin123','Rodrigo Santos','rodrigo@gmail.com','51933333333', '66666666000106');
INSERT INTO Administradores VALUES (10,'teste123','Mariana Oliveira','mariana@gmail.com','51922222222', '77777777000107');
INSERT INTO Administradores VALUES (11,'admin123','Fábio Almeida','fabio@gmail.com','51911111111', '88888888000108');
INSERT INTO Administradores VALUES (12,'123456789','Luciana Souza','luciana@gmail.com','51900000000', '99999999000109');
INSERT INTO Administradores VALUES (13,'senha123','Thiago Martins','thiago@gmail.com','51888888888', '10101010000110');
INSERT INTO Administradores VALUES (14,'adm123','Gustavo Oliveira','gustavo@gmail.com','51877777777', '11111111000111');
INSERT INTO Administradores VALUES (15,'admin','Carolina Santos','carolina@gmail.com','51866666666', '12121212000112');

-- Lojas VALUES (id, 'nome', 'link', 'fone' 'ramo');
INSERT INTO Lojas VALUES (1, 'Armazem do Campo', 'armazemdocampo.com.br', '51988888888', 'alimentos');
INSERT INTO Lojas VALUES (2, 'Tech Zone', 'techzone.com.br', '51977777777', 'tecnologia');
INSERT INTO Lojas VALUES (3, 'Moda e Cia', 'modaecia.com.br', '51966666666', 'roupas');
INSERT INTO Lojas VALUES (4, 'Toy Store', 'toystore.com.br', '51955555555', 'brinquedos');
INSERT INTO Lojas VALUES (5, 'Lavanderia Express', 'lavanderiaexpress.com.br', '51944444444', 'serviços');
INSERT INTO Lojas VALUES (6, 'Delícias da Terra', 'deliciasdaterra.com.br', '51933333333', 'alimentos');
INSERT INTO Lojas VALUES (7, 'TecnoMax', 'tecnomax.com.br', '51922222222', 'tecnologia');
INSERT INTO Lojas VALUES (8, 'Fashion Trends', 'fashiontrends.com.br', '51911111111', 'roupas');
INSERT INTO Lojas VALUES (9, 'Toy Planet', 'toyplanet.com.br', '51900000000', 'brinquedos');
INSERT INTO Lojas VALUES (10, 'Limpeza Já', 'limpezaja.com.br', '51999999999', 'serviços');

-- Administradores_Lojas VALUES(idAdministrador, idLoja);
    -- loja 1
INSERT INTO Administradores_Lojas VALUES (1, 1);
    -- loja 2
INSERT INTO Administradores_Lojas VALUES (2, 2);
INSERT INTO Administradores_Lojas VALUES (3, 2);
INSERT INTO Administradores_Lojas VALUES (7, 2);
INSERT INTO Administradores_Lojas VALUES (10, 2);
    -- loja 3
INSERT INTO Administradores_Lojas VALUES (5, 3);
INSERT INTO Administradores_Lojas VALUES (9, 3);
    -- loja 4
INSERT INTO Administradores_Lojas VALUES (7, 4);
INSERT INTO Administradores_Lojas VALUES (11, 4);
INSERT INTO Administradores_Lojas VALUES (14, 4);
    -- loja 5
INSERT INTO Administradores_Lojas VALUES (2, 5);
INSERT INTO Administradores_Lojas VALUES (8, 5);
    -- loja 6
INSERT INTO Administradores_Lojas VALUES (3, 6);
INSERT INTO Administradores_Lojas VALUES (12, 6);
INSERT INTO Administradores_Lojas VALUES (15, 6);
    -- loja 7
INSERT INTO Administradores_Lojas VALUES (4, 7);
INSERT INTO Administradores_Lojas VALUES (9, 7);
INSERT INTO Administradores_Lojas VALUES (14, 7);
    -- loja 8
INSERT INTO Administradores_Lojas VALUES (1, 8);
INSERT INTO Administradores_Lojas VALUES (6, 8);
INSERT INTO Administradores_Lojas VALUES (12, 8);
    -- loja 9
INSERT INTO Administradores_Lojas VALUES (5, 9);
INSERT INTO Administradores_Lojas VALUES (13, 9);
    -- loja 10
INSERT INTO Administradores_Lojas VALUES (2, 10);
INSERT INTO Administradores_Lojas VALUES (7, 10);
INSERT INTO Administradores_Lojas VALUES (11, 10);

-- Produtos VALUES (id, idLoja, 'nome', 'quantidade', 'categoria', preço, 'descrição', 'cor', 'tamanho');
INSERT INTO Produtos VALUES (1, 1, 'abobrinha', 10, 'vegetal', 1.00, 'leguminosa que nao é parente da abobora', NULL, NULL);
INSERT INTO Produtos VALUES (2, 1, 'berinjela', 10,  'vegetal', 2.00, 'leguminosa roxa', NULL, NULL);
INSERT INTO Produtos VALUES (1, 3, 'bateria alcalina', 10, 'eletronico', 20.00, 'bateria 12 volts', NULL, 'grande');
INSERT INTO Produtos VALUES (2, 3, 'lanterna', 20, 'eletronico', 50.00, 'lanterna led', 'preta', NULL);
INSERT INTO Produtos VALUES (1, 2, 'absinto', 30, 'alcoolico', 100.00, 'garrafa de bebida alcólica', NULL, '1Litro');
INSERT INTO Produtos VALUES (2, 2, 'balantines', 40, 'alcoolico', 200.00, 'garrafa de bebida alcólica', NULL, '1Litro');

-- Carrinhos VALUES (id, idCliente, idLoja);
INSERT INTO Carrinhos VALUES(1, 1, 1);
INSERT INTO Carrinhos VALUES(2, 1, 2);
INSERT INTO Carrinhos VALUES(3, 2, 2);
INSERT INTO Carrinhos VALUES(4, 2, 3);
INSERT INTO Carrinhos VALUES(5, 3, 3);
INSERT INTO Carrinhos VALUES(6, 3, 1);

-- Produtos_Carrinho VALUES (idCarrinho, IdProduto, idLoja, quantidade);
INSERT INTO Produtos_Carrinho VALUES(1, 1, 1, 5);
INSERT INTO Produtos_Carrinho VALUES(2, 1, 2, 5);
INSERT INTO Produtos_Carrinho VALUES(3, 2, 2, 5);
INSERT INTO Produtos_Carrinho VALUES(4, 2, 3, 5);
INSERT INTO Produtos_Carrinho VALUES(5, 1, 3, 5);
INSERT INTO Produtos_Carrinho VALUES(6, 2, 1, 5);

-- Compras VALUES (id, idCliente, idLoja, dataHora, valor);
INSERT INTO Compras VALUES(1, 1, 1, NOW(), 100.00);
INSERT INTO Compras VALUES(2, 1, 2, '2021-09-02 00:00:00', 130.00);
INSERT INTO Compras VALUES(3, 2, 2, '2021-09-03 00:00:00', 140.00);
INSERT INTO Compras VALUES(4, 2, 3, '2021-09-03 00:00:00', 20.00);
INSERT INTO Compras VALUES(5, 3, 3, '2021-09-02 00:00:00', 400.00);
INSERT INTO Compras VALUES(6, 3, 1, '2021-09-01 00:00:00', 640.00);

-- Metodos VALUES (id, nome, parcelas);
INSERT INTO Metodos VALUES (1, 'Pix', 1);
INSERT INTO Metodos VALUES (2, 'Boleto', 1);
INSERT INTO Metodos VALUES (3, 'Credito', 1);
INSERT INTO Metodos VALUES (4, 'Credito', 2);
INSERT INTO Metodos VALUES (5, 'Credito', 3);
INSERT INTO Metodos VALUES (6, 'Credito', 4);

-- Pagamentos VALUES (idCompra, foiConfirmado, idMetodo, dataHora);
INSERT INTO Pagamentos VALUES (1, TRUE, 1, '2021-10-01 00:00:00');
INSERT INTO Pagamentos VALUES (3, TRUE, 3, '2021-10-01 00:00:00');
INSERT INTO Pagamentos VALUES (6, TRUE, 2, '2021-10-01 00:00:00');

-- AvaliacoesLoja VALUES (idCliente, nota, 'comentario', idLoja);
INSERT INTO AvaliacoesLoja VALUES (1, 3.0, 'mediana', 1);
INSERT INTO AvaliacoesLoja VALUES (1, 4.0, 'boa', 2);
INSERT INTO AvaliacoesLoja VALUES (2, 3.0, 'media', 1);
INSERT INTO AvaliacoesLoja VALUES (2, 3.0, 'mediana', 3);
INSERT INTO AvaliacoesLoja VALUES (3, 1.0, 'pessima', 3);
INSERT INTO AvaliacoesLoja VALUES (3, 5.0, 'excelente', 2);

-- AvaliacoesProduto VALUES (idCliente, nota, 'comentario', idLojaProduto, idProduto);
INSERT INTO AvaliacoesProduto VALUES (1, 3.0, 'mediana', 1, 1);
INSERT INTO AvaliacoesProduto VALUES (1, 4.0, 'boa', 2, 1);
INSERT INTO AvaliacoesProduto VALUES (2, 3.0, 'media', 1, 2);
INSERT INTO AvaliacoesProduto VALUES (2, 3.0, 'mediana', 3, 1);
INSERT INTO AvaliacoesProduto VALUES (3, 1.0, 'pessima', 3, 1);
INSERT INTO AvaliacoesProduto VALUES (3, 5.0, 'excelente', 2, 1);


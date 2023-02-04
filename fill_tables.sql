
-- Clientes VALUES (id,senha,nome,email,'telefone', 'cep', 'endereço', numEndereço);
INSERT INTO Clientes VALUES (1,'aaaaa','João da Silva','joão@gmail.com','51999999999', '00000000', 'av. joão pessoa', 200);
INSERT INTO Clientes VALUES (2,'bb12','Ana','ana@gmail.com','51999999999', '00000000', 'av. joão pessoa', 200);
INSERT INTO Clientes VALUES (3,'vcccc','cleber antonio','ca@gmail.com','51999999999', '04440000', 'av. joão pessoa', 250);


-- Administradores VALUES (id,'senha','nome','email','telefone');
INSERT INTO Administradores VALUES (1,'aaaaa','André da Silva','andré@gmail.com','51999999999');
INSERT INTO Administradores VALUES (2,'aaaaa','Bruno da Silva','bruno@gmail.com','51999999999');
INSERT INTO Administradores VALUES (3,'ccccc','Cleber da Silva','cleber@gmail.com','51999999999');

-- Lojas VALUES (id, 'nome', 'link', 'fone', 1dAdministrador, 'ramo');
INSERT INTO Lojas VALUES (1, 'Armazem AAA', 'armazemaa.com.br', '51999999999', 1, 'pilhas');
INSERT INTO Lojas VALUES (2, 'Boteco BBB', 'boteco.com.br', '51999999999', 2, 'bebidas');
INSERT INTO Lojas VALUES (3, 'Comercio CCC', 'comercio.com.br', '51999999999', 2, 'cebolas');

-- Produtos VALUES (id, idLoja, 'nome', 'categoria', preço, 'descrição', 'cor', 'tamanho');
INSERT INTO Produtos VALUES (1, 1, 'abobrinha', 'vegetal', 1.00, 'leguminosa que nao é parente da abobora', NULL, NULL);
INSERT INTO Produtos VALUES (2, 1, 'berinjela', 'vegetal', 2.00, 'leguminosa roxa', NULL, NULL);
INSERT INTO Produtos VALUES (1, 3, 'bateria alcalina', 'eletronico', 20.00, 'bateria 12 volts', NULL, 'grande');
INSERT INTO Produtos VALUES (2, 3, 'lanterna', 'eletronico', 50.00, 'lanterna led', 'preta', NULL);
INSERT INTO Produtos VALUES (1, 2, 'absinto', 'alcoolico', 100.00, 'garrafa de bebida alcólica', NULL, '1Litro');
INSERT INTO Produtos VALUES (2, 2, 'balantines', 'alcoolico', 200.00, 'garrafa de bebida alcólica', NULL, '1Litro');

-- Clientes VALUES (id,senha,nome,email,'telefone', 'cep', 'endereço', numEndereço);
INSERT INTO Clientes VALUES (1,'aaaaa','João da Silva','joão@gmail.com','51999999999', '00000000', 'av. joão pessoa', 200);
INSERT INTO Clientes VALUES (2,'bb12','Ana','ana@gmail.com','51999999999', '00000000', 'av. joão pessoa', 200);
INSERT INTO Clientes VALUES (3,'vcccc','cleber antonio','ca@gmail.com','51999999999', '04440000', 'av. joão pessoa', 250);

-- Administradores VALUES (id,'senha','nome','email','telefone', 'cnjp');
INSERT INTO Administradores VALUES (1,'aaaaa','André da Silva','andré@gmail.com','51999999999', '00000000000000');
INSERT INTO Administradores VALUES (2,'aaaaa','Bruno da Silva','bruno@gmail.com','51999999999', '00000000000000');
INSERT INTO Administradores VALUES (3,'ccccc','Cleber da Silva','cleber@gmail.com','51999999999', '00000000000000');

-- Lojas VALUES (id, 'nome', 'link', 'fone', 1dAdministrador, 'ramo');
INSERT INTO Lojas VALUES (1, 'Armazem AAA', 'armazemaa.com.br', '51999999999', 'pilhas');
INSERT INTO Lojas VALUES (2, 'Boteco BBB', 'boteco.com.br', '51999999999', 'bebidas');
INSERT INTO Lojas VALUES (3, 'Comercio CCC', 'comercio.com.br', '51999999999', 'cebolas');

-- Administradores_Lojas VALUES(idAdministrador, idLoja);
INSERT INTO Administradores_Lojas VALUES (1, 1);
INSERT INTO Administradores_Lojas VALUES (2, 2);
INSERT INTO Administradores_Lojas VALUES (3, 3);
INSERT INTO Administradores_Lojas VALUES (3, 1);

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
INSERT INTO Compras VALUES(1, 1, 1, '2021-09-01 00:00:00', 100.00);
INSERT INTO Compras VALUES(2, 1, 2, '2021-09-02 00:00:00', 130.00);
INSERT INTO Compras VALUES(3, 2, 2, '2021-09-03 00:00:00', 140.00);
INSERT INTO Compras VALUES(4, 2, 3, '2021-09-03 00:00:00', 20.00);
INSERT INTO Compras VALUES(5, 3, 3, '2021-09-02 00:00:00', 400.00);
INSERT INTO Compras VALUES(6, 3, 1, '2021-09-01 00:00:00', 640.00);

-- Metodos VALUES (id, nome, parcelas);
INSERT INTO Metodos VALUES (1, 'dinheiro', 1);
INSERT INTO Metodos VALUES (2, 'boleto', 1);
INSERT INTO Metodos VALUES (3, 'Crédito', 1);
INSERT INTO Metodos VALUES (4, 'Crédito', 2);
INSERT INTO Metodos VALUES (5, 'Crédito', 3);
INSERT INTO Metodos VALUES (6, 'Crédito', 4);

-- Pagamentos VALUES (idCompra, foiConfirmado, idMetodo, dataHora);
INSERT INTO Pagamentos VALUES (1, TRUE, 1, '2021-10-01 00:00:00');
INSERT INTO Pagamentos VALUES (3, TRUE, 3, '2021-10-01 00:00:00');
INSERT INTO Pagamentos VALUES (6, TRUE, 2, '2021-10-01 00:00:00');

-- AvaliacoesLoja VALUES (idCliente, nota, 'comentario', idLoja);
INSERT INTO AvaliacoesLoja VALUES (1, 7.0, 'mediana', 1);
INSERT INTO AvaliacoesLoja VALUES (1, 8.0, 'boa', 2);
INSERT INTO AvaliacoesLoja VALUES (2, 4.0, 'media', 1);
INSERT INTO AvaliacoesLoja VALUES (2, 5.0, 'mediana', 3);
INSERT INTO AvaliacoesLoja VALUES (3, 2.0, 'pessima', 3);
INSERT INTO AvaliacoesLoja VALUES (3, 10.0, 'excelente', 2);

-- AvaliacoesProduto VALUES (idCliente, nota, 'comentario', idLojaProduto, idProduto);
INSERT INTO AvaliacoesProduto VALUES (1, 7.0, 'mediana', 1, 1);
INSERT INTO AvaliacoesProduto VALUES (1, 8.0, 'boa', 2, 1);
INSERT INTO AvaliacoesProduto VALUES (2, 4.0, 'media', 1, 2);
INSERT INTO AvaliacoesProduto VALUES (2, 5.0, 'mediana', 3, 1);
INSERT INTO AvaliacoesProduto VALUES (3, 2.0, 'pessima', 3, 1);
INSERT INTO AvaliacoesProduto VALUES (3, 10.0, 'excelente', 2, 1);
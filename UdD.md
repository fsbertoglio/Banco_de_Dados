<h1> 
    Universo do Discurso
</h1>

<h2>
    Objetivo do Sistema E-Commerce
</h2>

O serviço consiste em um sistema de gerenciamento de lojas digitais. Como referência para o projeto, adotamos o [Shopify](https://shopify.com/), considerando apenas o gerenciamento das lojas e não sua criação.


- Lojas  
Enquanto ferramenta de gestão de `lojas`, o serviço permite que administradores criem seus sites de e-commerce. Cada loja possui um endereço eletrônico e tem um `administrador` responsável. As diferentes lojas podem ser acessadas pelos `clientes` cadastrados na plataforma, as `compras` ocorrem mediante inclusão de produtos no `carrinho` e da confirmação da compra.
    - nome
    - link
    - telefone
    - idAdministrador
    - ramo  

<br>

- Produtos  
Cada produto possuim um identificador próprio, recebe um nome e demais metadatos. Os produtos são inseridos no `estoque`e podem sar adicionados à um `carrinho` pelo cliente no ato de seleção de produtos a serem comprados. O `administrador` responsável pode fazer a criação e exclusão de produtos do sistema.
    - id
    - nome
    - categoria
    - valor
    - quantEstoque
    - descricao
    - cor
    - tamanho

<br>

- Estoques  
Cada loja possui um estoque que é composto pelos `produtos` que comercializa, apresentando a quantidade de produtos que estão disponíveis. A quantidade de cada produto pode variar através da inclusão ou exclusão pelo `administrador` e pode diminuir através do processo de `compra`, realizado pelo `cliente`.
    - id
    - idLoja
    - idProduto
    - quantidade

<br>

- Clientes  
A plataforma possui uma série de clientes. Cada cliente é identificado por um id de usuário, que também é utilizado para realizar login na plataforma, junto com sua senha. Os clientes Estão cadastrados junto com outros metadados necessários para identificação e entregas. Os clientes podem filtrar os `produtos` por categoria, ou outro de seus identificadores, e os incluir no carrinho. Clientes podem realizar a compra de produtos. Os clientes podem fazer `avaliações da loja` e `avaliação do produto` após realizar uma `compra`.
    -  id
    - senha
    - nome
    - email
    - telefone
    - cep
    - rua
    - numeroEnd

<br>

- Carrinhos  
Para realizar uma `compra`, o cliente faz a seleção dos `produtos` e os inclui no carrinho. O cliente pode realizar a inclusão e a exclusão de produtos do carrinho. O carrinho permite a visualização de todos os produtos selecionados e apresenta o valor total a ser pago. Após confirmação, o cliente pode realizar a compra dos produtos que estão no carrinho.
    - id
    - idCliente
    - idProduto
    - valorProduto
    - quantidade
<br>

- Compras
    - id
    - idCliente
    - idLoja
    - idCarrinho
    - valor
    - hora
    - data
<br>

- Administradores
    - id
    - senha
    - nome
    - email
    - telefone
<br>

- CaixaLoja
    - id
    - idLoja
    - idCompra
<br>

- AvaliacoesLoja
    - id
    - idCliente
    - idLoja
    - nota
    - comentario
<br>

- AvaliacoesProduto
    - id
    - idCliente
    - idLoja
    - nota
    - comentario


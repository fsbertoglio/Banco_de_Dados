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


<h1> 
    Universo do Discurso
</h1>

<h2>
    Objetivo do Sistema E-Commerce
</h2>

O serviço consiste em um sistema de gerenciamento de lojas digitais. Como referência para o projeto, adotamos o [Shopify](https://shopify.com/), considerando apenas o gerenciamento das lojas e não sua criação.


- Lojas  
Enquanto ferramenta de gestão de `lojas`, o serviço permite que administradores criem seus sites de e-commerce. Cada loja possui um endereço eletrônico e tem um `administrador` responsável. As diferentes lojas podem ser acessadas pelos `clientes` cadastrados na plataforma, as `compras` ocorrem mediante inclusão de produtos no `carrinho` e da confirmação da compra.
    - id
    - nome
    - link
    - telefone
    - idAdministrador
    - ramo  

- Produtos

    - id
    - nome
    - categoria
    - valor
    - quantEstoque
    - descricao
    - cor
    - tamanho
- Estoques
    - id
    - idProduto
    - quantidade
- Clientes
    - id
    - senha
    - nome
    - email
    - telefone
    - cep
    - rua
    - numeroEnd
- Carrinhos
    - id
    - idCliente
    - idProduto
    - valorProduto
    - quantidade
- Compras
    - id
    - idCliente
    - idLoja
    - idCarrinho
    - valor
    - hora
    - data
- Administradores
    - id
    - senha
    - nome
    - email
    - telefone
- CaixaLoja
    - id
    - idLoja
    - idCompra
- AvaliacoesLoja
    - id
    - idCliente
    - idLoja
    - nota
    - comentario
- AvaliacoesProduto
    - id
    - idCliente
    - idLoja
    - nota
    - comentario


- 
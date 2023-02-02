<h1> 
    Universo do Discurso
</h1>

<h2>
    Objetivo do Sistema E-Commerce
</h2>

O serviço consiste em um sistema de gerenciamento de lojas digitais que atuam em sistema D2C (Direct to Consumer), onde há uma plataforma com diversos marketplaces individualizados para cada empresa cliente. Como referência para o projeto, adotamos o [Shopify](https://shopify.com/), considerando apenas o gerenciamento das lojas e não sua criação/design.


![Ilustração D2C](/UdD_images/D2C_image.jfif "Ilustração D2C")
##### fonte: https://www.linkedin.com/pulse/

<br>

- Lojas  
Enquanto ferramenta de gestão de `lojas`, o serviço permite que administradores criem seus sites de e-commerce. Cada loja possui um endereço eletrônico e tem um `administrador` responsável. As diferentes lojas podem ser acessadas pelos `clientes` cadastrados na plataforma, as `compras` ocorrem mediante inclusão de produtos no `carrinho` e da confirmação da compra.
    - nome
    - link
    - telefone
    - idAdministrador
    - ramo  
![Modelo de loja virtual](/UdD_images/loja_virtual.png "loja_virtual")
##### fonte: https://www.lojadocafe.com.br/


<br>

- Produtos  
Cada produto possuim um identificador próprio, recebe um nome e demais metadatos. Os produtos são inseridos no `estoque` e podem sar adicionados à um `carrinho` pelo cliente no ato de seleção de produtos a serem comprados. O `administrador` responsável pode fazer a criação e exclusão de produtos do sistema.
    - id
    - nome
    - categoria
    - valor
    - quantEstoque
    - descricao
    - cor
    - tamanho  
![Ilustração product sourcing](/UdD_images/manage_products.jpg "product_sourcing")
##### fonte: https://www.shopify.com/br/blog/apps-dropshipping 

<br>

- Estoques  
Cada loja possui um estoque individual que é composto pelos `produtos` que a mesma comercializa, este apresenta a quantidade de produtos que estão disponíveis, de acordo com o identificador de cada produto. A quantidade de cada produto pode variar através da inclusão ou exclusão pelo `administrador` e pode diminuir através do processo de `compra`, realizado pelo `cliente`.
    - id
    - idLoja
    - idProduto
    - quantidade
<br>

- Clientes  
A plataforma possui uma série de clientes. Cada cliente é identificado por um id de usuário, que também é utilizado para realizar login na plataforma, junto com sua senha. Os clientes fazem seu cadastrado junto com outros metadados necessários para identificação e entregas. Os clientes podem filtrar os `produtos` por categoria, ou outro de seus identificadores, e os incluir no carrinho. Clientes podem realizar a compra de produtos. Os clientes podem fazer `avaliações da loja` e `avaliação do produto` após realizar uma `compra`.
    -  id
    - senha
    - nome
    - email
    - telefone
    - cep
    - rua
    - numeroEnd  
![Ilustração cadastro clientes](/UdD_images/cadastro_cliente.png "cadastro_cliente")
##### fonte: https://www.lojadocafe.com.br/cadastro

<br>

- Carrinhos  
Para realizar uma `compra`, o cliente faz a seleção dos `produtos` e os inclui no carrinho. O cliente pode realizar a inclusão e a exclusão de produtos do carrinho. O carrinho permite a visualização de todos os produtos selecionados e apresenta o valor total a ser pago. Após confirmação, o cliente pode realizar a compra dos produtos que estão no carrinho.
    - id
    - idCliente
    - idProduto
    - valorProduto
    - quantidade  
![Ilustração carrinho de compras](/UdD_images/carrinho.png "carrinho_clientes")
##### fonte: https://www.lojadocafe.com.br/checkout

<br>

- Compras
Ao efetuar uma compra, a ação gera um registro com informações do cliente e da loja, a identificação do carrinho, que contém a lista de produtos, e as informações de valor, data e hora. Esta informação pode ser acessada tanto pelo cliente quanto pelo Administrador.
    - id
    - idCliente
    - idLoja
    - idCarrinho
    - valor
    - hora
    - data  
![Ilustração histórico de compras](/UdD_images/compras.png "compras")
##### fonte: https://www.techtudo.com.br/
<br>

- Administradores
Os administradores são usuários da plataforma responsáveis pelas lojas. Eles tem acesso à área de administração de sua loja, onde podem consultar os dados da loja, do caixa da loja, do histórico de compras, gerenciar estoque e gerenciar produtos.
    - id
    - senha
    - nome
    - email
    - telefone  
![ilustração area do administrador](/UdD_images/administrador.png "area_do_administrador")
##### fonte: https://www.jivochat.com.br/

<br>

- CaixaLoja
Cada loja tem seu controle de caixa, que permite a organização das entradas de caixa decorrentes das compras. Através do caixa, o administrador pode ver o fluxo financeiro de sua loja.
    - id
    - idLoja
    - idCompra

<br>

- AvaliacoesLoja
Após cada compra, o cliente pode realizar uma avaliação da loja em que realizou a compra. A avaliação permite a inserção de uma nota e um comentário.
    - id
    - idCliente
    - idLoja
    - nota
    - comentario  
![Ilustração avaliação da loja](/UdD_images/avaliacao_loja.png "avaliacao_loja")
##### fonte: https://softdesign.com.br/

<br>

- AvaliacoesProduto
Após cada compra, o cliente pode realizar uma avaliação para cada produto que adquiriu. Esta avaliação consiste na atribuição de uma nota e permite que seja incluido um comentário. 
    - id
    - idCliente
    - idLoja
    - nota
    - comentario   
![Ilustração avaliacao de produtos](/UdD_images/avaliacao_produto.png "avaliacao_produto")
##### fonte: https://www.shopify.com/

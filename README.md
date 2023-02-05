<h1>
    Serviço de E-Commerce
<h4> 
    Foi escolhido como tema um serviço para criação e gerenciamento de lojas digitais, como Shopify. Como foi pensando como base um SaaS, é necessário informações de cada loja virtual para um controle das requisições, e assim encaixar cada cliente do serviço em um plano. Para cada loja criada, é possível gerenciar quantidade de vendas, arrecadação, tipo de loja, número de clientes. Para os produtos da loja, há a informação de preço, categoria, quantidade, etc. Cada comprador possui um cadastro com seu nome, endereço, carrinho, etc.  
    <br>

<h2> Projeto Conceitual

<h4>

1. Escolher uma realidade para modelar e apresentar as simplificações de forma clara.  
2. Criar esquema ER que contenha:  
    - [x] 10 entidades, coectadas com pelo menos 1 relacionamento;
    - [X] 2 relacionamentos com cardinalidade n-m. Pelo menos 1 destes deve ter. atributos;
    - [X] entidades ligadas por uma hierarquia **relevante** de especialização.
3.  Uso de soluções que envolvam elaboração de diagramas e descrições textuais, o uso de ferramentas CASE é opcional.
4. Entregáveis:
    - [X] Documento PDF: Documento com Descrição em Português do UdD, onde conste claramente a URL do site que serviu como inspiração;
    - [X] Documento PDF: Diagrama ER; 
    - [X] Documento PDF: Dicionário de dados: descrição do significado de cada entidade/relacionamento/atributo, o domínio dos atributos, todas restrições de integridade não expressas no diagrama, bem como qualquer anotação;pertinente. Esta descrição deve agregar valor e complementar a representação diagramática;
    - [x] Arquivo (opcional): Caso use uma ferramenta de projeto, o arquivo da modelagem nesta ferramenta.

<h2> Projeto Lógico e Implementação com SGBD
    <h4>

1. Crie um esquema relacional correspondente ao seu esquema conceitual. As tabelas devem possuir chave primária, e quando for o caso, chaves alternativas e chaves estrangeiras. Estabeleça as demais restrições de acordo com os recursos de SQL vistos em aula (e.g. Check).  
2. Instancie suas tabelas, baseado em exemplos reais de sua inspiração, ou exemplos fictícios, mas factíveis. Cada tabela deve ter no mínimo 3 instâncias, salvo se no UdD isto não fizer sentido.
3.  Entregáveis:
    - [ ] o Documento PDF: Explicação do mapeamento feito, o qual deve descrever as regras de transformação aplicadas
    sobre o esquema ER para derivação do esquema relacional correspondente. Neste conjunto de regras, deve fica claro como cada entidade, relacionamento, atributo foi transformado em elementos do modelo relacional, e o porqu da estratégia escolhida. Justifique a escolha das chaves primárias. Mostre como restrições foram implantadas quando pertinente. Justifique a estratégia escolhida para mapeamento da hierarquia de especialização.
    - [x] Arquivo .sql com os comandos de criação e instanciação das tabelas.
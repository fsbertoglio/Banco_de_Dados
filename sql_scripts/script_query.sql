select *
from Administradores

select *
from Administradores_Lojas

select *
from Avaliacoes

select *
from AvaliacoesLoja

select *
from AvaliacoesProduto

select *
from Carrinhos

select *
from Clientes 

select *
from Compras

select *
from Lojas

select *
from  Metodos

select *
from Pagamentos

select *
from Produtos

select *
from Produtos_Carrinho

select *
from Usuarios


select id, nome, email
from Usuarios
where Usuarios.id > 1
order by nome

select *
from Administradores A join Administradores_Lojas A_L ON (A.id = A_L.idAdministrador)

select *
from Administradores A, Administradores_Lojas A_L

select A.nome, A_L.idloja
from Administradores A natural join Administradores_Lojas A_L

select L.id, L.nome, A.id, A.nome
from Administradores_Lojas A_L
join Administradores A on A.id = A_L.idadministrador
join Lojas L on L.id = A_L.idloja
order by L.nome

Select L.nome, COUNT (*)
from AvaliacoesLoja AL
join Lojas L on AL.idloja = L.id
where AL.nota > 6
group by L.nome

SELECT L.nome, COUNT(*), MAX(AL.nota), MIN(AL.nota), AVG(AL.nota)
FROM AvaliacoesLoja AL
JOIN Lojas L ON AL.idloja = L.idloja
GROUP BY L.nome
having AVG(AL.nota) >= 3


select A.iduser, A.nome, L.nome
from Administradores_Lojas AL 
natural join Lojas L
join Administradores A on (AL.idAdministrador = A.iduser)
order by A.iduser



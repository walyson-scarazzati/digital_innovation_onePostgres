--views 
select numero, nome, ativo from vw_bancos;

insert into vw_bancos (numero, nome, ativo)
values (51, 'Banco Boa Ideia', TRUE);

select numero, nome, ativo from vw_bancos where numero = 51;
---------------------------------------------------------------------
CREATE OR REPLACE recursive VIEW vw_func (id, gerente,funcionario) AS (
    SELECT id, gerente, nome
    FROM funcionarios
    where gerente is null
    union all 
    select funcionarios.id, funcionarios.gerente, funcionarios.nome
    from funcionarios
    join vw_func on vw_func.id = funcionarios.gerente
);

select id, gerente, funcionario
from vw_func;

create table if not exists funcionarios(
id serial,
nome VARCHAR(50),
gerente integer,
primary key (id),
foreign key (gerente) references funcionarios(id)
);

insert into funcionarios (nome, gerente) values ('Ancelmo', null);
insert into funcionarios (nome, gerente) values ('Beatriz', 1);
insert into funcionarios (nome, gerente) values ('Magno', 1);
insert into funcionarios (nome, gerente) values ('Cremilda', 2);
insert into funcionarios (nome, gerente) values ('Wagner', 4);
------------------------------------------------------------------------
select column_name , data_type from information_schema.columns where table_name = 'banco'

select AVG(valor) from cliente_transacoes; --media total dos valores

select count(numero) from cliente; --contagem dados

select count(numero), email
from cliente
where email ilike '%gmail.com'
group by email;

select MAX(valor) --traz o maior numero 
from cliente_transacoes;

select min(valor) --traz o menor numero 
from cliente_transacoes;

--traz o maximo de cada tipo de transação
select MAX(valor), tipo_transacao_id  
from cliente_transacoes
group by tipo_transacao_id;

--uando count para saber quantas transacoes tem cada tipo
select count(id), tipo_transacao_id
from cliente_transacoes
group by tipo_transacao_id 
having count(id)>150;


--fazendo a soma de cada tipo de transação
select sum(valor), tipo_transacao_id
from cliente_transacoes
group by tipo_transacao_id
order by tipo_transacao_id asc;
-------------------------------------------
select banco.numero, banco.nome, agencia.numero,agencia.nome 
from banco 
join agencia on agencia.banco_numero = banco.numero;
---------------------------------------
--quantos bancos tem agencias
select count (distinct banco.numero)
from banco
join agencia on agencia.banco_numero = banco.numero;
--------------------------------
select banco.numero, banco.nome, agencia.numero,agencia.nome 
from banco 
left join agencia on agencia.banco_numero = banco.numero;
-----------------------------------
select agencia.numero,agencia.nome, banco.numero, banco.nome
from agencia
right join banco on banco.numero = agencia.banco_numero;
-----------------------------------------------------------
select banco.numero, banco.nome, agencia.numero,agencia.nome 
from banco 
full join agencia on agencia.banco_numero = banco.numero;
--------------------------------------------------
select banco.nome, agencia.nome, conta_corrente.numero, conta_corrente.digito, cliente.nome
from banco 
join agencia on agencia.banco_numero = banco.numero
join conta_corrente 
on conta_corrente.banco_numero  = banco.numero 
and conta_corrente.agencia_numero = agencia.numero 
join cliente 
on cliente.numero = conta_corrente.cliente_numero;

--transações de cada cliente e os tipos de transações de cada cliente
select banco.nome, agencia.nome, conta_corrente.numero, conta_corrente.digito, cliente.nome,
cliente_transacoes.valor, tipo_transacao.nome 
from banco 
join agencia on agencia.banco_numero = banco.numero
join conta_corrente 
on conta_corrente.banco_numero  = banco.numero 
and conta_corrente.agencia_numero = agencia.numero 
join cliente 
on cliente.numero = conta_corrente.cliente_numero
join cliente_transacoes 
on cliente_transacoes.cliente_numero = cliente.numero
join tipo_transacao
on tipo_transacao.id = cliente_transacoes.tipo_transacao_id ;
-------------------------------------------
WITH tbl_tmp_banco as (
select numero, nome from banco)
select numero, nome from tbl_tmp_banco;

with params as (select 213 as banco_numero), tbl_tmp_banco as (
select numero, nome
from banco
join params on params.banco_numero = banco.numero
)
select numero, nome from tbl_tmp_banco;
-----------------------------------------
--fazendo o mesmo com subselect
select banco.numero, banco.nome from banco
join (select 213 as banco_numero) params on params.banco_numero = banco.numero;
create view listaAniverCaninos as
select a.nome, datanascimento, p.nome Dono, p.contato, especie 
       from especies join animal a  using (idespecie) 
       join possui using (idanimal)
       join pessoas p using (idpessoa)
       where idespecie =2 
       
select * from listaAniverCaninos  
select nome, datanascimento from listaAniverCaninos 
where date_part('month',datanascimento) = 10

create view listaAniverAnimal as
select a.nome, datanascimento, p.nome Dono, p.contato, especie 
       from especies join animal a  using (idespecie) 
       join possui using (idanimal)
       join pessoas p using (idpessoa)
       order by datanascimento

create or replace  view listaAniverAnimal as
select a.nome, datanascimento, p.nome Dono, p.contato, especie,p.dtnasc 
       from especies join animal a  using (idespecie) 
       join possui using (idanimal)
       join pessoas p using (idpessoa)
       order by datanascimento
       
select dono,dtnasc,nome,especie,datanascimento from listaAniverAnimal 
             where especie = 'Pássaro'
             order by especie

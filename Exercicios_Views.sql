CREATE VIEW relatorioAniversarios AS 
    SELECT pessoas.nome,pessoas.dtnasc,pessoas.contato,
    animal.nomeAnimal, animal.datanascimento, racas.racas, especies.especie
    from pessoas inner join possui on pessoas.idpessoa = possui.idpessoa 
    inner join animal on possui.idanimal = animal.idanimal
    inner join racas on animal.idracas = racas.idracas
    inner join especies on animal.idespecie = especies.idespecie order by dtnasc asc;

create view listaServicos as 
    select animal.nomeAnimal, racas.racas, especies.especie, 
    pessoas.nome, solicita.datasolicitacao, servicos.descricao, servicos.valor from animal inner join racas on animal.idracas = 
    racas.idracas inner join especies on animal.idespecie = especies.idespecie
    inner join possui on animal.idanimal = possui.idanimal inner join pessoas on
    possui.idpessoa = pessoas.idpessoa inner join solicita on animal.idanimal = solicita.idanimal
    inner join servicos on solicita.idservico = servicos.idservico order by solicita.datasolicitacao desc;

create view calculoServicos as 
    select count(*), sum(valor) from servicos;

create view calculoComissaoTotal as
    select pessoas.matric, pessoas.nome, solicita.datasolicitacao,servicos.descricao,servicos.valor,animal.nomeAnimal,especies.especie from pessoas
    inner join solicita on pessoas.idpessoa = solicita.idpessoa inner join servicos on solicita.idservico = servicos.idservico
    inner join animal on solicita.idanimal = animal.idanimal inner join especies on animal.idespecie = especies.idespecie 
    order by solicita.datasolicitacao desc;
    
create view calculoComissaoFunc as
   select count(*) servicos, sum(valor), sum(valor * 0.02) as "Comissão" from servicos;

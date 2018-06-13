CREATE TYPE type_pessoa_pet AS(   
nomePessoa VARCHAR(50), 
nomePET varchar(50)
);

CREATE OR REPLACE FUNCTION get_pessoa_pet()        
  RETURNS SETOF type_pessoa_pet AS $$
 DECLARE    dados_pes_pet type_pessoa_pet;



BEGIN FOR dados_pes_pet IN SELECT p.nome, a.nomeAnimal        
FROM pessoas p join possui using(idpessoa) 
 join animal a using(idanimal)    
 LOOP      
  RETURN NEXT dados_pes_pet;   
 END LOOP;   
 RETURN;

END;

$$ LANGUAGE 'plpgsql'

drop function get_pessoa_pet();

select * from get_pessoa_pet() WHERE NOMEPESSOA = '%Tanise%'

select * from get_pessoa_pet() WHERE NOMEPESSOA = 'TANISE DA ROSA ROOS GAMBETTA'

select * from pessoas



CREATE TYPE type_pessoa_animal as (
nomePessoa VARCHAR(100),
nomeAnimal VARCHAR(40),
especie VARCHAR(30),
raca VARCHAR(30)
);

CREATE OR REPLACE FUNCTION get_pessoa_animal()
RETURNS SETOF type_pessoa_animal AS $$ DECLARE
dados_pessoa_animal type_pessoa_animal;

BEGIN FOR dados_pessoa_animal IN SELECT p.nome, a.nomeAnimal, especies.especie, racas.racas
FROM pessoas p join possui using(idpessoa) join animal a using(idanimal) join especies using(idespecie) join racas using(idracas)
LOOP 
RETURN NEXT dados_pessoa_animal;
END LOOP;
RETURN;
END;
$$ LANGUAGE 'plpgsql'
select * from get_pessoa_animal() where NOMEPESSOA like '%TANISE%';

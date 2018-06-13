CREATE FUNCTION subtrair_inteiros(integer, integer)
RETURNS integer AS 'select $1 - $2;'
LANGUAGE SQL  IMMUTABLE 
RETURNS NULL ON NULL INPUT; 

SELECT subtrair_inteiros(5,3);

CREATE FUNCTION multiplicar_inteiros(integer, integer)
RETURNS integer AS 'select $1 * $2;'
LANGUAGE SQL  IMMUTABLE 
RETURNS NULL ON NULL INPUT; 

SELECT multiplicar_inteiros(5,3);

CREATE FUNCTION dividir_inteiros(double precision, double precision)
RETURNS double precision AS 'select $1 / $2;'
LANGUAGE SQL  IMMUTABLE 
RETURNS NULL ON NULL INPUT; 

SELECT dividir_inteiros(5,3);


CREATE FUNCTION media_ponderada(float, integer, float, integer, float, integer)
RETURNS float AS 'select ($1*$2+$3*$4+$5*$6)/($2+$4+$6);'
LANGUAGE SQL IMMUTABLE 
RETURNS NULL ON NULL INPUT;

drop function media_ponderada

SELECT media_ponderada(8.5,1,9,1,8.5,2);



CREATE or replace FUNCTION calcula_data(animal) 
returns record as 'select $1.nomeAnimal ,$1.datanascimento, extract(Year from Now()) - extract(Year from $1.datanascimento);'
LANGUAGE SQL IMMUTABLE 
RETURNS NULL ON NULL INPUT;


select calcula_data(animal) from animal;


CREATE or replace FUNCTION calcula_data(pessoas) 
returns record as 'select $1.nome ,$1.dtnasc, age(current_date,$1.dtnasc);'
LANGUAGE SQL IMMUTABLE 
RETURNS NULL ON NULL INPUT;

select calcula_data(pessoas) from pessoas;

Exemplo - Função 

CREATE OR REPLACE 
     FUNCTION operacaoElevar(numeric, char(1),numeric) 
          RETURNS varchar(100) AS $$
        declare retorno varchar(100); 
        declare resultado numeric(7,2);
        declare obs varchar (20)= ' ';
                
        BEGIN
              if $2 = '+' then
                 resultado= $1+$3; 
              else if $2 = '-' then
                      resultado= $1-$3;
                  else if $2 = '*' then
                         resultado= $1*$3;
                      else if $2 = '/' then 
                              resultado= $1/$3;
                           else if $2 = '^' then
                               resultado = 1;
                                FOR i IN 1..$3 LOOP
                                       RESULTADO = resultado * $1;
                                END LOOP;  
                                retorno = $1 || $2 ||$3 || ' = ' || resultado || obs ;
                                   
                                ELSE
                           
                              Resultado = 0;
                              retorno = 'operador inválido';
                             return  retorno; 
                                   END IF;
                           end if; 
                     end if;
                end if;
             end if; 
             retorno = $1 || $2 ||$3 || ' = ' || resultado || obs ;
             RETURN retorno  ;
        END;
                
$$ LANGUAGE plpgsql;

DROP FUNCTION operacaoElevar;

SELECT operacaoelevar(2,'^',3);




CREATE OR REPLACE FUNCTION get_pet() RETURNS SETOF RECORD AS $$
BEGIN
    RETURN QUERY SELECT nomeAnimal, especie, racas FROM animal join especies using(idespecie) 
    join racas using(idracas);
    RETURN;
END;
$$ LANGUAGE 'plpgsql';
--Chamada da Função

drop function get_pet()

SELECT * FROM get_pet() AS (
                 nome VARCHAR(40), 
                 especie VARCHAR(30),
                 racas VARCHAR(30))
                 
CREATE OR REPLACE FUNCTION get_cliente() RETURNS SETOF RECORD AS $$
BEGIN
    RETURN QUERY SELECT p.nome, a.nomeAnimal, especie, racas FROM animal a 
    join especies using(idespecie) 
    join racas using(idracas) 
    join possui using(idanimal) 
    join pessoas p using(idpessoa);
    RETURN;
END;
$$ LANGUAGE 'plpgsql';

drop function get_cliente()

SELECT * FROM get_cliente() AS (
                 Proprietario VARCHAR(100),
                 nome VARCHAR(40), 
                 especie VARCHAR(30),
                 racas VARCHAR(30))
                 where especie = 'Canino';
                 
select * from pessoas

update pessoas set dtnasc = '1993-04-01' where idpessoa = 4; 

alter table pessoas add column carta boolean default false;


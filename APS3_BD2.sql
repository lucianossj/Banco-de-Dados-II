/*.:: APS 3 - Triggers ::.*/

-- Criação da tabela de logs --
CREATE TABLE logConsulta (

    idLog SERIAL PRIMARY KEY,
    operacao TEXT,
    usuario TEXT,
    dataLog TIMESTAMP,
    idConsulta INTEGER,
    datacons DATE,
    horacons TIME

);

-- Criação da função --
CREATE OR REPLACE FUNCTION registraLogConsulta ()
    RETURNS TRIGGER AS $triggerConsulta$
        BEGIN

            IF(TG_OP = 'INSERT') THEN
                
                INSERT INTO logConsulta (operacao, usuario, dataLog, idConsulta, datacons, horacons)
                    VALUES ('Agendamento de consulta', USER, NOW(), new.idConsulta, 
                    new.datacons, new.hora);    
                
                RETURN NEW;

            ELSEIF (TG_OP = 'UPDATE') THEN

                INSERT INTO logConsulta (operacao, usuario, dataLog, idConsulta, datacons, horacons)
                    VALUES ('Alteração de consulta', USER, NOW(), old.idConsulta, 
                    new.datacons, new.hora);

                RETURN NEW;

            ELSEIF (TG_OP = 'DELETE') THEN

                INSERT INTO logConsulta (operacao, usuario, dataLog, idConsulta) 
                	VALUES ('Remoção de consulta', USER, NOW(), old.idConsulta);

                RETURN OLD;

            END IF;

        RETURN NULL;

        END;
$triggerConsulta$ LANGUAGE plpgsql;

-- Criação do Trigger --
CREATE TRIGGER triggerConsulta AFTER INSERT OR UPDATE OR DELETE ON Consulta
    FOR EACH ROW EXECUTE PROCEDURE registraLogConsulta();
       
-- Testes do Trigger --
INSERT INTO Consulta (idanimal, idpessoa, hora, datacons, obs) VALUES (1,1,'09:30','2018-06-23','Machucado');
UPDATE Consulta SET idanimal = '2' WHERE idConsulta = '8';
DELETE FROM Consulta WHERE idConsulta = 8;

SELECT * FROM Consulta;
SELECT * FROM logConsulta;

/*DROP TABLE logConsulta;
DROP TRIGGER triggerConsulta ON Consulta;
DROP FUNCTION registraLogConsulta;*/
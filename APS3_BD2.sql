/*.:: APS 3 - Triggers ::.*/

CREATE TABLE logConsulta (

    idLog SERIAL PRIMARY KEY,
    operacao TEXT,
    idPessoa INTEGER,
    dataLog TIMESTAMP,
    idConsulta INTEGER,
    datacons DATE,
    horacons DATE,
    idOldLog NUMERIC

);

/*

I = INSERT salvar um registro com Valores NEW data e Hora e código da consulta

U = Update salvar dois registros com Valores NEW e OLD data e Hora e código da consulta

D= Delete salvar um registro com Valores OLD data e Hora e código da consulta

*/

CREATE OR REPLACE FUNCTION registraLogConsulta ()
    RETURNS TRIGGER AS $triggerConsulta$
        BEGIN

            IF(TG_OP = 'INSERT') THEN
                
                INSERT INTO logConsulta (operacao, idpessoa, dataLog, idConsulta, datacons, horacons)
                    VALUES ('Agendamento de consulta', new.idpessoa, NOW(), new.idConsulta, 
                    new.datacons, new.hora);    
                
                RETURN NEW;

            ELSEIF (TG_OP = 'UPDATE') THEN

                UPDATE logConsulta 
                    SET operacao = 'Consulta alterada' WHERE idLog = old.idLog;

                INSERT INTO logConsulta (operacao, idpessoa, dataLog, idConsulta, datacons, horacons, idOldLog)
                    VALUES ('Alteração de consulta', old.idpessoa, NOW(), old.idConsulta, 
                    new.datacons, new.hora, old.idLog);

                RETURN NEW;

            ELSEIF (TG_OP = 'DELETE') THEN

                DELETE FROM logConsulta WHERE idLog = old.idLog;

                RETURN OLD;

            END IF;

        RETURN NULL;

        END;
$triggerConsulta$ LANGUAGE plpgsql;

CREATE TRIGGER triggerConsulta AFTER INSERT OR UPDATE OR DELETE ON Consulta
    FOR EACH ROW EXECUTE PROCEDURE registraLogConsulta();
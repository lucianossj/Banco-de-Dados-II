/*.:: APS 3 - Triggers ::.*/

CREATE TABLE logConsulta (

    dataLog DATE,
    horaLog DATE

);

-- Exemplo - Trigger --

/* REPLACE FUNCTION alteraUltData ()
    RETURNS TRIGGER AS $alteraUltData$
        BEGIN
            
            UPDATE Pessoas SET dataultsolic = new.datasolicitacao WHERE idPessoa = new.idPessoa;
            
            RETURN NEW;
            
        END;
    $alteraUltData$ LANGUAGE plpgsql;
     
     DROP FUNCTION alteraUltData;
           
CREATE TRIGGER alteraUltData AFTER INSERT ON Solicita
    FOR EACH ROW EXECUTE PROCEDURE alteraUltData();
    
INSERT INTO solicita (datasolicitacao, hora, valor, idanimal, idservico, idpessoa, matric)
                     VALUES ('2018-06-12', '10:43', 40.00, 1, 1, 1, 453332);*/


-- 1 --

CREATE OR REPLACE FUNCTION alteraUltData ()
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
                     VALUES ('2018-06-12', '10:43', 40.00, 1, 1, 1, 453332);
                     
                     
-- 2 --                     
        
        SELECT * FROM Animal;
        SELECT * FROM Consulta;
        
CREATE OR REPLACE FUNCTION atualizaUltimoTratamento ()
    RETURNS TRIGGER AS $atualizaUltimoTratamento$
        BEGIN
            
            UPDATE Animal SET dtulttrat = new.datacons WHERE idAnimal = new.idAnimal;
            
            RETURN NEW;
            
        END;
    $atualizaUltimoTratamento$ LANGUAGE plpgsql;
         
CREATE TRIGGER atualizaUltimoTratamento AFTER INSERT ON Consulta
    FOR EACH ROW EXECUTE PROCEDURE atualizaUltimoTratamento();
    
INSERT INTO Consulta (idanimal, idpessoa, hora, datacons, obs)
    VALUES (1, 1, '11:32', '2018-06-12', 'Machucado') 

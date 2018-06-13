CREATE OR REPLACE FUNCTION atualiza_estoque(INTEGER) RETURNS INTEGER AS $$
DECLARE
    registro RECORD;
    regAtualiza RECORD;
    qtdEstoq INTEGER;
BEGIN
    SELECT INTO registro * FROM nf WHERE numnf = $1 AND atualizada = 0;
        IF registro.atualizada = 1
        THEN
            RAISE NOTICE 'NF % JÁ ATUALIZADA', $1;
            RETURN 0;
        ELSE
            IF registro.tipo = 1
            THEN
                
                FOR regAtualiza IN SELECT * FROM itens where itens.numnf = $1
                    LOOP
                         UPDATE remediosprodutos 
                                SET qtdestoque = qtdestoque - regAtualiza.qtd, 
                                    dtultvenda = registro.datanf
                                WHERE idremedioproduto =regAtualiza.idremedioprod;
                
                            UPDATE nf SET atualizada = 1
                                WHERE numnf = $1;
                
                END LOOP;
                RETURN 1;
            ELSE
                     
                FOR regAtualiza IN SELECT * FROM itens where itens.numnf = $1
                    LOOP
                         UPDATE remediosprodutos 
                                SET qtdestoque = qtdestoque + regAtualiza.qtd, 
                                    dtultcompra = registro.datanf
                                WHERE idremedioproduto = regAtualiza.idremedioprod;
                
                            UPDATE nf SET atualizada = 1
                                WHERE numnf = $1;
                                END LOOP;
                                RETURN 1;
            END IF;
        END IF;    
END;
$$
LANGUAGE 'plpgsql'; 


select atualiza_estoque(4553);

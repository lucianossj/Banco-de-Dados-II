create or replace function aniver_illuminati() returns setof record as $$
BEGIN
    UPDATE pessoas set carta = TRUE where 
           extract(Month from dtnasc) = extract(Month from Now());
    RETURN QUERY 
        SELECT nome, contato, dtnasc 
        from pessoas 
        where carta = TRUE
        and extract(Month from dtnasc) = extract(Month from Now());
    RETURN;
END;
$$ LANGUAGE 'plpgsql';

drop function aniver_illuminati()

select * from aniver_illuminati() as (
            Nome VARCHAR(100),
            Contato VARCHAR(20),
            Data_Nascimento DATE)

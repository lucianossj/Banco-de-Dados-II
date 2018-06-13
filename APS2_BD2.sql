/* .:: APS 2 - Exercício de Funções e Procedures (3 Horas)

Situação Temática: O proprietário da Pet Shop Tabajara pediu alguns relatórios que atendam as suas necessidades. Faça as funções e procedures que dê as seguintes informações para os relatórios:

Utilizando o banco de dados Pet Shop faça: 

1. Uma função para calcular o total da NF, que tem como parâmeto de entrada o número da NF.
2. Uma função que calcule o total de serviços solicitados por cliente (parametro de entrada Idcliente)  
3. Uma função que calcula a quantidade de serviços solicitados por um cliente  (parametro de entrada Idcliente)
4. Uma função que retorna os serviços solicitados por animal em um determinado período. Colocar como parâmetro de entrada: Data Inicial e Data Final. 
5. Uma função que recebe o número de um mês e  retorna os animais que fazem aniversário no mês de entrada e o nome do proprietário. 
6. Uma função que liste os animais, raça, espécie e quais remédios foram indicados na consulta.

*/

/* .:: Nº 1 ::. */

CREATE OR REPLACE FUNCTION calculaNF (NUMERIC) 
RETURNS NUMERIC AS 'SELECT SUM(valor) FROM Itens WHERE numNf = $1;'
LANGUAGE SQL IMMUTABLE
RETURNS NULL ON NULL INPUT;

SELECT * FROM calculaNf(2321);

/* .:: Nº 2 ::. */

CREATE OR REPLACE FUNCTION calculaValorTotalServicos (NUMERIC)
RETURNS NUMERIC AS 'SELECT SUM(valor) FROM solicita WHERE idPessoa = $1'
LANGUAGE SQL IMMUTABLE
RETURNS NULL ON NULL INPUT;

SELECT * FROM calculaValorTotalServicos(1);

/* .:: Nº 3 ::. */

CREATE OR REPLACE FUNCTION calculaTotalServicos (BIGINT)
RETURNS BIGINT AS 'SELECT COUNT(idServico) FROM solicita WHERE idPessoa = $1'
LANGUAGE SQL IMMUTABLE
RETURNS NULL ON NULL INPUT;

SELECT * FROM calculaTotalServicos(1);

/* .:: Nº 4 ::. */

CREATE OR REPLACE FUNCTION servicosAnimais(DATE, DATE)
RETURNS SETOF RECORD AS $$
BEGIN
	RETURN QUERY SELECT animal.nomeAnimal, descricao, dataSolicitacao FROM servicos 
		INNER JOIN solicita ON servicos.idServico = solicita.idServico
		INNER JOIN animal ON solicita.idAnimal = animal.idAnimal
		WHERE dataSolicitacao BETWEEN $1 AND $2;
	RETURN;
END;
$$ LANGUAGE 'plpgsql'

SELECT * FROM servicosAnimais('2018-04-22','2018-05-22') AS (
	nomeAnimal VARCHAR(40),
	descricao VARCHAR(40),
	dataSolicitacao DATE)

/* .:: Nº 5 ::. */

CREATE OR REPLACE FUNCTION aniversariosMes(INTEGER) 
RETURNS SETOF RECORD AS $$
BEGIN
    RETURN QUERY SELECT p.nome, a.nomeAnimal 
	FROM Animal a
    JOIN Possui USING(idAnimal) 
    JOIN Pessoas p USING(idPessoa)
	WHERE EXTRACT(Month FROM a.dataNascimento) = $1;
    RETURN;
END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM aniversariosMes(1) AS (
			NomePessoa VARCHAR(100),
			NomePet VARCHAR(40))

/* .:: Nº 6 ::. */

CREATE OR REPLACE FUNCTION infoAnimais()
RETURNS SETOF RECORD AS $$
BEGIN
	RETURN QUERY SELECT animal.nomeAnimal, racas.racas, especies.especie, remediosProdutos.nome FROM Animal
		INNER JOIN racas ON animal.idRacas = racas.idRacas
		INNER JOIN especies ON animal.idEspecie = especies.idEspecie
		INNER JOIN consulta ON animal.idAnimal = consulta.idAnimal
		INNER JOIN tratamento ON consulta.idConsulta = tratamento.idConsulta
		INNER JOIN remediosProdutos ON tratamento.idRemedioProduto = remediosProdutos.idRemedioProduto;
	RETURN;
END;
$$ LANGUAGE 'plpgsql'

SELECT * FROM infoAnimais() AS (
	nomeAnimal VARCHAR(40),
	racas VARCHAR(30),
	especie VARCHAR(30),
	nome VARCHAR(40)
)
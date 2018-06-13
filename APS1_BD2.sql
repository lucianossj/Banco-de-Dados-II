/*.:: APS 1 - VIEWS 

1. Faça uma view que mostre os remédios prescritos por animais.
2. Faça uma view que mostre quais animais cada veterinário atendeu .
3. Faça uma view que mostre a agenda de consultas com animais e proprietários
4. Faça uma view que mostre a agenda de solicitações de serviços por animal e proprietário
5. Faça uma view que mostre por data quais remédios foram prescritos nas consultas
6. Faça uma view que mostre todos os rémedios que não foram prescritos em nenhuma consulta.

*/

/* .:: Nº 1 ::. */

CREATE VIEW remediosPorAnimais AS
	SELECT remediosProdutos.nome FROM remediosProdutos
		INNER JOIN tratamento ON remediosProdutos.idRemedioProduto = tratamento.idRemedioProduto
		INNER JOIN consulta ON tratamento.idConsulta = consulta.idConsulta
		INNER JOIN animal ON consulta.idAnimal = animal.idAnimal;

/* .:: Nº 2 ::. */

CREATE VIEW animaisPorVeterinario AS
	SELECT animal.nomeAnimal, pessoas.nome FROM animal
		INNER JOIN consulta ON animal.idAnimal = consulta.idAnimal
		INNER JOIN veterinarios ON consulta.idPessoa = veterinarios.idPessoa
		INNER JOIN pessoas ON veterinarios.idPessoa = pessoas.idPessoa;
	
/* .:: Nº 3 ::. */

CREATE VIEW agendaConsultas AS
	SELECT consulta.datacons, consulta.hora, animal.nomeAnimal, pessoas.nome FROM consulta
		INNER JOIN animal ON consulta.idAnimal = animal.idAnimal
		INNER JOIN possui ON animal.idAnimal = possui.idAnimal
		INNER JOIN pessoas ON possui.idPessoa = pessoas.idPessoa;

/* .:: Nº 4 ::. */

CREATE VIEW agendaSolicitacoes AS
	SELECT servicos.descricao, servicos.valor, pessoas.nome, animal.nomeAnimal FROM servicos
		INNER JOIN solicita ON servicos.idServico = solicita.idServico
		INNER JOIN pessoas ON solicita.idPessoa = pessoas.idPessoa
		INNER JOIN animal ON solicita.idAnimal = animal.idAnimal;

/* .:: Nº 5 ::.*/

CREATE VIEW remediosPorData AS
	SELECT consulta.datacons, remediosProdutos.nome, animal.nomeAnimal FROM consulta
		INNER JOIN tratamento ON consulta.idConsulta = tratamento.idConsulta
		INNER JOIN remediosProdutos ON tratamento.idRemedioProduto = remediosProdutos.idRemedioProduto
		INNER JOIN animal ON consulta.idAnimal = animal.idAnimal 
	ORDER BY consulta.datacons DESC;

/* .:: Nº 6 ::. */

CREATE VIEW remediosNaoPrescritos AS
	SELECT nome FROM remediosProdutos r WHERE r.idRemedioProduto NOT IN (SELECT idRemedioProduto FROM tratamento);

/* .:: Testes ::. */

SELECT * FROM remediosPorAnimais;
SELECT * FROM animaisPorVeterinario;
SELECT * FROM agendaConsultas;
SELECT * FROM agendaSolicitacoes;
SELECT * FROM remediosPorData;
SELECT * FROM remediosNaoPrescritos;
/*.:: APS 4 - VIEWS, FUNÇÕES E TRIGGER NO SISTEMA PET SHOP ::.*/

-- Incluir atributo dataUltimaSolicitação Date na Tabela Animal
ALTER TABLE animal ADD COLUMN dtultsolicitacao DATE;
ALTER TABLE animal RENAME dtultsolicitacao TO dataultsolic;

select * from solicita;

-- Fazer uma Trigger que sempre que inserir uma nova solicitação atualizar a 
-- dataUltimaSolicitação no animal com a data da solicitação.

CREATE OR REPLACE FUNCTION upd_dtsolic_animal() RETURNS TRIGGER AS
$upd_dtsolic$ 
BEGIN
	UPDATE animal SET dataultsolic = new.datasolicitacao
	WHERE idanimal = new.idanimal;
  RETURN NEW;
END
$upd_dtsolic$ LANGUAGE plpgsql;

CREATE TRIGGER upd_dtsolic_animal AFTER INSERT ON solicita
FOR EACH ROW EXECUTE PROCEDURE upd_dtsolic_animal();

INSERT INTO solicita (datasolicitacao, hora, valor, idanimal, idservico, idpessoa, matric)
                 	VALUES ('2018-06-21', '21:34', 50.00, 2, 2, 2, 453332);
					
INSERT INTO solicita (datasolicitacao, hora, valor, idanimal, idservico, idpessoa, matric)
                 	VALUES ('2018-06-22', '21:48', 30.00, 1, 1, 1, 453332);


-- Criar uma View que mostre por data decrescente os animais por dataUltimaSolicitação
CREATE VIEW animal_dtsolic AS
SELECT a.nomeanimal, a.datanascimento, a.dataultsolic, racas, especie FROM animal a
JOIN especies using(idespecie) join racas using (idracas)
ORDER BY a.dataultsolic desc;

DROP VIEW animal_dtsolic

select * from animal_dtsolic

-- Criar uma função que o parâmetro de entrada seja o idanimal e mostre a dataUltimaSolicitação, a solicitação e o valor total da solicitação

CREATE OR REPLACE FUNCTION get_datasolic(INTEGER)
RETURNS SETOF RECORD AS $$
BEGIN
	RETURN QUERY SELECT a.dataultsolic, a.nomeanimal, servicos.descricao, solicita.valor
	FROM solicita JOIN animal a using(idanimal)
	JOIN servicos using(idservico)
	where solicita.idanimal = $1;
	RETURN;
END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM get_datasolic(1) AS(
			DataSolic DATE,
			NomePet VARCHAR(40),
			Servico VARCHAR(40),
			ValorServico Numeric
)
	

SELECT * FROM Pessoas;

-- Incluir atributo dataUltimaVenda Date na Tabela pessoa
ALTER TABLE Pessoas ADD COLUMN dtultvenda DATE;


-- Fazer uma Trigger que sempre que inserir uma nova Nota fiscal de Venda atualizar a dataUltimaVenda na tabela pessoa com a data da NF.

CREATE OR REPLACE FUNCTION upd_dtultvenda() RETURNS TRIGGER
AS $upd_dtultvenda$
DECLARE
	reg record;
BEGIN
	SELECT INTO reg * FROM nf;
	UPDATE Pessoas SET dtultvenda = new.datanf
	WHERE new.tipo = 1 AND idpessoa = new.idprop;
  RETURN NEW;
END;
$upd_dtultvenda$ LANGUAGE plpgsql;

CREATE TRIGGER upd_dtultvenda AFTER INSERT ON nf
FOR EACH ROW EXECUTE PROCEDURE upd_dtultvenda();

INSERT INTO NF (numnf, datanf, tipo, atualizada, idprop)
	VALUES (5982, '2018-06-21', 1, 0, 1);

SELECT * FROM NF

-- Criar uma View que mostre por data decrescente as vendas por pessoa.
CREATE VIEW dtvenda_pessoa AS
	SELECT nome, dtnasc, dtultvenda FROM PESSOAS
	ORDER BY dtultvenda DESC;
	
SELECT * FROM dtvenda_pessoa;

-- Criar uma função que o parâmetro de entrada seja o idpessoa e mostre a dataUltimaVenda, os itens vendidos e o valor total da venda

CREATE OR REPLACE FUNCTION get_venda(INTEGER)
RETURNS SETOF RECORD AS $$
DECLARE
	regnf RECORD;
	vendaResult NUMERIC;
BEGIN
	SELECT INTO regnf * FROM nf;
	SELECT INTO vendaResult sum(itens.valor) FROM itens WHERE regnf.idprop = $1 AND itens.numnf = regnf.numnf;
		RETURN QUERY 
			SELECT p.dtultvenda, remediosprodutos.nome, vendaResult
				FROM pessoas p INNER JOIN nf ON p.idpessoa = regnf.idprop
							JOIN itens using(numnf)
							INNER JOIN remediosprodutos 
							ON itens.idremedioprod = remediosprodutos.idremedioproduto
							WHERE regnf.idprop = $1 AND itens.numnf = regnf.numnf;
	RETURN;
END
$$ LANGUAGE 'plpgsql';

DROP FUNCTION get_venda

select * from itens

SELECT * FROM get_venda(1) AS(
				DataUltVenda DATE,
				NomeRemedio VARCHAR(40),
				ValorVendaTotal NUMERIC
)

-- Incluir atributo dataUltimaCompra Date na Tabela fornecedor
ALTER TABLE fornecedor ADD COLUMN dtultcompra DATE;

-- Fazer uma Trigger que sempre que inserir uma nova Nota fiscal de Compra atualizar a dataUltimaCompra na tabela fornecedor data da NF.

CREATE OR REPLACE FUNCTION upd_dtcompra() RETURNS TRIGGER
AS $upd_dtcompra$
DECLARE
	reg record;
BEGIN
	SELECT INTO reg * FROM nf;
		UPDATE fornecedor SET dtultcompra = new.datanf
		WHERE reg.tipo = 0 AND idfornecedor = new.idfornecedor;
	RETURN NEW;
END;
$upd_dtcompra$ LANGUAGE plpgsql;

CREATE TRIGGER upd_dtcompra AFTER INSERT ON
nf FOR EACH ROW EXECUTE PROCEDURE upd_dtcompra();

INSERT INTO nf (numnf, datanf, tipo, atualizada, idfornecedor)
	VALUES (8097, '2018-06-22', 0, 0, 1);

select * from fornecedor

-- Criar uma View que mostre por data decrescente as compras por fornecedor, 
-- mostrando as seguintes informações:
-- i.	Descrição do Produto
-- ii.	Quantidade do Produto
-- iii.	Valor de Compra do Produto
-- iv.	Data da NF
-- v.	Número da NF

CREATE VIEW get_dtfornecedor AS
	SELECT remediosprodutos.nome NomeRemedio, itens.qtd Quantidade, itens.valor, nf.numnf, nf.datanf
		FROM remediosprodutos INNER JOIN itens on remediosprodutos.idremedioproduto = itens.idremedioprod
		JOIN nf using(numnf)
		JOIN fornecedor using(idfornecedor)
	WHERE itens.idremedioprod = remediosprodutos.idremedioproduto
	ORDER BY fornecedor.dtultcompra;

SELECT * FROM get_dtfornecedor;

DROP VIEW get_dtfornecedor;

SELECT * FROM remediosprodutos

-- Criar uma função que o parâmetro de entrada seja o idfornecedor e mostre a dataUltimaCompra e os itens comprados.

CREATE OR REPLACE FUNCTION get_dtultcompra(INTEGER)
RETURNS SETOF RECORD AS $$
BEGIN
	RETURN QUERY SELECT fornecedor.dtultcompra, remediosprodutos.nome
	FROM fornecedor JOIN nf using(idfornecedor)
	JOIN itens using(numnf)
	INNER JOIN remediosprodutos ON itens.idremedioprod = remediosprodutos.idremedioproduto
	WHERE nf.idfornecedor = $1 AND nf.numnf = itens.numnf;
END
$$ LANGUAGE 'plpgsql';

SELECT * FROM get_dtultcompra(1) AS (
				DataUltCompra DATE,
				NomeRemedio VARCHAR(40)
) 

-- Criar uma função que o parâmetro de entrada seja o idfornecedor e mostre a dataUltimaCompra e o valor total da Compra.

CREATE OR REPLACE FUNCTION get_valorultcompra(INTEGER)
RETURNS SETOF RECORD AS $$
DECLARE
	registronf RECORD;
	compraResult NUMERIC;
BEGIN
	SELECT INTO registronf * FROM nf;
	SELECT INTO compraResult sum(itens.valor) 
		FROM itens WHERE registronf.idfornecedor = $1 AND itens.numnf = registronf.numnf;
			RETURN QUERY 
				SELECT fornecedor.dtultcompra, compraResult
				FROM fornecedor JOIN nf using(idfornecedor)
								JOIN itens using(numnf)
							INNER JOIN remediosprodutos ON itens.idremedioprod = remediosprodutos.idremedioproduto
					WHERE registronf.idfornecedor = $1 AND registronf.numnf = itens.numnf;
		RETURN;
END
$$ LANGUAGE 'plpgsql';

SELECT * FROM get_valorultcompra(1) AS (
				DataUltCompra DATE,
				ValorTotalCompra NUMERIC
) 

select * from itens

-- A partir dos LOGS: logSolicita, logConsulta
-- Criar Views que mostrem:
-- a. Os conteúdos em ordem decrescente de data da ocorrência no log
-- b. Para o LogSolicita mostrar os registros por matricula e por data da ocorrência

CREATE VIEW dtlogconsulta_desc AS
	SELECT * FROM logconsulta;

SELECT * FROM dtlogconsulta_desc ORDER BY dtlog DESC;

CREATE TABLE logsolicita(
operacao char(1),
dtlog timestamp,
usuario VARCHAR(50),
dataSolicitacao DATE,
hora VARCHAR(300),
valor decimal,
idAnimal integer,
idServico integer,	
idPessoa integer,
matric integer,
seq serial PRIMARY KEY
)

CREATE VIEW dtlogsolicita_desc AS
	SELECT * FROM logsolicita;
	
SELECT * FROM dtlogsolicita_desc ORDER BY dtlog DESC;

-- Fazer relatórios de CONTROLE, a partir dos logs que mostrem as alterações:
-- Nas movimentações financeiras. 

CREATE TABLE auditfinanceira(
operacao char,
usuario VARCHAR(50),
dtAudit DATE,
idFinanceira integer,
dataVenc DATE,	
valorPrev NUMERIC,	
dataPgto DATE,
valorPgto NUMERIC,
tipo integer,
numnf integer,
idAuditFinanceira integer PRIMARY KEY
)

CREATE VIEW dtaudit_desc AS
	SELECT * FROM auditfinanceira;

SELECT * FROM dtaudit_desc ORDER BY dtaudit DESC;
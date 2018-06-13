CREATE TABLE animal (
idanimal SERIAL PRIMARY KEY,
nomeAnimal varchar(40),
datanascimento date,
dtulttrat date,
idracas SERIAL,
idespecie SERIAL
);

CREATE TABLE servicos (
descrição varchar(40),
valor decimal(10,2),
idservico SERIAL PRIMARY KEY
);

CREATE TABLE nf (
numnf SERIAL PRIMARY KEY,
datanf date,
tipo smallint,
atualizada smallint,
idfornecedor INTEGER,
idprop INTEGER
);

CREATE TABLE itens (
valor decimal(10,2),
iditem SERIAL PRIMARY KEY,
qtd integer,
idremedioprod SERIAL,
numnf SERIAL,
FOREIGN KEY(numnf) REFERENCES nf (numnf)
);

CREATE TABLE remediosprodutos (
idremedioproduto SERIAL PRIMARY KEY,
tipo integer,
nome varchar(40),
preco decimal(10,2),
dtvalidade date,
qtdestoque integer
);

CREATE TABLE fornecedor (
idfornecedor SERIAL PRIMARY KEY,
razaosocial varchar(50)
);

CREATE TABLE movfinanceira (
idfinanceiro SERIAL PRIMARY KEY,
datavenc date,
valorprev decimal(10,2),
datapagto date,
valorpagto decimal(10,2),
tipo integer,
numnf SERIAL,
FOREIGN KEY(numnf) REFERENCES nf (numnf)
);

CREATE TABLE solicita (
datasolicitacao date,
hora time,
valor decimal(10,2),
idanimal SERIAL,
idservico SERIAL,
idpessoa SERIAL,
matric Integer,
PRIMARY KEY(datasolicitacao,idanimal,idservico,idpessoa)
);

CREATE TABLE consulta (
idanimal SERIAL,
idpessoa SERIAL,
idconsulta SERIAL PRIMARY KEY,
hora time,
datacons date,
obs varchar(300),
FOREIGN KEY(idanimal) REFERENCES animal (idanimal)
);

CREATE TABLE tratamento (
idconsulta SERIAL,
idremedioproduto SERIAL,
FOREIGN KEY(idconsulta) REFERENCES consulta (idconsulta),
FOREIGN KEY(idremedioproduto) REFERENCES remediosprodutos (idremedioproduto)
);

CREATE TABLE especies (
idespecie SERIAL PRIMARY KEY,
especie varchar(30)
);

CREATE TABLE racas (
racas varchar(30),
idracas SERIAL PRIMARY KEY
);

CREATE TABLE pessoas (
idpessoa SERIAL PRIMARY KEY,
contato varchar(20),
nome varchar(100),
dataultsolic date,
matric integer,
dtnasc date
);

CREATE TABLE possui (
idanimal SERIAL,
idpessoa SERIAL,
FOREIGN KEY(idanimal) REFERENCES animal (idanimal),
FOREIGN KEY(idpessoa) REFERENCES pessoas (idpessoa)
);

CREATE TABLE veterinarios (
idpessoa SERIAL,
crv Integer,
dtadmissao Date,
FOREIGN KEY(idpessoa) REFERENCES pessoas (idpessoa)
);

CREATE TABLE usuario (
id SERIAL PRIMARY KEY,
nm_login varchar(40),
ds_senha varchar(40),
fg_bloqueado boolean,
nu_tentativa_login integer
);

ALTER TABLE animal ADD FOREIGN KEY(idracas) REFERENCES racas (idracas);
ALTER TABLE animal ADD FOREIGN KEY(idespecie) REFERENCES especies (idespecie);

ALTER TABLE nf ADD FOREIGN KEY(idfornecedor) REFERENCES fornecedor (idfornecedor);
ALTER TABLE nf ADD FOREIGN KEY(idprop) REFERENCES pessoas (idpessoa);
ALTER TABLE itens ADD FOREIGN KEY(idremedioprod) REFERENCES remediosprodutos (idremedioproduto);

ALTER TABLE Pessoas ADD COLUMN carta BOOLEAN DEFAULT FALSE;

ALTER TABLE remediosprodutos ADD COLUMN dtUltCompra DATE;
ALTER TABLE remediosprodutos ADD COLUMN dtUltVenda DATE;


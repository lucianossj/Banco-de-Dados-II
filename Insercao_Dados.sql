insert into pessoas (nome, contato, dtnasc)
values 
('AUGUSTO RECH DE OLIVEIRA','98745874','1997-10-19'),
('BRYAN EDUARDO MACHADO QUADROS','99446777','1998-11-05'),
('CARLOS AUGUSTO PEREIRA WEBER','99222777','1975-04-03'),
('GUILHERME CESAR PIRES','997522477','1993-01-01'),
('GUILHERME PEREIRA SANTANNA','99897777','1994-05-24'),
('JAQUELINI ROCHA GONÇALVES','99234757','1994-05-28'),
('jOAO VITOR DA ROCHA ROQUE','99325659','2000-01-31'),
('LEONARDO FERREIRA SOARES','995664377','1981-08-03'),
('LUCAS BITENCOURT HOFFMANN','96546677','1992-12-18'),
('LUCAS FERNANDO GONÇALVES DA SILVA','9976774344','1996-05-25'),
('LUCIANO DA SILVA SANTOS JUNIOR','99274665','1997-02-06'),
('MATHEUS SCHALY GOIS','99766777','1998-02-08'),
('NICOLAS MACHADO FLÔRES','997325211','1998-03-27'),
('ROBERTO AUGUSTO STEINBRUCK FILHO','99766777','1995-03-27'),
('ROHAN SZINWELSKI DE OLIVEIRA','99766777','1999-09-05'),
('TANISE DA ROSA ROOS GAMBETTA','99766777','1980-12-13');

insert into racas (racas) values ('Siamês');
insert into racas (racas) values ('Persa'),('Pastor Alemão'),
('Doberman'),('Boxer'),('Rusk Siberiano'),('Iguana Indiana'),
('Canarinho'),('Papagaio'),('Tartaruga'),('SRD'),('Shihtzu'); 


insert into especies (especie) values ('Felino'),('Canino'),
('Roedor'),('Rétil'),('Pássaro');


insert into animal (nomeAnimal, datanascimento, idracas, idespecie) values ('Alikia', '2015-07-27',3,2);

insert into animal (nomeAnimal, datanascimento, idracas, idespecie) values ('Tango', '2012-08-21',5,2),('Mia', '2013-01-15',2,1),
('Kiko','1930-10-10',9,5),('Bruce','2015-04-19',12,2),('Patty Maionese','2015-01-30',11,2),('Bella','2013-02-12',1,1),
('Fera','2015-10-30',11,1),('Branquinho','1999-01-15',11,3),('Bibo','2001-10-20',11,2);

insert into fornecedor (razaosocial) values ('Canino e Cia'),
('Laboratório Miauy'),('Pets Ltda.'),('Medicamentos AUAU');

insert into remediosprodutos (tipo,nome,preco,dtvalidade) values 
(0,'Fenergam','12.00','2017-05-30'),(0,'Vermifugo zaz','1.50','2018-08-31');
insert into remediosprodutos (tipo,nome,preco) values 
(1,'Coleira','15.00'),(1,'Talco','18.90');

insert into nf (numnf,datanf,tipo,atualizada,idprop) values 
(2321,'2016-08-16',0,0,1),(2511,'2016-08-16',0,0,2),(8735,'2016-08-16',0,0,3),(3261,'2016-08-15',0,0,2),(2144,'2016-08-15',0,0,3),
(9876,'2016-08-15',0,0,1);

insert into nf (numnf,datanf,tipo,atualizada,idfornecedor,idprop) values 
(4553,'2016-08-16',1,0,null,7),(4554,'2016-08-16',1,0,null,8),
(4555,'2016-08-16',1,0,null,9);

insert into itens (valor,qtd,numnf,idremedioprod) values ('12.30',50,2321,1),
('3.85',100,2321,2),('15.00',55,2511,3),('9.43',120,8735,4),('22.40',1,4553,1),
('6.90',1,4554,2),('27.90',2,4554,3),('19.50',1,4555,4),('12.30',50,3261,1),
('3.85',100,2144,2),('15.00',55,2144,3),('9.43',120,9876,4),('17.50',40,2321,4);
s
insert into servicos (descrição,valor) values ('Banho Canino','40.00'),
('Banho Felino','30.00'),('Escova','40.00'),('Tosa','45.00'),('Massagem','70.00');

insert into veterinarios (crv,dtadmissao) values ('346644422','2016-01-02');

insert into consulta (idanimal,idpessoa,hora,datacons,obs) values (2,2,'14:00','2016-08-09','Dor na pata'),
(3,4,'15:00','2016-08-09','Vacinas'),(4,4,'15:30','2016-08-09','Febre'),(5,7,'15:40','2016-08-09','Machucado'),
(8,9,'16:00','2016-08-09','Vacinas');

insert into animal (nomeAnimal,datanascimento, idracas,idespecie)
            values ('BELINHA','2017-01-25',12,2),
                   ('CHER','2015-08-29',12,2);

insert into animal (nomeAnimal,datanascimento, idracas,idespecie)
            values ('Nike','2016-08-25',5,2);

insert into possui values (11,15),(12,15);
insert into possui values (13,16);

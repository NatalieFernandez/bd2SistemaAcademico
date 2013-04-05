
/*Observacao: 

inicializar o BD atraves do comando: sudo nome_do_BD --local_infile=1*/

LOAD DATA LOCAL INFILE 'campus.csv'
INTO TABLE SistemaAcademico.Campus
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';


LOAD DATA LOCAL INFILE 'centro.csv'
INTO TABLE SistemaAcademico.Centro
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE 'cod_disc.csv'
INTO TABLE SistemaAcademico.Disciplina
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(codigo_disciplina, nome_disciplina, Centro_numero_centro);
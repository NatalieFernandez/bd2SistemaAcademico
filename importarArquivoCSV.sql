
LOAD DATA LOCAL INFILE 'campus.csv'
INTO TABLE SistemaAcademico.Campus
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(id_campus, nome_campus)


LOAD DATA LOCAL INFILE 'centro.csv'
INTO TABLE SistemaAcademico.Centro
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'


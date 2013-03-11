
LOAD DATA LOCAL INFILE 'campus.csv'
INTO TABLE SistemaAcademico.Campus
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(id_campus, nome_campus)
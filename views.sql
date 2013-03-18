create view `SistemaAcademico`.`view_Alunos` (nome, matricula, ano_entrada) as
select Pessoa.nome, Aluno.idAluno, Aluno.Matriz_Curricular_ano_matriz from 
Pessoa inner join Aluno on Pessoa.idPessoa = Aluno.Pessoa_idPessoa;

create view `SistemaAcademico`.`view_Professores`(nome, registro, laboratorio) as
select Pessoa.nome, Professor.registro_professor, Professor.Laboratorio_numero_laboratorio from
Pessoa inner join Professor on Pessoa.idPessoa = Professor.Pessoa_idPessoa;


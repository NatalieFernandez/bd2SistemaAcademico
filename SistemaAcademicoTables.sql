SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `SistemaAcademico` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `SistemaAcademico` ;

-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Campus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Campus` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Campus` (
  `id_campus` INT NOT NULL ,
  `nome_campus` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_campus`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Centro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Centro` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Centro` (
  `numero_centro` INT NOT NULL ,
  `nome_centro` VARCHAR(45) NULL ,
  `Campus_id_campus` INT NOT NULL ,
  PRIMARY KEY (`numero_centro`) ,
  INDEX `fk_Centro_Campus1` (`Campus_id_campus` ASC) ,
  CONSTRAINT `fk_Centro_Campus1`
    FOREIGN KEY (`Campus_id_campus` )
    REFERENCES `SistemaAcademico`.`Campus` (`id_campus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Laboratorio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Laboratorio` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Laboratorio` (
  `numero_laboratorio` INT NOT NULL ,
  `nome_laboratorio` VARCHAR(45) NULL ,
  `Centro_numero_centro` INT NOT NULL ,
  PRIMARY KEY (`numero_laboratorio`) ,
  INDEX `fk_Laboratorio_Centro1` (`Centro_numero_centro` ASC) ,
  CONSTRAINT `fk_Laboratorio_Centro1`
    FOREIGN KEY (`Centro_numero_centro` )
    REFERENCES `SistemaAcademico`.`Centro` (`numero_centro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Formacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Formacao` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Formacao` (
  `id_formacao` INT NOT NULL ,
  `titulo_formacao` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_formacao`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Estado` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Estado` (
  `idEstado` INT NOT NULL AUTO_INCREMENT ,
  `uf` VARCHAR(2) NULL ,
  `nome_estado` VARCHAR(45) NULL ,
  PRIMARY KEY (`idEstado`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Cidade` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Cidade` (
  `idCidade` INT NOT NULL ,
  `Estado_idEstado` INT NULL ,
  `sigla_estado` VARCHAR(2) NULL ,
  `nome_cidade` VARCHAR(45) NULL ,
  PRIMARY KEY (`idCidade`) ,
  INDEX `fk_Cidade_Estado1` (`Estado_idEstado` ASC) ,
  CONSTRAINT `fk_Cidade_Estado1`
    FOREIGN KEY (`Estado_idEstado` )
    REFERENCES `SistemaAcademico`.`Estado` (`idEstado` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Pessoa` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Pessoa` (
  `idPessoa` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NULL ,
  `email` VARCHAR(60) NULL ,
  `RG` VARCHAR(15) NULL ,
  `CPF` VARCHAR(13) NULL ,
  `lograduro` VARCHAR(45) NULL ,
  `numero` INT NULL ,
  `complemento` VARCHAR(45) NULL ,
  `bairro` VARCHAR(30) NULL ,
  `CEP` VARCHAR(9) NULL ,
  `Cidade_idCidade` INT NULL ,
  PRIMARY KEY (`idPessoa`) ,
  INDEX `fk_Pessoa_Cidade1` (`Cidade_idCidade` ASC) ,
  CONSTRAINT `fk_Pessoa_Cidade1`
    FOREIGN KEY (`Cidade_idCidade` )
    REFERENCES `SistemaAcademico`.`Cidade` (`idCidade` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Professor` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Professor` (
  `registro_professor` INT NOT NULL ,
  `Laboratorio_numero_laboratorio` INT NOT NULL ,
  `Pessoa_idPessoa` INT NOT NULL ,
  PRIMARY KEY (`registro_professor`, `Pessoa_idPessoa`) ,
  INDEX `fk_Professor_Laboratorio1` (`Laboratorio_numero_laboratorio` ASC) ,
  INDEX `fk_Professor_Pessoa1` (`Pessoa_idPessoa` ASC) ,
  CONSTRAINT `fk_Professor_Laboratorio1`
    FOREIGN KEY (`Laboratorio_numero_laboratorio` )
    REFERENCES `SistemaAcademico`.`Laboratorio` (`numero_laboratorio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professor_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa` )
    REFERENCES `SistemaAcademico`.`Pessoa` (`idPessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Professor_Tem_Formacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Professor_Tem_Formacao` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Professor_Tem_Formacao` (
  `Formacao_id_formacao` INT NOT NULL ,
  `Professor_registro_professor` INT NOT NULL ,
  PRIMARY KEY (`Formacao_id_formacao`, `Professor_registro_professor`) ,
  INDEX `fk_Formacao_has_Professor_Professor1` (`Professor_registro_professor` ASC) ,
  INDEX `fk_Formacao_has_Professor_Formacao` (`Formacao_id_formacao` ASC) ,
  CONSTRAINT `fk_Formacao_has_Professor_Formacao`
    FOREIGN KEY (`Formacao_id_formacao` )
    REFERENCES `SistemaAcademico`.`Formacao` (`id_formacao` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Formacao_has_Professor_Professor1`
    FOREIGN KEY (`Professor_registro_professor` )
    REFERENCES `SistemaAcademico`.`Professor` (`registro_professor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Tipo_Curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Tipo_Curso` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Tipo_Curso` (
  `id_tipo_curso` INT NOT NULL ,
  `tipo` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_tipo_curso`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Curso` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Curso` (
  `codigo_curso` INT NOT NULL ,
  `Tipo_Curso_id_tipo_curso` INT NOT NULL ,
  `Laboratorio_numero_laboratorio` INT NOT NULL ,
  `nome_curso` VARCHAR(45) NULL ,
  PRIMARY KEY (`codigo_curso`) ,
  INDEX `fk_Curso_tipo_curso1` (`Tipo_Curso_id_tipo_curso` ASC) ,
  INDEX `fk_Curso_Laboratorio1` (`Laboratorio_numero_laboratorio` ASC) ,
  CONSTRAINT `fk_Curso_tipo_curso1`
    FOREIGN KEY (`Tipo_Curso_id_tipo_curso` )
    REFERENCES `SistemaAcademico`.`Tipo_Curso` (`id_tipo_curso` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Curso_Laboratorio1`
    FOREIGN KEY (`Laboratorio_numero_laboratorio` )
    REFERENCES `SistemaAcademico`.`Laboratorio` (`numero_laboratorio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Disciplina` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Disciplina` (
  `codigo_disciplina` VARCHAR(45) NOT NULL ,
  `nome_disciplina` VARCHAR(45) NULL ,
  `Laboratorio_numero_laboratorio` INT NOT NULL ,
  PRIMARY KEY (`codigo_disciplina`) ,
  INDEX `fk_Disciplina_Laboratorio1` (`Laboratorio_numero_laboratorio` ASC) ,
  CONSTRAINT `fk_Disciplina_Laboratorio1`
    FOREIGN KEY (`Laboratorio_numero_laboratorio` )
    REFERENCES `SistemaAcademico`.`Laboratorio` (`numero_laboratorio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Periodo_Letivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Periodo_Letivo` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Periodo_Letivo` (
  `id_periodo_letivo` INT NOT NULL ,
  `ano` YEAR NULL ,
  `semestre` INT NULL ,
  PRIMARY KEY (`id_periodo_letivo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Diciplina_Oferecida`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Diciplina_Oferecida` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Diciplina_Oferecida` (
  `Periodo_Letivo_id_periodo_letivo` INT NOT NULL ,
  `Disciplina_codigo_disciplina` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`Periodo_Letivo_id_periodo_letivo`, `Disciplina_codigo_disciplina`) ,
  INDEX `fk_Disciplinas_Oferecidas_has_Periodo_Letivo_Periodo_Letivo1` (`Periodo_Letivo_id_periodo_letivo` ASC) ,
  INDEX `fk_Periodo_Letivo_Tem_Disciplinas_Oferecidas_Disciplina1` (`Disciplina_codigo_disciplina` ASC) ,
  CONSTRAINT `fk_Disciplinas_Oferecidas_has_Periodo_Letivo_Periodo_Letivo10`
    FOREIGN KEY (`Periodo_Letivo_id_periodo_letivo` )
    REFERENCES `SistemaAcademico`.`Periodo_Letivo` (`id_periodo_letivo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Periodo_Letivo_Tem_Disciplinas_Oferecidas_Disciplina1`
    FOREIGN KEY (`Disciplina_codigo_disciplina` )
    REFERENCES `SistemaAcademico`.`Disciplina` (`codigo_disciplina` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Matriz_Curricular`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Matriz_Curricular` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Matriz_Curricular` (
  `ano_matriz` INT NOT NULL AUTO_INCREMENT ,
  `Curso_codigo_curso` INT NOT NULL ,
  PRIMARY KEY (`ano_matriz`, `Curso_codigo_curso`) ,
  CONSTRAINT `fk_Grade_Curso1`
    FOREIGN KEY (`Curso_codigo_curso` )
    REFERENCES `SistemaAcademico`.`Curso` (`codigo_curso` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Disciplina_Matriz`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Disciplina_Matriz` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Disciplina_Matriz` (
  `Matriz_Curricular_ano_matriz` INT NOT NULL ,
  `Disciplina_codigo_disciplina` VARCHAR(45) NOT NULL ,
  `periodo_disciplina_matriz` INT NOT NULL ,
  `numero_creditos` INT NOT NULL ,
  PRIMARY KEY (`Matriz_Curricular_ano_matriz`, `Disciplina_codigo_disciplina`) ,
  INDEX `fk_Matriz_Curricular_has_Disciplina_Disciplina1` (`Disciplina_codigo_disciplina` ASC) ,
  INDEX `fk_Matriz_Curricular_has_Disciplina_Matriz_Curricular1` (`Matriz_Curricular_ano_matriz` ASC) ,
  CONSTRAINT `fk_Matriz_Curricular_has_Disciplina_Matriz_Curricular1`
    FOREIGN KEY (`Matriz_Curricular_ano_matriz` )
    REFERENCES `SistemaAcademico`.`Matriz_Curricular` (`ano_matriz` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matriz_Curricular_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_codigo_disciplina` )
    REFERENCES `SistemaAcademico`.`Disciplina` (`codigo_disciplina` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Turma` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Turma` (
  `id_turma` INT NOT NULL ,
  `Diciplina_Oferecida_Periodo_Letivo_id_periodo_letivo` INT NOT NULL ,
  `Diciplina_Oferecida_Disciplina_codigo_disciplina` VARCHAR(45) NOT NULL ,
  `Professor_registro_professor` INT NOT NULL ,
  PRIMARY KEY (`id_turma`) ,
  INDEX `fk_Turma_Diciplina_Oferecida1` (`Diciplina_Oferecida_Periodo_Letivo_id_periodo_letivo` ASC, `Diciplina_Oferecida_Disciplina_codigo_disciplina` ASC) ,
  INDEX `fk_Turma_Professor1` (`Professor_registro_professor` ASC) ,
  CONSTRAINT `fk_Turma_Diciplina_Oferecida1`
    FOREIGN KEY (`Diciplina_Oferecida_Periodo_Letivo_id_periodo_letivo` , `Diciplina_Oferecida_Disciplina_codigo_disciplina` )
    REFERENCES `SistemaAcademico`.`Diciplina_Oferecida` (`Periodo_Letivo_id_periodo_letivo` , `Disciplina_codigo_disciplina` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_Professor1`
    FOREIGN KEY (`Professor_registro_professor` )
    REFERENCES `SistemaAcademico`.`Professor` (`registro_professor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Predio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Predio` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Predio` (
  `id_predio` INT NOT NULL ,
  `nome_predio` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_predio`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Sala` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Sala` (
  `numero_sala` INT NOT NULL ,
  PRIMARY KEY (`numero_sala`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Horario` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Horario` (
  `id_horario` INT NOT NULL ,
  `hora_inicio` TIME NOT NULL ,
  `hora_fim` TIME NOT NULL ,
  `dia_semana` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_horario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Local` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Local` (
  `idLocal` INT NOT NULL ,
  `Predio_id_predio` INT NOT NULL ,
  `Sala_numero_sala` INT NOT NULL ,
  PRIMARY KEY (`idLocal`, `Predio_id_predio`, `Sala_numero_sala`) ,
  INDEX `fk_Local_Predio1_idx` (`Predio_id_predio` ASC) ,
  INDEX `fk_Local_Sala1_idx` (`Sala_numero_sala` ASC) ,
  CONSTRAINT `fk_Local_Predio1`
    FOREIGN KEY (`Predio_id_predio` )
    REFERENCES `SistemaAcademico`.`Predio` (`id_predio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Local_Sala1`
    FOREIGN KEY (`Sala_numero_sala` )
    REFERENCES `SistemaAcademico`.`Sala` (`numero_sala` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Turma_has_Horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Turma_has_Horario` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Turma_has_Horario` (
  `Turma_id_turma` INT NOT NULL ,
  `Horario_id_horario` INT NOT NULL ,
  `Local_idLocal` INT NOT NULL ,
  PRIMARY KEY (`Turma_id_turma`, `Horario_id_horario`, `Local_idLocal`) ,
  INDEX `fk_Turma_has_Horario_Horario1_idx` (`Horario_id_horario` ASC) ,
  INDEX `fk_Turma_has_Horario_Turma1_idx` (`Turma_id_turma` ASC) ,
  INDEX `fk_Turma_has_Horario_Local1_idx` (`Local_idLocal` ASC) ,
  CONSTRAINT `fk_Turma_has_Horario_Turma1`
    FOREIGN KEY (`Turma_id_turma` )
    REFERENCES `SistemaAcademico`.`Turma` (`id_turma` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_has_Horario_Horario1`
    FOREIGN KEY (`Horario_id_horario` )
    REFERENCES `SistemaAcademico`.`Horario` (`id_horario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_has_Horario_Local1`
    FOREIGN KEY (`Local_idLocal` )
    REFERENCES `SistemaAcademico`.`Local` (`idLocal` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Aluno` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Aluno` (
  `idAluno` INT NOT NULL AUTO_INCREMENT ,
  `Matriz_Curricular_ano_matriz` INT NOT NULL ,
  `Pessoa_idPessoa` INT NOT NULL ,
  PRIMARY KEY (`idAluno`, `Pessoa_idPessoa`) ,
  INDEX `fk_Aluno_Matriz_Curricular1_idx` (`Matriz_Curricular_ano_matriz` ASC) ,
  INDEX `fk_Aluno_Pessoa1` (`Pessoa_idPessoa` ASC) ,
  CONSTRAINT `fk_Aluno_Matriz_Curricular1`
    FOREIGN KEY (`Matriz_Curricular_ano_matriz` )
    REFERENCES `SistemaAcademico`.`Matriz_Curricular` (`ano_matriz` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa` )
    REFERENCES `SistemaAcademico`.`Pessoa` (`idPessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Plano_de_Estudo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Plano_de_Estudo` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Plano_de_Estudo` (
  `idPlano_de_Estudo` INT NOT NULL ,
  `Aluno_idAluno` INT NOT NULL ,
  PRIMARY KEY (`idPlano_de_Estudo`, `Aluno_idAluno`) ,
  INDEX `fk_Plano_de_Estudo_Aluno1_idx` (`Aluno_idAluno` ASC) ,
  CONSTRAINT `fk_Plano_de_Estudo_Aluno1`
    FOREIGN KEY (`Aluno_idAluno` )
    REFERENCES `SistemaAcademico`.`Aluno` (`idAluno` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Plano_de_Estudo_has_Turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SistemaAcademico`.`Plano_de_Estudo_has_Turma` ;

CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Plano_de_Estudo_has_Turma` (
  `Plano_de_Estudo_idPlano_de_Estudo` INT NOT NULL ,
  `Turma_id_turma` INT NOT NULL ,
  PRIMARY KEY (`Plano_de_Estudo_idPlano_de_Estudo`, `Turma_id_turma`) ,
  INDEX `fk_Plano_de_Estudo_has_Turma_Turma1_idx` (`Turma_id_turma` ASC) ,
  INDEX `fk_Plano_de_Estudo_has_Turma_Plano_de_Estudo1_idx` (`Plano_de_Estudo_idPlano_de_Estudo` ASC) ,
  CONSTRAINT `fk_Plano_de_Estudo_has_Turma_Plano_de_Estudo1`
    FOREIGN KEY (`Plano_de_Estudo_idPlano_de_Estudo` )
    REFERENCES `SistemaAcademico`.`Plano_de_Estudo` (`idPlano_de_Estudo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Plano_de_Estudo_has_Turma_Turma1`
    FOREIGN KEY (`Turma_id_turma` )
    REFERENCES `SistemaAcademico`.`Turma` (`id_turma` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `SistemaAcademico` ;

-- -----------------------------------------------------
-- Placeholder table for view `SistemaAcademico`.`view_Alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SistemaAcademico`.`view_Alunos` (`nome` INT, `idAluno` INT, `ano_entrada` INT);

-- -----------------------------------------------------
-- View `SistemaAcademico`.`view_Alunos`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `SistemaAcademico`.`view_Alunos` ;
DROP TABLE IF EXISTS `SistemaAcademico`.`view_Alunos`;
USE `SistemaAcademico`;
CREATE  OR REPLACE VIEW `SistemaAcademico`.`view_Alunos` (nome, idAluno, ano_entrada) AS
select Pessoa.nome, Aluno.idAluno, Aluno.Matriz_Curricular_ano_matriz from 
Pessoa inner join Aluno on Pessoa.idPessoa = Aluno.Pessoa_idPessoa;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

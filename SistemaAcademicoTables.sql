SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `SistemaAcademico` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `SistemaAcademico` ;

-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Campus`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Campus` (
  `id_campus` INT NOT NULL ,
  `nome_campus` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_campus`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Centro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Centro` (
  `numero_centro` INT NOT NULL ,
  `nome_centro` VARCHAR(45) NULL ,
  `Campus_id_campus` INT NOT NULL ,
  PRIMARY KEY (`numero_centro`, `Campus_id_campus`) ,
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
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Laboratorio` (
  `numero_laboratorio` INT NOT NULL ,
  `nome_laboratorio` VARCHAR(45) NULL ,
  `Centro_numero_centro` INT NOT NULL ,
  PRIMARY KEY (`numero_laboratorio`, `Centro_numero_centro`) ,
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
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Formacao` (
  `id_formacao` INT NOT NULL ,
  `titulo_formacao` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_formacao`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Professor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Professor` (
  `registro_professor` INT NOT NULL ,
  `nome_professor` VARCHAR(45) NULL ,
  `Laboratorio_numero_laboratorio` INT NOT NULL ,
  PRIMARY KEY (`registro_professor`, `Laboratorio_numero_laboratorio`) ,
  INDEX `fk_Professor_Laboratorio1` (`Laboratorio_numero_laboratorio` ASC) ,
  CONSTRAINT `fk_Professor_Laboratorio1`
    FOREIGN KEY (`Laboratorio_numero_laboratorio` )
    REFERENCES `SistemaAcademico`.`Laboratorio` (`numero_laboratorio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Professor_Tem_Formacao`
-- -----------------------------------------------------
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
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Tipo_Curso` (
  `id_tipo_curso` INT NOT NULL ,
  `tipo` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_tipo_curso`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Curso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Curso` (
  `codigo_curso` INT NOT NULL ,
  `Tipo_Curso_id_tipo_curso` INT NOT NULL ,
  `Laboratorio_numero_laboratorio` INT NOT NULL ,
  `nome_curso` VARCHAR(45) NULL ,
  PRIMARY KEY (`codigo_curso`, `Tipo_Curso_id_tipo_curso`, `Laboratorio_numero_laboratorio`) ,
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
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Disciplina` (
  `codigo_disciplina` VARCHAR(45) NOT NULL ,
  `nome_disciplina` VARCHAR(45) NULL ,
  `Laboratorio_numero_laboratorio` INT NOT NULL ,
  `Laboratorio_Centro_numero_centro` INT NOT NULL ,
  PRIMARY KEY (`codigo_disciplina`, `Laboratorio_numero_laboratorio`, `Laboratorio_Centro_numero_centro`) ,
  INDEX `fk_Disciplina_Laboratorio1` (`Laboratorio_numero_laboratorio` ASC, `Laboratorio_Centro_numero_centro` ASC) ,
  CONSTRAINT `fk_Disciplina_Laboratorio1`
    FOREIGN KEY (`Laboratorio_numero_laboratorio` , `Laboratorio_Centro_numero_centro` )
    REFERENCES `SistemaAcademico`.`Laboratorio` (`numero_laboratorio` , `Centro_numero_centro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Periodo_Letivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Periodo_Letivo` (
  `id_periodo_letivo` INT NOT NULL ,
  `ano` YEAR NULL ,
  `semestre` INT NULL ,
  PRIMARY KEY (`id_periodo_letivo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Diciplina_Oferecida`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Diciplina_Oferecida` (
  `Periodo_Letivo_id_periodo_letivo` INT NOT NULL ,
  `Disciplina_codigo_disciplina` VARCHAR(45) NOT NULL ,
  `Disciplina_Laboratorio_numero_laboratorio` INT NOT NULL ,
  `Disciplina_Laboratorio_Centro_numero_centro` INT NOT NULL ,
  PRIMARY KEY (`Periodo_Letivo_id_periodo_letivo`, `Disciplina_codigo_disciplina`, `Disciplina_Laboratorio_numero_laboratorio`, `Disciplina_Laboratorio_Centro_numero_centro`) ,
  INDEX `fk_Disciplinas_Oferecidas_has_Periodo_Letivo_Periodo_Letivo1` (`Periodo_Letivo_id_periodo_letivo` ASC) ,
  INDEX `fk_Periodo_Letivo_Tem_Disciplinas_Oferecidas_Disciplina1` (`Disciplina_codigo_disciplina` ASC, `Disciplina_Laboratorio_numero_laboratorio` ASC, `Disciplina_Laboratorio_Centro_numero_centro` ASC) ,
  CONSTRAINT `fk_Disciplinas_Oferecidas_has_Periodo_Letivo_Periodo_Letivo10`
    FOREIGN KEY (`Periodo_Letivo_id_periodo_letivo` )
    REFERENCES `SistemaAcademico`.`Periodo_Letivo` (`id_periodo_letivo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Periodo_Letivo_Tem_Disciplinas_Oferecidas_Disciplina1`
    FOREIGN KEY (`Disciplina_codigo_disciplina` , `Disciplina_Laboratorio_numero_laboratorio` , `Disciplina_Laboratorio_Centro_numero_centro` )
    REFERENCES `SistemaAcademico`.`Disciplina` (`codigo_disciplina` , `Laboratorio_numero_laboratorio` , `Laboratorio_Centro_numero_centro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Matriz_Curricular`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Matriz_Curricular` (
  `id_matriz_curricular` INT NOT NULL AUTO_INCREMENT ,
  `Curso_codigo_curso` INT NOT NULL ,
  `Curso_Tipo_Curso_id_tipo_curso` INT NOT NULL ,
  `Curso_Laboratorio_numero_laboratorio` INT NOT NULL ,
  PRIMARY KEY (`id_matriz_curricular`, `Curso_codigo_curso`, `Curso_Tipo_Curso_id_tipo_curso`, `Curso_Laboratorio_numero_laboratorio`) ,
  CONSTRAINT `fk_Grade_Curso1`
    FOREIGN KEY (`Curso_codigo_curso` , `Curso_Tipo_Curso_id_tipo_curso` , `Curso_Laboratorio_numero_laboratorio` )
    REFERENCES `SistemaAcademico`.`Curso` (`codigo_curso` , `Tipo_Curso_id_tipo_curso` , `Laboratorio_numero_laboratorio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Disciplina_Matriz`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Disciplina_Matriz` (
  `Matriz_Curricular_id_matriz_curricular` INT NOT NULL ,
  `Matriz_Curricular_Curso_codigo_curso` INT NOT NULL ,
  `Matriz_Curricular_Curso_Tipo_Curso_id_tipo_curso` INT NOT NULL ,
  `Matriz_Curricular_Curso_Laboratorio_numero_laboratorio` INT NOT NULL ,
  `Disciplina_codigo_disciplina` VARCHAR(45) NOT NULL ,
  `Disciplina_Laboratorio_numero_laboratorio` INT NOT NULL ,
  `Disciplina_Laboratorio_Centro_numero_centro` INT NOT NULL ,
  `periodo_disciplina_matriz` INT NOT NULL ,
  PRIMARY KEY (`Matriz_Curricular_id_matriz_curricular`, `Matriz_Curricular_Curso_codigo_curso`, `Matriz_Curricular_Curso_Tipo_Curso_id_tipo_curso`, `Matriz_Curricular_Curso_Laboratorio_numero_laboratorio`, `Disciplina_codigo_disciplina`, `Disciplina_Laboratorio_numero_laboratorio`, `Disciplina_Laboratorio_Centro_numero_centro`) ,
  INDEX `fk_Matriz_Curricular_has_Disciplina_Disciplina1` (`Disciplina_codigo_disciplina` ASC, `Disciplina_Laboratorio_numero_laboratorio` ASC, `Disciplina_Laboratorio_Centro_numero_centro` ASC) ,
  INDEX `fk_Matriz_Curricular_has_Disciplina_Matriz_Curricular1` (`Matriz_Curricular_id_matriz_curricular` ASC, `Matriz_Curricular_Curso_codigo_curso` ASC, `Matriz_Curricular_Curso_Tipo_Curso_id_tipo_curso` ASC, `Matriz_Curricular_Curso_Laboratorio_numero_laboratorio` ASC) ,
  CONSTRAINT `fk_Matriz_Curricular_has_Disciplina_Matriz_Curricular1`
    FOREIGN KEY (`Matriz_Curricular_id_matriz_curricular` , `Matriz_Curricular_Curso_codigo_curso` , `Matriz_Curricular_Curso_Tipo_Curso_id_tipo_curso` , `Matriz_Curricular_Curso_Laboratorio_numero_laboratorio` )
    REFERENCES `SistemaAcademico`.`Matriz_Curricular` (`id_matriz_curricular` , `Curso_codigo_curso` , `Curso_Tipo_Curso_id_tipo_curso` , `Curso_Laboratorio_numero_laboratorio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matriz_Curricular_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_codigo_disciplina` , `Disciplina_Laboratorio_numero_laboratorio` , `Disciplina_Laboratorio_Centro_numero_centro` )
    REFERENCES `SistemaAcademico`.`Disciplina` (`codigo_disciplina` , `Laboratorio_numero_laboratorio` , `Laboratorio_Centro_numero_centro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Predio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Predio` (
  `id_predio` INT NOT NULL ,
  `nome_predio` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_predio`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Sala`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Sala` (
  `numero_sala` INT NOT NULL ,
  `Predio_id_predio` INT NOT NULL ,
  PRIMARY KEY (`numero_sala`, `Predio_id_predio`) ,
  INDEX `fk_Sala_Predio1` (`Predio_id_predio` ASC) ,
  CONSTRAINT `fk_Sala_Predio1`
    FOREIGN KEY (`Predio_id_predio` )
    REFERENCES `SistemaAcademico`.`Predio` (`id_predio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Horario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Horario` (
  `id_horario` INT NOT NULL ,
  `hora_inicio` TIME NOT NULL ,
  `hora_fim` TIME NOT NULL ,
  PRIMARY KEY (`id_horario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SistemaAcademico`.`Turma`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `SistemaAcademico`.`Turma` (
  `id_turma` INT NOT NULL ,
  `Diciplina_Oferecida_Periodo_Letivo_id_periodo_letivo` INT NOT NULL ,
  `Diciplina_Oferecida_Disciplina_codigo_disciplina` VARCHAR(45) NOT NULL ,
  `Diciplina_Oferecida_Disciplina_Laboratorio_numero_laboratorio` INT NOT NULL ,
  `Diciplina_Oferecida_Disciplina_Laboratorio_Centro_numero_centro` INT NOT NULL ,
  `Professor_registro_professor` INT NOT NULL ,
  `Professor_Laboratorio_numero_laboratorio` INT NOT NULL ,
  `Sala_numero_sala` INT NOT NULL ,
  `Sala_Predio_id_predio` INT NOT NULL ,
  `Horario_id_horario` INT NOT NULL ,
  PRIMARY KEY (`id_turma`, `Diciplina_Oferecida_Periodo_Letivo_id_periodo_letivo`, `Diciplina_Oferecida_Disciplina_codigo_disciplina`, `Diciplina_Oferecida_Disciplina_Laboratorio_numero_laboratorio`, `Diciplina_Oferecida_Disciplina_Laboratorio_Centro_numero_centro`, `Professor_registro_professor`, `Professor_Laboratorio_numero_laboratorio`, `Sala_numero_sala`, `Sala_Predio_id_predio`, `Horario_id_horario`) ,
  INDEX `fk_Turma_Diciplina_Oferecida1` (`Diciplina_Oferecida_Periodo_Letivo_id_periodo_letivo` ASC, `Diciplina_Oferecida_Disciplina_codigo_disciplina` ASC, `Diciplina_Oferecida_Disciplina_Laboratorio_numero_laboratorio` ASC, `Diciplina_Oferecida_Disciplina_Laboratorio_Centro_numero_centro` ASC) ,
  INDEX `fk_Turma_Professor1` (`Professor_registro_professor` ASC, `Professor_Laboratorio_numero_laboratorio` ASC) ,
  INDEX `fk_Turma_Sala1` (`Sala_numero_sala` ASC, `Sala_Predio_id_predio` ASC) ,
  INDEX `fk_Turma_Horario1` (`Horario_id_horario` ASC) ,
  CONSTRAINT `fk_Turma_Diciplina_Oferecida1`
    FOREIGN KEY (`Diciplina_Oferecida_Periodo_Letivo_id_periodo_letivo` , `Diciplina_Oferecida_Disciplina_codigo_disciplina` , `Diciplina_Oferecida_Disciplina_Laboratorio_numero_laboratorio` , `Diciplina_Oferecida_Disciplina_Laboratorio_Centro_numero_centro` )
    REFERENCES `SistemaAcademico`.`Diciplina_Oferecida` (`Periodo_Letivo_id_periodo_letivo` , `Disciplina_codigo_disciplina` , `Disciplina_Laboratorio_numero_laboratorio` , `Disciplina_Laboratorio_Centro_numero_centro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_Professor1`
    FOREIGN KEY (`Professor_registro_professor` , `Professor_Laboratorio_numero_laboratorio` )
    REFERENCES `SistemaAcademico`.`Professor` (`registro_professor` , `Laboratorio_numero_laboratorio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_Sala1`
    FOREIGN KEY (`Sala_numero_sala` , `Sala_Predio_id_predio` )
    REFERENCES `SistemaAcademico`.`Sala` (`numero_sala` , `Predio_id_predio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_Horario1`
    FOREIGN KEY (`Horario_id_horario` )
    REFERENCES `SistemaAcademico`.`Horario` (`id_horario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

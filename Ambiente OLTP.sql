-----------------------------------------------------
--             TABELA ENDEREÇO
-----------------------------------------------------
CREATE TABLE TB_Endereco (
  END_Codigo INT NOT NULL,
  END_Estado VARCHAR(45) NULL,
  END_Cidade VARCHAR(45) NULL,
  END_Bairro VARCHAR(45) NULL,
  END_Rua VARCHAR(45) NULL,
  END_Numero INT NULL,
  END_Cep VARCHAR(9) NULL,
  END_Complemento VARCHAR(45) NULL)

ALTER TABLE TB_Endereco ADD CONSTRAINT PK_ENDERECO_CODIGO PRIMARY KEY (END_Codigo)
-----------------------------------------------------
--             TABELA USUARIO
-----------------------------------------------------
CREATE TABLE TB_Usuario (
  USU_Codigo INT NOT NULL,
  USU_Nome VARCHAR(45) NULL,
  USU_Email VARCHAR(45) NULL,
  USU_Senha VARCHAR(10) NULL,
  USU_DataNascimento DATE NULL,
  USU_Telefone VARCHAR(15) NULL,
  USU_Cpf VARCHAR(13) NULL,
  USU_Rg VARCHAR(15) NULL,
  USU_Foto VARBINARY(MAX) NULL,
  USU_Digital VARBINARY(MAX) NOT NULL,
  END_Codigo INT NOT NULL)

ALTER TABLE TB_Usuario ADD CONSTRAINT PK_USUARIO_CODIGO PRIMARY KEY (USU_Codigo)
ALTER TABLE TB_Usuario ADD CONSTRAINT FK_TB_ENDERECO_END_CODIGO FOREIGN KEY(END_Codigo) REFERENCES TB_Endereco(END_Codigo)

-----------------------------------------------------
--             TABELA ALUNO
-----------------------------------------------------
CREATE TABLE TB_Aluno (
  ALU_Codigo INT NOT NULL,
  ALU_DataEntrada DATE NULL,
  ALU_Objetivo VARCHAR(45) NULL,
  ALU_Status VARCHAR(10) NOT NULL,
  USU_Codigo INT NOT NULL,
  END_Codigo INT NOT NULL)
 
 ALTER TABLE TB_Aluno ADD CONSTRAINT PK_ALUNO_CODIGO PRIMARY KEY (ALU_Codigo)
 ALTER TABLE TB_Aluno ADD CONSTRAINT FK_TB_USUARIO_ENDERECO FOREIGN KEY (USU_Codigo , END_Codigo) 
 REFERENCES TB_Usuario (USU_Codigo , END_Codigo)
 
-----------------------------------------------------
--             TABELA ORIENTADOR
-----------------------------------------------------
CREATE TABLE TB_Orientador (
  ORI_Codigo INT NOT NULL,
  ORI_Cref VARCHAR(15) NULL,
  ORI_Especialidade VARCHAR(45) NULL,
  USU_Codigo INT NOT NULL,
  END_Codigo INT NOT NULL)

 ALTER TABLE TB_Orientador ADD CONSTRAINT PK_ORIENTADOR_CODIGO PRIMARY KEY (ORI_Codigo)
 ALTER TABLE TB_Orientador ADD CONSTRAINT FK_TB_USUARIO_ENDERECO FOREIGN KEY (USU_Codigo , END_Codigo) 
 REFERENCES TB_Usuario (USU_Codigo , END_Codigo)
-----------------------------------------------------
--             TABELA MEDIDAS
-----------------------------------------------------
CREATE TABLE TB_Medidas (
  MED_Codigo INT NOT NULL,
  MED_Abdomem FLOAT NULL,
  MED_Cintura FLOAT NULL,
  MED_Biceps FLOAT NULL,
  MED_Coxa FLOAT NULL,
  MED_Panturrilha FLOAT NULL,
  MED_Torax FLOAT NULL,
  MED_Quadril FLOAT NULL,
  MED_Peso FLOAT NULL,
  MED_Altura FLOAT NULL,
  MED_Imc FLOAT NULL,
  MED_Data DATE NULL,
  ALU_Codigo INT NOT NULL,
  ORI_Codigo INT NOT NULL)

 ALTER TABLE TB_Medidas ADD CONSTRAINT PK_MEDIDAS_CODIGO PRIMARY KEY (MED_Codigo)
 ALTER TABLE TB_Medidas ADD CONSTRAINT FK_TB_ALUNO FOREIGN KEY (ALU_Codigo) REFERENCES TB_Aluno (ALU_Codigo)
 ALTER TABLE TB_Medidas ADD CONSTRAINT FK_TB_ORIENTADOR FOREIGN KEY (ORI_Codigo) REFERENCES TB_Orientador (ORI_Codigo)

-----------------------------------------------------
--             TABELA EXERCICIO
-----------------------------------------------------
CREATE TABLE TB_Exercicio (
  EXE_Codigo INT NOT NULL,
  EXE_Ilustracao VARBINARY(MAX) NULL,
  EXE_Modalidade VARCHAR(15) NULL,
  EXE_Nome VARCHAR(15) NULL)

  ALTER TABLE TB_Exercicio ADD CONSTRAINT PK_EXERCICIO_CODIGO PRIMARY KEY (EXE_Codigo)
-----------------------------------------------------
--             TABELA ANAMNESE
-----------------------------------------------------
CREATE TABLE TB_Anamnse (
  ANA_Codigo INT NOT NULL,
  ANA_Pergunta VARCHAR(255) NULL,
  TB_Anamnsecol VARCHAR(45) NULL)

  ALTER TABLE TB_Anamnese ADD CONSTRAINT PK_ANAMNESE_CODIGO PRIMARY KEY (ANA_Codigo)
-----------------------------------------------------
--             TABELA RESPOSTA ANAMNESE
-----------------------------------------------------
CREATE TABLE TB_RespostaAnmnese (
  RES_Codigo INT NOT NULL,
  TB_Aluno_ALU_Codigo INT NOT NULL,
  TB_Anamnse_ANA_Codigo INT NOT NULL,
  RES_Anamnese VARCHAR(225) NULL)
  
  ALTER TABLE TB_RespostaAnamnese ADD CONSTRAINT PK_RESPOSTA_ANAMNESE_CODIGO PRIMARY KEY (RES_Codigo)
  ALTER TABLE TB_RespostaAnamnese ADD CONSTRAINT FK_TB_ALUNO FOREIGN KEY (ALU_Codigo) REFERENCES TB_Aluno (ALU_Codigo)
  ALTER TABLE TB_RespostaAnamnese ADD CONSTRAINT FK_TB_ANAMNESE FOREIGN KEY (ANA_Codigo) REFERENCES TB_Anamnese (ANA_Codigo)
-----------------------------------------------------
--             TABELA TREINO
-----------------------------------------------------
CREATE TABLE TB_Treino (
  TRE_Codigo INT NOT NULL,
  TB_Orientador_ORI_Codigo INT NOT NULL,
  TRE_Dia VARCHAR(45) NULL,
  TB_Aluno_ALU_Codigo INT NOT NULL,
  PRIMARY KEY (TRE_Codigo, TB_Aluno_ALU_Codigo),
  INDEX fk_TB_Treino_TB_Orientador1_idx (TB_Orientador_ORI_Codigo ASC),
  INDEX fk_TB_Treino_TB_Aluno1_idx (TB_Aluno_ALU_Codigo ASC),
  CONSTRAINT fk_TB_Treino_TB_Orientador1
    FOREIGN KEY (TB_Orientador_ORI_Codigo)
    REFERENCES TB_Orientador (ORI_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_TB_Treino_TB_Aluno1
    FOREIGN KEY (TB_Aluno_ALU_Codigo)
    REFERENCES TB_Aluno (ALU_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
-----------------------------------------------------
--             TABELA EXERCICIO POR TREINO
-----------------------------------------------------
CREATE TABLE TB_ExercicioPorTreino (
  TB_Exercicio_EXE_Codigo INT NOT NULL,
  TB_Treino_TRE_Codigo INT NOT NULL,
  TB_Treino_TB_Aluno_ALU_Codigo INT NOT NULL,
  EXT_Repeticao INT NULL,
  EXT_Serie INT NULL,
  EXT_Carga INT NULL,
  PRIMARY KEY (TB_Exercicio_EXE_Codigo, TB_Treino_TRE_Codigo, TB_Treino_TB_Aluno_ALU_Codigo),
  INDEX fk_TB_ExercicioPorTreino_TB_Treino1_idx (TB_Treino_TRE_Codigo ASC, TB_Treino_TB_Aluno_ALU_Codigo ASC),
  CONSTRAINT fk_TB_ExercicioPorTreino_TB_Exercicio1
    FOREIGN KEY (TB_Exercicio_EXE_Codigo)
    REFERENCES TB_Exercicio (EXE_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_TB_ExercicioPorTreino_TB_Treino1
    FOREIGN KEY (TB_Treino_TRE_Codigo , TB_Treino_TB_Aluno_ALU_Codigo)
    REFERENCES TB_Treino (TRE_Codigo , TB_Aluno_ALU_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
-----------------------------------------------------
--             TABELA ADMINISTRADOR
-----------------------------------------------------
CREATE TABLE TB_Administrador (
  ADM_Codigo INT NOT NULL,
  TB_Usuario_USU_Codigo INT NOT NULL,
  TB_Usuario_TB_Endereco_END_Codigo INT NOT NULL,
  PRIMARY KEY (ADM_Codigo),
  INDEX fk_TB_Administrador_TB_Usuario1_idx (TB_Usuario_USU_Codigo ASC, TB_Usuario_TB_Endereco_END_Codigo ASC),
  CONSTRAINT fk_TB_Administrador_TB_Usuario1
    FOREIGN KEY (TB_Usuario_USU_Codigo , TB_Usuario_TB_Endereco_END_Codigo)
    REFERENCES TB_Usuario (USU_Codigo , TB_Endereco_END_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
-----------------------------------------------------
--             TABELA PACOTE
-----------------------------------------------------
CREATE TABLE TB_Pacote (
  PAC_Codigo INT NOT NULL,
  PAC_Nome VARCHAR(45) NULL,
  PAC_Valor FLOAT NULL)

  ALTER TABLE TB_Pacote ADD CONSTRAINT PK_PACOTE_CODIGO PRIMARY KEY (PAC_Codigo)
-----------------------------------------------------
--             TABELA ACADEMIA
-----------------------------------------------------
CREATE TABLE TB_Academia (
  ACA_Codigo INT NOT NULL,
  ACA_RazaoSocial VARCHAR(45) NULL,
  TB_Endereco_END_Codigo INT NOT NULL,
  ACA_Cnpj VARCHAR(30) NULL,
  PRIMARY KEY (ACA_Codigo, TB_Endereco_END_Codigo),
  INDEX fk_TB_Academia_TB_Endereco1_idx (TB_Endereco_END_Codigo ASC),
  CONSTRAINT fk_TB_Academia_TB_Endereco1
    FOREIGN KEY (TB_Endereco_END_Codigo)
    REFERENCES TB_Endereco (END_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
-----------------------------------------------------
--             TABELA MENSALIDADE
-----------------------------------------------------
CREATE TABLE TB_Mensalidade (
  MEN_Codigo INT NOT NULL,
  MEN_DataPagamento DATE NULL,
  MEN_PagamentoMes DATE NULL,
  TB_Administrador_ADM_Codigo INT NOT NULL,
  TB_Aluno_ALU_Codigo INT NOT NULL,
  TB_Pacote_PAC_Codigo INT NOT NULL,
  TB_Academia_ACA_Codigo INT NOT NULL,
  TB_Academia_TB_Endereco_END_Codigo INT NOT NULL,
  PRIMARY KEY (MEN_Codigo, TB_Aluno_ALU_Codigo, TB_Academia_ACA_Codigo, TB_Academia_TB_Endereco_END_Codigo),
  INDEX fk_TB_Mensalidade_TB_Administrador1_idx (TB_Administrador_ADM_Codigo ASC),
  INDEX fk_TB_Mensalidade_TB_Aluno1_idx (TB_Aluno_ALU_Codigo ASC),
  INDEX fk_TB_Mensalidade_TB_Pacote1_idx (TB_Pacote_PAC_Codigo ASC),
  INDEX fk_TB_Mensalidade_TB_Academia1_idx (TB_Academia_ACA_Codigo ASC, TB_Academia_TB_Endereco_END_Codigo ASC),
  CONSTRAINT fk_TB_Mensalidade_TB_Administrador1
    FOREIGN KEY (TB_Administrador_ADM_Codigo)
    REFERENCES TB_Administrador (ADM_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_TB_Mensalidade_TB_Aluno1
    FOREIGN KEY (TB_Aluno_ALU_Codigo)
    REFERENCES TB_Aluno (ALU_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_TB_Mensalidade_TB_Pacote1
    FOREIGN KEY (TB_Pacote_PAC_Codigo)
    REFERENCES TB_Pacote (PAC_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_TB_Mensalidade_TB_Academia1
    FOREIGN KEY (TB_Academia_ACA_Codigo , TB_Academia_TB_Endereco_END_Codigo)
    REFERENCES TB_Academia (ACA_Codigo , TB_Endereco_END_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
-----------------------------------------------------
--             TABELA TURNO
-----------------------------------------------------
CREATE TABLE TB_Turno (
  ALU_Codigo INT NOT NULL,
  ALU_Turno VARCHAR(45) NULL)

  ALTER TABLE TB_Turno ADD CONSTRAINT PK_TURNO_CODIGO PRIMARY KEY (TURNO_Codigo)
-----------------------------------------------------
--             TABELA FLUXO
-----------------------------------------------------
CREATE TABLE TB_Fluxo (
  TUR_Codigo INT NOT NULL,
  TUR_DataEntrada DATETIME NOT NULL,
  ALU_DataSaida DATETIME NULL,
  TB_Aluno_ALU_Codigo INT NOT NULL,
  TB_Turno_ALU_Codigo INT NOT NULL,
  PRIMARY KEY (TUR_Codigo),
  INDEX fk_TB_Turno_TB_Aluno1_idx (TB_Aluno_ALU_Codigo ASC),
  INDEX fk_TB_Fluxo_TB_Turno1_idx (TB_Turno_ALU_Codigo ASC),
  CONSTRAINT fk_TB_Turno_TB_Aluno1
    FOREIGN KEY (TB_Aluno_ALU_Codigo)
    REFERENCES TB_Aluno (ALU_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_TB_Fluxo_TB_Turno1
    FOREIGN KEY (TB_Turno_ALU_Codigo)
    REFERENCES TB_Turno (ALU_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
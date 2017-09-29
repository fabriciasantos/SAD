CREATE DATABASE ProjetoSad
USE ProjetoSad

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
--             TABELA ACADEMIA
-----------------------------------------------------
CREATE TABLE TB_Academia (
  ACA_Codigo INT NOT NULL,
  ACA_RazaoSocial VARCHAR(45) NULL,
  END_Codigo INT NOT NULL,
  ACA_Cnpj VARCHAR(30) NULL)
  
  ALTER TABLE TB_Academia ADD CONSTRAINT PK_TB_ACADEMIA PRIMARY KEY (ACA_Codigo)
  ALTER TABLE TB_Academia ADD CONSTRAINT FK_END_COD FOREIGN KEY (END_Codigo) REFERENCES TB_Endereco (END_Codigo)

-----------------------------------------------------
--             TABELA USUARIO
-----------------------------------------------------
CREATE TABLE TB_Usuario (
  USU_Codigo INT NOT NULL IDENTITY(1,1),
  USU_Nome VARCHAR(45) NULL,
  USU_Email VARCHAR(45) NULL,
  USU_Senha VARCHAR(10) NULL,
  USU_DataNascimento DATE NULL,
  USU_Telefone VARCHAR(15) NULL,
  USU_Cpf VARCHAR(14) NULL,
  USU_Rg VARCHAR(15) NULL,
  USU_Foto VARBINARY(MAX) NULL,
  USU_Digital VARBINARY(MAX) NULL,
  END_Codigo INT NOT NULL,
  ACA_Codigo INT NOT NULL)

ALTER TABLE TB_Usuario ADD CONSTRAINT PK_USUARIO_CODIGO PRIMARY KEY (USU_Codigo)
ALTER TABLE TB_Usuario ADD CONSTRAINT FK_TB_ENDERECO_END_CODIGO FOREIGN KEY(END_Codigo) REFERENCES TB_Endereco(END_Codigo)
ALTER TABLE TB_Usuario ADD CONSTRAINT FK_ACA_CODIGO FOREIGN KEY (ACA_Codigo) REFERENCES TB_ACADEMIA (ACA_Codigo)

-----------------------------------------------------
--             TABELA ALUNO
-----------------------------------------------------
CREATE TABLE TB_Aluno (
  ALU_Codigo INT NOT NULL IDENTITY(1,1),
  ALU_DataEntrada DATE NULL,
  ALU_Objetivo VARCHAR(45) NULL,
  ALU_Status VARCHAR(10) NOT NULL,
  USU_Codigo INT NOT NULL)
 
 ALTER TABLE TB_Aluno add CONSTRAINT PK_ALUNO_CODIGO PRIMARY KEY (ALU_CODIGO)
 ALTER TABLE TB_Aluno ADD CONSTRAINT FK_USU_CODIGO FOREIGN KEY (USU_Codigo) 
 REFERENCES TB_Usuario (USU_Codigo)

-----------------------------------------------------
--             TABELA ORIENTADOR
-----------------------------------------------------
CREATE TABLE TB_Orientador (
  ORI_Codigo INT NOT NULL,
  ORI_Cref VARCHAR(15) NULL,
  ORI_Especialidade VARCHAR(45) NULL,
  USU_Codigo INT NOT NULL)
  

 ALTER TABLE TB_Orientador ADD CONSTRAINT PK_ORIENTADOR_CODIGO PRIMARY KEY (ORI_Codigo)
 ALTER TABLE TB_Orientador ADD CONSTRAINT FK_TB_USUARIO FOREIGN KEY (USU_Codigo) 
 REFERENCES TB_Usuario (USU_Codigo)
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

 ALTER TABLE TB_Medidas ADD CONSTRAINT PK_MEDIDAS_CODIGO PRIMARY KEY (MED_Codigo,ALU_Codigo)
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
  ANA_Pergunta VARCHAR(255) NULL)

  ALTER TABLE TB_Anamnse ADD CONSTRAINT PK_ANAMNESE_CODIGO PRIMARY KEY (ANA_Codigo)
-----------------------------------------------------
--             TABELA RESPOSTA ANAMNESE
-----------------------------------------------------
CREATE TABLE TB_RespostaAnmnese (
  RES_Codigo INT NOT NULL,
  ALU_Codigo INT NOT NULL,
  ANA_Codigo INT NOT NULL,
  RES_Anamnese VARCHAR(225) NULL)
  
  ALTER TABLE TB_RespostaAnmnese ADD CONSTRAINT PK_RESPOSTA_ANAMNESE_CODIGO PRIMARY KEY (RES_Codigo,ALU_Codigo)
  ALTER TABLE TB_RespostaAnmnese ADD CONSTRAINT FK_TB_ALUNO_RE FOREIGN KEY (ALU_Codigo) REFERENCES TB_Aluno (ALU_Codigo)
  ALTER TABLE TB_RespostaAnmnese ADD CONSTRAINT FK_TB_ANAMNESE_RE FOREIGN KEY (ANA_Codigo) REFERENCES TB_Anamnse (ANA_Codigo)
-----------------------------------------------------
--             TABELA TREINO
-----------------------------------------------------
CREATE TABLE TB_Treino (
  TRE_Codigo INT NOT NULL,
  ORI_Codigo INT NOT NULL,
  TRE_Dia VARCHAR(45) NULL,
  ALU_Codigo INT NOT NULL)

  ALTER TABLE TB_Treino ADD CONSTRAINT PK_TB_TREINO PRIMARY KEY (TRE_Codigo, ALU_Codigo)
  ALTER TABLE TB_Treino ADD CONSTRAINT FK_TB_TREINO_ALUNO FOREIGN KEY (ALU_Codigo) REFERENCES TB_Aluno (ALU_Codigo)
  ALTER TABLE TB_Treino ADD CONSTRAINT FK_TB_TREINO_ORIENTADOR FOREIGN KEY (ORI_Codigo) REFERENCES TB_Orientador (ORI_Codigo)
-----------------------------------------------------
--             TABELA EXERCICIO POR TREINO
-----------------------------------------------------
CREATE TABLE TB_ExercicioPorTreino (
  EXE_Codigo INT NOT NULL,
  TRE_Codigo INT NOT NULL,
  ALU_Codigo INT NOT NULL,
  EXT_Repeticao INT NULL,
  EXT_Serie INT NULL,
  EXT_Carga INT NULL)
   ALTER TABLE TB_ExercicioPorTreino ADD CONSTRAINT PK_TB_EXETREINO PRIMARY KEY (EXE_Codigo, TRE_Codigo, ALU_Codigo)
   ALTER TABLE TB_ExercicioPorTreino ADD CONSTRAINT FK_EXERCICIO_CODIGO FOREIGN KEY (EXE_Codigo) REFERENCES TB_Exercicio (EXE_Codigo)
   ALTER TABLE TB_ExercicioPorTreino ADD CONSTRAINT FK_ALUNO_COD_TREINO FOREIGN KEY (TRE_Codigo , ALU_Codigo)REFERENCES TB_Treino (TRE_Codigo, ALU_Codigo)
    
-----------------------------------------------------
--             TABELA ADMINISTRADOR
-----------------------------------------------------
CREATE TABLE TB_Administrador (
  ADM_Codigo INT NOT NULL,
  USU_Codigo INT NOT NULL)
  ALTER TABLE TB_Administrador ADD CONSTRAINT PK_TB_ADM  PRIMARY KEY (ADM_Codigo)
  ALTER TABLE TB_Administrador ADD CONSTRAINT FK_USU_COD FOREIGN KEY (USU_Codigo) REFERENCES TB_Usuario (USU_Codigo)
  
-----------------------------------------------------
--             TABELA PACOTE
-----------------------------------------------------
CREATE TABLE TB_Pacote (
  PAC_Codigo INT NOT NULL,
  PAC_Nome VARCHAR(45) NULL,
  PAC_Valor FLOAT NULL)

  ALTER TABLE TB_Pacote ADD CONSTRAINT PK_PACOTE_CODIGO PRIMARY KEY (PAC_Codigo)

-----------------------------------------------------
--             TABELA MENSALIDADE
-----------------------------------------------------
CREATE TABLE TB_Mensalidade (
  MEN_Codigo INT NOT NULL,
  MEN_DataPagamento DATE NULL,
  MEN_PagamentoMes DATE NULL,
  ADM_Codigo INT NOT NULL,
  ALU_Codigo INT NOT NULL,
  PAC_Codigo INT NOT NULL,
  ACA_Codigo INT NOT NULL)

  ALTER TABLE TB_Mensalidade ADD CONSTRAINT PK_TB_MENSALIDADE PRIMARY KEY (MEN_Codigo, ALU_Codigo, ACA_Codigo)
  ALTER TABLE TB_Mensalidade ADD CONSTRAINT FK_ADM_CODIGO FOREIGN KEY (ADM_Codigo) REFERENCES TB_Administrador (ADM_Codigo)
  ALTER TABLE TB_Mensalidade ADD CONSTRAINT FK_ALU_CODIGO FOREIGN KEY (ALU_Codigo) REFERENCES TB_Aluno (ALU_Codigo)
  ALTER TABLE TB_Mensalidade ADD CONSTRAINT FK_PAC_CODIGO FOREIGN KEY (PAC_Codigo) REFERENCES TB_Pacote (PAC_Codigo)
  ALTER TABLE TB_Mensalidade ADD CONSTRAINT FK_AC_CODIGO FOREIGN KEY (ACA_Codigo) REFERENCES TB_Academia (ACA_Codigo)
  
-----------------------------------------------------
--             TABELA TURNO
-----------------------------------------------------
CREATE TABLE TB_Turno (
  TUR_Codigo INT NOT NULL,
  TUR_Turno VARCHAR(45) NULL)

  ALTER TABLE TB_Turno ADD CONSTRAINT PK_TURNO_CODIGO PRIMARY KEY (TUR_Codigo)
-----------------------------------------------------
--             TABELA FLUXO
-----------------------------------------------------
CREATE TABLE TB_Fluxo (
  FLU_Codigo INT NOT NULL IDENTITY(1,1),
  FLU_DataEntrada DATETIME NOT NULL,
  FLU_DataSaida DATETIME NULL,
  ALU_Codigo INT NOT NULL,
  TUR_Codigo INT NOT NULL);

  ALTER TABLE TB_Fluxo ADD CONSTRAINT PK_TB_FLUXO PRIMARY KEY (FLU_Codigo)
  ALTER TABLE TB_Fluxo ADD CONSTRAINT FK_ALUNO_CODIGO FOREIGN KEY (ALU_Codigo) REFERENCES TB_Aluno (ALU_Codigo)
  ALTER TABLE TB_Fluxo ADD CONSTRAINT FK_TUR_CODIGO FOREIGN KEY (TUR_Codigo) REFERENCES TB_Turno (TUR_Codigo)
  
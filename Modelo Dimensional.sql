DROP TABLE DIM_Tempo
DROP TABLE DIM_Empresa
DROP TABLE DIM_Pacote
DROP TABLE DIM_Aluno
DROP TABLE DIM_FaixaEtaria
DROP TABLE DIM_Localizacao
DROP TABLE DIM_Horario
DROP TABLE DIM_Turno
DROP TABLE FATO_Fluxo
-----------------------------------------------------
--             DIMENSÃO TEMPO
-----------------------------------------------------
CREATE TABLE DIM_Tempo (
  Cod_Tempo INT NOT NULL,
  Data DATE NULL,
  Ano DATE NULL,
  Mes DATE NULL,
  Dia DATE NULL,
  Semestre VARCHAR(15) NULL)

  ALTER TABLE DIM_Tempo ADD CONSTRAINT PK_DIM_TEMPO PRIMARY KEY (Cod_Tempo)
-----------------------------------------------------
--             DIMENSÃO EMPRESA
-----------------------------------------------------
 CREATE TABLE DIM_Empresa (
  Id_Empresa INT NOT NULL,
  Cod_Empresa INT NULL,
  NomeEmpresa VARCHAR(45) NULL)

  ALTER TABLE DIM_Empresa ADD CONSTRAINT PK_DIM_EMPRESA PRIMARY KEY (Id_Empresa) 

-----------------------------------------------------
--             DIMENSÃO PACOTE
-----------------------------------------------------
  CREATE TABLE DIM_Pacote (
  Id_Pacote INT NOT NULL,
  Cod_Pacote INT NULL,
  NomePacote VARCHAR(45) NULL,
  ValorPacote FLOAT NULL)

ALTER TABLE DIM_Pacote ADD CONSTRAINT PK_DIM_PACOTE PRIMARY KEY (Id_Pacote) 

-----------------------------------------------------
--             DIMENSÃO ALUNO
-----------------------------------------------------
CREATE TABLE DIM_Aluno (
  id_Aluno INT NOT NULL,
  Cod_Aluno INT NULL,
  NomeAluno VARCHAR(45) NULL)
  
  ALTER TABLE DIM_Aluno ADD CONSTRAINT PK_DIM_ALUNO PRIMARY KEY (Id_Aluno) 

-----------------------------------------------------
--             DIMENSÃO FAIXA ETARIA
-----------------------------------------------------
CREATE TABLE DIM_FaixaEtaria (
  Id_FaixaEtaria INT NOT NULL,
  Cod_FaixaEtaria INT NULL,
  FaixaEtaria VARCHAR(10) NULL)

  ALTER TABLE DIM_FaixaEtaria ADD CONSTRAINT PK_DIM_FAIXAETARIA PRIMARY KEY (Id_FaixaEtaria) 
-----------------------------------------------------
--             DIMENSÃO LOCALIZAÇÃO
-----------------------------------------------------
CREATE TABLE DIM_Localizacao (
  Id_Localizacao INT NOT NULL,
  Cod_Localizacao INT NULL,
  Estado VARCHAR(2) NULL,
  Cidade VARCHAR(30) NULL,
  Bairro VARCHAR(30) NULL)

  ALTER TABLE DIM_Localizacao ADD CONSTRAINT PK_DIM_LOCALIZACAO PRIMARY KEY (Id_Localizacao) 

-----------------------------------------------------
--             DIMENSÃO HORARIO
-----------------------------------------------------
CREATE TABLE DIM_Horario (
  Cod_Horario INT NOT NULL,
  Hora DATETIME NULL,
  Minuto DATETIME NULL)

  ALTER TABLE DIM_Horario ADD CONSTRAINT PK_DIM_HORARIO PRIMARY KEY (Cod_Horario) 

-----------------------------------------------------
--             DIMENSÃO TURNO
-----------------------------------------------------
CREATE TABLE DIM_Turno (
  Id_Turno INT NOT NULL,
  Cod_Turno INT NULL,
  NomeTurno VARCHAR(45) NULL)

  ALTER TABLE DIM_Turno ADD CONSTRAINT PK_DIM_TURNO PRIMARY KEY (Id_Turno) 

-----------------------------------------------------
--             DIMENSÃO FATO FLUXO
-----------------------------------------------------
CREATE TABLE FATO_Fluxo (
  id_FATO_Fluxo INT NOT NULL,
  Cod_Fluxo INT NOT NULL,
  Cod_Data INT NOT NULL,
  Cod_HorarioEntrada DATETIME NOT NULL,
  Cod_HorarioSaida DATETIME NOT NULL,
  Cod_Aluno INT NOT NULL,
  Cod_Pacote INT NOT NULL,
  Cod_Empresa INT NOT NULL,
  Cod_FaixaEtaria INT NOT NULL,
  Cod_Localizacao INT NOT NULL,
  Cod_Turno INT NOT NULL,
  Quantidade INT NULL)

  ALTER TABLE FATO_Fluxo ADD CONSTRAINT PK_FATO_FLUXO PRIMARY KEY (id_FATO_Fluxo, Cod_Data, Cod_HorarioEntrada, Cod_HorarioSaida, Cod_Aluno, Cod_Pacote, Cod_Empresa, Cod_FaixaEtaria, Cod_Localizacao, Cod_Turno)
  ALTER TABLE FATO_Fluxo ADD CONSTRAINT FK_DIM_TEMPO FOREIGN KEY (Cod_Data) REFERENCES DIM_Tempo (Cod_Tempo)
  ALTER TABLE FATO_Fluxo ADD CONSTRAINT FK_DIM_ALUNO FOREIGN KEY (Cod_Aluno) REFERENCES DIM_Aluno (id_Aluno)
  ALTER TABLE FATO_Fluxo ADD CONSTRAINT FK_DIM_PACOTE FOREIGN KEY (Cod_Pacote) REFERENCES DIM_Pacote (Id_Pacote)
  ALTER TABLE FATO_Fluxo ADD CONSTRAINT FK_DIM_EMPRESA FOREIGN KEY (Cod_Empresa) REFERENCES DIM_Empresa (Id_Empresa)
  ALTER TABLE FATO_Fluxo ADD CONSTRAINT FK_DIM_FAIXAETARIA FOREIGN KEY (Cod_FaixaEtaria) REFERENCES DIM_FaixaEtaria (Id_FaixaEtaria)
  ALTER TABLE FATO_Fluxo ADD CONSTRAINT FK_DIM_LOCALIZACAO FOREIGN KEY (Cod_Localizacao) REFERENCES DIM_Localizacao (Id_Localizacao)
  ALTER TABLE FATO_Fluxo ADD CONSTRAINT FK_DIM_HORARIO1 FOREIGN KEY (Cod_HorarioEntrada, Cod_HorarioSaida) REFERENCES DIM_Horario (Cod_Horario)
  ALTER TABLE FATO_Fluxo ADD CONSTRAINT FK_DIM_TURNO FOREIGN KEY (Cod_Turno) REFERENCES DIM_Turno (Id_Turno)   
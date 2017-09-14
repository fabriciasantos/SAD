CREATE TABLE TB_AUX_ALUNO(
DATA_CARGA DATETIME NOT NULL,
ALU_Codigo INT NOT NULL, 
ALU_Nome VARCHAR(50) NULL
)

CREATE TABLE TB_AUX_LOCALIZACAO(
DATA_CARGA DATETIME NOT NULL,
LOC_Codigo INT NOT NULL,
LOC_Estado VARCHAR(50) NULL, 
LOC_Cidade VARCHAR(50) NULL,
LOC_Bairro VARCHAR(50) NULL
)

CREATE TABLE TB_AUX_ACADEMIA(
DATA_CARGA DATETIME NOT NULL,
EMP_Codigo INT NOT NULL,
EMP_Nome VARCHAR(50) NULL
)

CREATE TABLE TB_AUX_HORARIO(
DATA_CARGA DATETIME NOT NULL,
HOR_Codigo INT NOT NULL,
HOR_Hora INT NULL,
HOR_Minuto INT NULL,
HOR_Flag VARCHAR(15) NULL
)



CREATE TABLE TB_AUX_TURNO(
DATA_CARGA DATETIME NOT NULL,
TUR_Codigo INT NOT NULL,
TUR_Nome VARCHAR(50) NULL
)


CREATE TABLE TB_AUX_FLUXO(
DATA_CARGA DATETIME NOT NULL, 
FLU_Codigo INT NOT NULL,
FLU_HorarioEntrada DATETIME NULL,
FLU_HorarioSaida DATETIME NULL,
FLU_CodAluno INT NULL,
FLU_CodEmpresa INT NULL,
FLU_CodTurno INT NULL
)

CREATE TABLE TB_VIO_AUX_FLUXO(
DATA_CARGA DATETIME NOT NULL, 
FLU_Codigo INT NOT NULL,
FLU_HorarioEntrada INT NULL,
FLU_HorarioSaida INT NULL,
FLU_CodAluno INT NULL,
FLU_CodPacote INT NULL,
FLU_CodEmpresa INT NULL,
FLU_CodLocalizacao INT NULL,
FLU_CodTurno INT NULL,
DATAERRO DATETIME NULL,
ERRO VARCHAR(255) NULL
)
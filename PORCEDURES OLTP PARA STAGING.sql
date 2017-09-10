/*
PROCEDIMENTOS PARA A CARGA DA �REA OPERACIONAL PARA A �REA DE STAGING
*/

-- CARGA PARA TB_AUX_PACOTE
CREATE PROCEDURE SP_OLTP_PACOTE(@DATACARGA DATETIME) AS
BEGIN
	DELETE FROM TB_AUX_PACOTE WHERE  DATA_CARGA = @DATACARGA
	DECLARE @CODIGO INT, @NOME VARCHAR(60), @VALOR NUMERIC(10,2)	
	DECLARE CR_INSERT CURSOR FOR SELECT P.PAC_Codigo, P.PAC_Nome, P.PAC_Valor FROM  TB_Pacote P;
	OPEN CR_INSERT
		FETCH CR_INSERT INTO @CODIGO, @NOME, @VALOR
		WHILE(@@FETCH_STATUS = 0 )
		BEGIN
			INSERT TB_AUX_PACOTE VALUES(@DATACARGA, @CODIGO, @NOME, @VALOR);
			FETCH CR_INSERT INTO @CODIGO, @NOME, @VALOR
		END
	CLOSE CR_INSERT
	DEALLOCATE CR_INSERT
END

/* TESTES
exec SP_OLTP_PACOTE'20170102'
select * from TB_AUX_PACOTE
truncate table TB_AUX_PACOTE
*/

-- CARGA PARA TB_AUX_ALUNO
CREATE PROCEDURE SP_OLTP_ALUNO(@DATACARGA DATETIME) AS
BEGIN
	DELETE FROM TB_AUX_ALUNO WHERE  DATA_CARGA = @DATACARGA
	DECLARE @CODIGO INT, @NOME VARCHAR(60)	
	DECLARE CR_INSERT_ALUNO CURSOR FOR SELECT A.ALU_Codigo, U.USU_Nome FROM  TB_Aluno A	INNER JOIN TB_Usuario U ON (A.USU_Codigo =U.USU_Codigo);
	OPEN CR_INSERT_ALUNO
		FETCH CR_INSERT_ALUNO INTO @CODIGO, @NOME
		WHILE(@@FETCH_STATUS = 0 )
		BEGIN
			INSERT TB_AUX_ALUNO VALUES(@DATACARGA, @CODIGO, @NOME);
			FETCH CR_INSERT_ALUNO INTO @CODIGO, @NOME
		END
	CLOSE CR_INSERT_ALUNO
	DEALLOCATE CR_INSERT_ALUNO
END

/* TESTES
exec SP_OLTP_ALUNO '20170102'
select * from TB_AUX_ALUNO
truncate table TB_AUX_ALUNO
*/

-- CARGA PARA TB_AUX_LOCALIZACAO
CREATE PROCEDURE SP_OLTP_LOCALIZACAO(@DATACARGA DATETIME) AS
BEGIN
	DELETE FROM TB_AUX_LOCALIZACAO WHERE  DATA_CARGA = @DATACARGA
	DECLARE @CODIGO INT, @ESTADO VARCHAR(60), @CIDADE VARCHAR(60), @BAIRRO VARCHAR(60)	
	DECLARE CR_INSERT_LOCALIZACAO CURSOR FOR SELECT E.END_Codigo, E.END_Estado, E.END_Cidade, E.END_Bairro FROM  TB_Endereco E;
	OPEN CR_INSERT_LOCALIZACAO
		FETCH CR_INSERT_LOCALIZACAO INTO @CODIGO, @ESTADO, @CIDADE, @BAIRRO
		WHILE(@@FETCH_STATUS = 0 )
		BEGIN
			INSERT TB_AUX_LOCALIZACAO VALUES(@DATACARGA, @CODIGO, @ESTADO, @CIDADE, @BAIRRO);
			FETCH CR_INSERT_LOCALIZACAO INTO @CODIGO, @ESTADO, @CIDADE, @BAIRRO
		END
	CLOSE CR_INSERT_LOCALIZACAO
	DEALLOCATE CR_INSERT_LOCALIZACAO
END

/* TESTES
exec SP_OLTP_LOCALIZACAO '20170102'
select * from TB_AUX_LOCALIZACAO
truncate table TB_AUX_LOCALIZACAO
*/

--CARGA PARA TB_AUX_ACADEMIA
CREATE PROCEDURE SP_OLTP_ACADEMIA(@DATACARGA DATETIME) AS
BEGIN
	DELETE FROM TB_AUX_ACADEMIA WHERE  DATA_CARGA = @DATACARGA
	DECLARE @CODIGO INT, @NOME VARCHAR(50)
	DECLARE CR_INSERT_ACADEMIA CURSOR FOR SELECT  ACA_Codigo, ACA_RazaoSocial FROM TB_Academia
	OPEN CR_INSERT_ACADEMIA
		FETCH CR_INSERT_ACADEMIA INTO @CODIGO, @NOME
		WHILE(@@FETCH_STATUS = 0 )
		BEGIN
			INSERT TB_AUX_ACADEMIA VALUES(@DATACARGA, @CODIGO, @NOME);
			FETCH CR_INSERT_ACADEMIA INTO @CODIGO, @NOME
		END
	CLOSE CR_INSERT_ACADEMIA
	DEALLOCATE CR_INSERT_ACADEMIA
END

--CARGA PARA TB_AUX_FAIXAETARIA
--ESSE PROCEDIMENTO PRECISA SER DEBATIDO
CREATE PROCEDURE SP_OLTP_HORARIO(@DATACARGA DATETIME) AS
BEGIN
	DELETE FROM TB_AUX_HORARIO WHERE  DATA_CARGA = @DATACARGA
	DECLARE @CODIGO INT, @DT DATETIME, @HORA INT, @MINUTO INT
	DECLARE CR_INSERT_HORARIO CURSOR FOR SELECT  FLU_Codigo, FLU_DataEntrada FROM TB_Fluxo
	OPEN CR_INSERT_HORARIO
		FETCH CR_INSERT_HORARIO INTO @CODIGO, @DT
		WHILE(@@FETCH_STATUS = 0 )
		BEGIN
			SET @HORA = DATEPART(HH,@DT)
			SET @MINUTO = DATEPART(MM,@DT)
			INSERT TB_AUX_HORARIO VALUES(@DATACARGA, @HORA,@MINUTO);
			FETCH CR_INSERT_HORARIO INTO @CODIGO, @DT
		END
	CLOSE CR_INSERT_HORARIO
	DEALLOCATE CR_INSERT_HORARIO
END

--CARGA PARA TB_AUX_TURNO
CREATE PROCEDURE SP_OLTP_TURNO(@DATACARGA DATETIME) AS
BEGIN
	DELETE FROM TB_AUX_TURNO WHERE  DATA_CARGA = @DATACARGA
	DECLARE @CODIGO INT,@NOME VARCHAR(15)
	DECLARE CR_INSERT_TURNO CURSOR FOR SELECT  TUR_Codigo,TUR_Turno FROM TB_Turno
	OPEN CR_INSERT_TURNO
		FETCH CR_INSERT_TURNO INTO @CODIGO, @NOME
		WHILE(@@FETCH_STATUS = 0 )
		BEGIN			
			INSERT TB_AUX_FLUXO VALUES(@DATACARGA, @CODIGO, @NOME);
			FETCH CR_INSERT_TURNO INTO @CODIGO, @NOME
		END
	CLOSE CR_INSERT_TURNO
	DEALLOCATE CR_INSERT_TURNO
END
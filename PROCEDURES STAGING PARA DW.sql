/*
 * Procedimentos para a carga da área de Staging para o ambiente OLAP
 *
*/
-- DIMENSÃO EMPRESA TIPO 2
CREATE PROCEDURE SP_DIM_ACADEMIA (@DATACARGA DATETIME) AS
BEGIN
	DECLARE @NOME VARCHAR(60), @NOMEA VARCHAR(60), @CODIGO INT
	DECLARE CR_VARRE_AUX CURSOR FOR
SELECT a.EMP_Nome, a.EMP_Codigo from TB_AUX_ACADEMIA a WHERE a.DATA_CARGA = @DATACARGA
	OPEN CR_VARRE_AUX
	FETCH CR_VARRE_AUX INTO @NOME, @CODIGO
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		IF(EXISTS(SELECT E.Cod_Empresa FROM DIM_Empresa E where E.Cod_Empresa = @codigo and E.FLAG = 'SIM'))
		BEGIN
			SET @NOMEA = (SELECT E.NomeEmpresa FROM DIM_Empresa E WHERE E.Cod_Empresa = @codigo and E.FLAG = 'SIM')
			IF(@NOME <> @NOMEA)
			BEGIN
				UPDATE DIM_EMPRESA SET FLAG = 'NÃO', DT_FIM = @DATACARGA WHERE Cod_Empresa = @CODIGO AND FLAG = 'SIM'
				INSERT INTO DIM_EMPRESA VALUES(@CODIGO,@NOME,@DATACARGA,NULL,'SIM')
			END
		END
		ELSE
		BEGIN
			INSERT INTO DIM_EMPRESA VALUES(@CODIGO,@NOME,@DATACARGA,NULL,'SIM')
		END
		FETCH CR_VARRE_AUX INTO @NOME, @CODIGO
	END
	CLOSE CR_VARRE_AUX
	DEALLOCATE CR_VARRE_AUX
END

/*
update TB_AUX_ACADEMIA set EMP_Nome = 'Academia Form and Muscle' where EMP_Codigo = 1
select * from TB_AUX_ACADEMIA
EXEC SP_DIM_ACADEMIA'20170102'
select * from DIM_Empresa
*/

-- DIMENSÃO ALUNO TIPO 1
ALTER PROCEDURE SP_DIM_ALUNO (@DATACARGA DATETIME) AS
BEGIN
	DECLARE @NOME VARCHAR(60), @NOMEA VARCHAR(60), @CODIGO INT

	DECLARE CR_VARRE_AUX_ALUNO CURSOR FOR 
	SELECT a.ALU_Nome, a.ALU_Codigo FROM TB_AUX_ALUNO a WHERE a.DATA_CARGA = @DATACARGA

	OPEN CR_VARRE_AUX_ALUNO
	FETCH CR_VARRE_AUX_ALUNO INTO @NOME, @CODIGO
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		IF(EXISTS(SELECT A.Cod_Aluno FROM DIM_Aluno A WHERE A.Cod_Aluno = @CODIGO))
		BEGIN
			SET @NOMEA = (SELECT A.NomeAluno FROM DIM_Aluno A WHERE A.Cod_Aluno = @CODIGO)
			IF(@NOME <> @NOMEA)
			BEGIN
				UPDATE DIM_ALUNO SET NomeAluno = @NOME WHERE Cod_Aluno = @CODIGO
			END
		END
		ELSE
		BEGIN
			INSERT INTO DIM_ALUNO VALUES(@CODIGO,@NOME)
		END
		FETCH CR_VARRE_AUX_ALUNO INTO @NOME, @CODIGO
	END
	CLOSE CR_VARRE_AUX_ALUNO
	DEALLOCATE CR_VARRE_AUX_ALUNO
END

/*
update TB_AUX_ALUNO set ALU_Nome = 'Ana Freitas Santos' where ALU_Codigo = 1
select * from TB_AUX_ALUNO
EXEC SP_DIM_ALUNO '20170102'
select * from DIM_Aluno
/*  PROCEDIMENTO PARA A DIMENSAO TURNO */
ALTER PROCEDURE SP_DIM_TURNO(@DataCarga DATETIME)
AS
BEGIN
	
	Declare C_Cursor CURSOR FOR
					select TUR_Codigo, TUR_Nome from TB_AUX_TURNO
							where DATA_CARGA = @DataCarga
	
	DECLARE @codigo INT, @nome varchar(45), @contador INT
	OPEN C_Cursor
	FETCH C_Cursor INTO @codigo, @nome
	WHILE (@@FETCH_STATUS = 0)
		BEGIN
		
		select @contador =  count(t.Cod_Turno) from DIM_Turno t
			  where t.Cod_Turno = @codigo 			

		IF (@contador = 0)
			begin
			INSERT INTO DIM_Turno(Cod_Turno,NomeTurno) VALUES (@codigo, @nome)
			end
		else
			begin
			UPDATE DIM_Turno SET NomeTurno = @nome
					where Cod_Turno = @codigo
			end
		FETCH C_Cursor INTO @codigo, @nome
		END

	CLOSE C_Cursor
	DEALLOCATE C_Cursor

END

/*
SELECT * FROM TB_AUX_TURNO
EXEC SP_DIM_TURNO '02-01-2017'
SELECT * FROM dim_turno
*/

/*DIMENSÃO LOCALIZAÇÃO*/
CREATE PROCEDURE SP_DIM_LOCALIZACAO (@DATA DATETIME) AS
BEGIN
	DECLARE @LOC_Codigo INT,@LOC_Estado VARCHAR(45),@LOC_Cidade VARCHAR(45),@Loc_Bairro VARCHAR(45)
	DECLARE CR_INSERT_DIMLOCALIZACAO CURSOR FOR 
	SELECT LOC_Codigo, LOC_Estado, LOC_Cidade, Loc_Bairro FROM TB_AUX_LOCALIZACAO WHERE @DATA = DATA_CARGA
	OPEN CR_INSERT_DIMLOCALIZACAO
	FETCH CR_INSET_DIMLOCALIZACAO INTO @LOC_Codigo, @LOC_Estado, @LOC_Cidade, @Loc_Bairro
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		IF(EXISTS(SELECT LOC_Codigo FROM DIM_LOCALIZACAO WHERE @LOC_Codigo = Cod_Localizacao))
			UPDATE DIM_LOCALIZAÇÃO SET LOC_Estado = @LOC_Estado, LOC_Cidade = @LOC_Cidade, LOC_Bairro = @Loc_Bairro WHERE LOC_Codigo = @LOC_Codigo	 
		ELSE
			INSERT INTO DIM_LOCALIZACAO(LOC_Codigo, LOC_Estado, LOC_Cidade, LOC_Bairro) VALUES(@LOC_Codigo, @LOC_Estado, @LOC_Cidade, @Loc_Bairro)
		FETCH CR_INSET_DIMLOCALIZACAO INTO @LOC_Codigo, @LOC_Estado, @LOC_Cidade, @Loc_Bairro
	END
	CLOSE CR_INSET_DIMLOCALIZACAO
	DEALLOCATE CR_INSET_DIMLOCALIZACAO
END

/*INSERT PARA A DIMENSÃO FAIXA ETARIA*/
INSERT INTO DIM_FAIXAETARIA VALUES('Jovem')
INSERT INTO DIM_FAIXAETARIA VALUES('Adulto')
INSERT INTO DIM_FAIXAETARIA VALUES('Idoso')
*/
CREATE PROCEDURE DIM_Fluxo(@DataCarga DATETIME)
AS
BEGIN
	DECLARE C_Cursor CURSOR FOR
					SELECT f.FLU_Codigo, f.FLU_HorarioEntrada, f.FLU_HorarioSaida,
						        f.FLU_CodAluno, f.FLU_CodEmpresa, f.FLU_CodTurno FROM TB_AUX_FLUXO f
								WHERE f.DATA_CARGA = @DataCarga

	DECLARE @cod_fluxo INT, @h_entrada DATETIME, @h_saida DATETIME, @cod_aluno INT, @cod_empresa INT, @cod_turno INT
	OPEN C_Cursor

	FETCH C_Cursor INTO @cod_fluxo, @h_entrada, @h_saida, @cod_aluno, @cod_empresa, @cod_turno
	
	WHILE (@@FETCH_STATUS = 0)
		BEGIN
		DECLARE @id_fato_fluxo INT, @cod_fluxo_fato INT, @cod_data_fato INT, @cod_horarioEntrada_fato INT, @cod_horarioSaida_fato INT,
				@cod_aluno_fato INT, @cod_empresa_fato INT, @cod_faixaEtaria_fato INT, @cod_localizacao_fato INT, @cod_turno_fato INT

		select @cod_data_fato = t.Id_Tempo FROM DIM_Tempo t
											where t.Data = @h_entrada
		
		IF (NOT EXISTS (select h.id_Horario FROM DIM_Horario h
							where h.hora = (SELECT DATEPART(hh,@h_entrada)) AND h.Minuto = (SELECT DATEPART(mi,@h_entrada)) AND h.Flag = 'ENTRADA'))
			BEGIN
			/* O QUE COLOCAR NO CAMPO DA INTERROGACAO: ??????????? */
			INSERT INTO DIM_Horario(Cod_Horario, Hora, Minuto, Flag) VALUES (????, DATEPART(hh,@h_entrada), DATEPART(mi,@h_entrada), 'ENTRADA')
			select @cod_horarioEntrada_fato = h.id_Horario FROM DIM_Horario h
							where h.hora = (SELECT DATEPART(hh,@h_entrada)) AND h.Minuto = (SELECT DATEPART(mi,@h_entrada)) AND h.Flag = 'ENTRADA'
			END
		ELSE
			BEGIN
			select @cod_horarioEntrada_fato = h.id_Horario FROM DIM_Horario h
							where h.hora = (SELECT DATEPART(hh,@h_entrada)) AND h.Minuto = (SELECT DATEPART(mi,@h_entrada)) AND h.Flag = 'ENTRADA'
			END

		IF (NOT EXISTS (select h.id_Horario FROM DIM_Horario h
							where h.hora = (SELECT DATEPART(hh,@h_saida)) AND h.Minuto = (SELECT DATEPART(mi,@h_saida)) AND h.Flag = 'SAIDA'))
			BEGIN
			/* O QUE COLOCAR NO CAMPO DA INTERROGACAO: ??????????? */
			INSERT INTO DIM_Horario(Cod_Horario, Hora, Minuto, Flag) VALUES (????, DATEPART(hh,@h_entrada), DATEPART(mi,@h_entrada), 'SAIDA')
			select @cod_horarioEntrada_fato = h.id_Horario FROM DIM_Horario h
							where h.hora = (SELECT DATEPART(hh,@h_saida)) AND h.Minuto = (SELECT DATEPART(mi,@h_saida)) AND h.Flag = 'SAIDA'
			END
		ELSE
			BEGIN
			select @cod_horarioEntrada_fato = h.id_Horario FROM DIM_Horario h
							where h.hora = (SELECT DATEPART(hh,@h_saida)) AND h.Minuto = (SELECT DATEPART(mi,@h_saida)) AND h.Flag = 'SAIDA'
			END

		select @cod_data_fato = a.id_aluno FROM DIM_Aluno a
				where a.Cod_Aluno = @cod_aluno

		select @cod_empresa_fato = max(e.id_empresa) FROM DIM_Empresa e
				where e.Cod_Empresa = @cod_empresa

		DECLARE @ano_nascimento INT, @idade INT
		select @ano_nascimento = YEAR(u.USU_DataNascimento) FROM TB_Usuario u
												INNER JOIN TB_Aluno a ON (a.USU_Codigo = u.USU_Codigo)
												where a.ALU_Codigo = @cod_aluno
		SET @idade = YEAR(GETDATE()) - @ano_nascimento
		IF (@idade <= 21)
			begin
			select @cod_faixaEtaria_fato = fe.Id_FaixaEtaria FROM DIM_FaixaEtaria fe
					where fe.FaixaEtaria = 'Jovem'
			end
		ELSE IF (@idade > 21 and @idade < 60)
			begin
			select @cod_faixaEtaria_fato = fe.Id_FaixaEtaria FROM DIM_FaixaEtaria fe
					where fe.FaixaEtaria = 'Adulto'
			end
		ELSE IF (@idade >= 60)
			begin
			select @cod_faixaEtaria_fato = fe.Id_FaixaEtaria FROM DIM_FaixaEtaria fe
					where fe.FaixaEtaria = 'Idoso'
			end

		DECLARE @cod_endereco_fato INT, @cod_endereco INT

		select @cod_endereco = e.END_Codigo from TB_Usuario u
							INNER JOIN TB_Aluno a ON (a.USU_Codigo = u.USU_Codigo)
							INNER JOIN TB_Endereco e ON (e.END_Codigo = u.END_Codigo)
							where a.ALU_Codigo = @cod_aluno
	
		select @cod_endereco_fato = l.Cod_Localizacao FROM DIM_Localizacao l
				where l.Cod_Localizacao = @cod_endereco
				
		select @cod_turno_fato = t.Id_Turno FROM DIM_Turno t
			where t.Cod_Turno = @cod_turno

		DECLARE @CONTADOR INT, @ID INT
		
		DELETE FROM FATO_Fluxo
				WHERE (Cod_Aluno = @cod_aluno_fato AND Cod_Data = @cod_data_fato AND Cod_Empresa = @cod_empresa_fato AND
					   Cod_HorarioEntrada = @cod_horarioEntrada_fato AND Cod_HorarioSaida = @cod_horarioSaida_fato   AND
					   Cod_Empresa = @cod_empresa_fato AND Cod_FaixaEtaria = @cod_faixaEtaria_fato                   AND
					   Cod_Localizacao = @cod_localizacao_fato AND Cod_Turno = @cod_turno_fato)
		
		INSERT INTO FATO_Fluxo(Cod_Data, Cod_HorarioEntrada, Cod_HorarioSaida, Cod_Aluno, Cod_Empresa, Cod_FaixaEtaria, Cod_Localizacao, Cod_Turno, Quantidade)
					VALUES (@cod_data_fato, @cod_horarioEntrada_fato, @cod_horarioSaida_fato, @cod_aluno_fato, @cod_empresa_fato, @cod_faixaEtaria_fato, @cod_localizacao_fato, @cod_turno_fato, 1)
				

		FETCH C_Cursor INTO @cod_fluxo, @h_entrada, @h_saida, @cod_aluno, @cod_empresa, @cod_turno
		END 
	

	CLOSE C_Cursor
	DEALLOCATE C_CURSOR
END
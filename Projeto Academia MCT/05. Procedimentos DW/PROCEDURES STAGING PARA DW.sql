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
CREATE PROCEDURE SP_DIM_ALUNO (@DATACARGA DATETIME) AS
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
select * from DIM_Aluno */


/*  PROCEDIMENTO PARA A DIMENSAO TURNO */
CREATE PROCEDURE SP_DIM_TURNO(@DataCarga DATETIME)
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
		
	DECLARE C_Cursor CURSOR FOR 
						SELECT LOC_Codigo, LOC_Estado, LOC_Cidade, Loc_Bairro FROM TB_AUX_LOCALIZACAO WHERE @DATA = DATA_CARGA
	OPEN C_Cursor
	FETCH C_Cursor INTO @LOC_Codigo, @LOC_Estado, @LOC_Cidade, @Loc_Bairro
	
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		IF(EXISTS(SELECT Cod_Localizacao FROM DIM_LOCALIZACAO WHERE @LOC_Codigo = Cod_Localizacao))
			UPDATE DIM_LOCALIZACAO SET Cod_Localizacao = @LOC_Codigo, Cidade = @LOC_Cidade, Bairro = @Loc_Bairro, Estado = @LOC_Estado WHERE Cod_Localizacao = @LOC_Codigo	 
		ELSE
			INSERT INTO DIM_LOCALIZACAO(Cod_Localizacao, Estado, Cidade, Bairro) VALUES(@LOC_Codigo, @LOC_Estado, @LOC_Cidade, @Loc_Bairro)

	FETCH C_Cursor INTO @LOC_Codigo, @LOC_Estado, @LOC_Cidade, @Loc_Bairro
	END

	CLOSE C_Cursor
	DEALLOCATE C_Cursor
END

/* 
	select * from tb_aux_localizacao
	EXEC SP_DIM_LOCALIZACAO '20170102'
	select * from dim_localizacao
*/


/*INSERT PARA A DIMENSÃO FAIXA ETARIA*/
INSERT INTO DIM_FAIXAETARIA VALUES('Jovem')
INSERT INTO DIM_FAIXAETARIA VALUES('Adulto')
INSERT INTO DIM_FAIXAETARIA VALUES('Idoso')

/* CARGA PARA A DIM HORARIO*/
CREATE PROCEDURE SP_DIM_HORARIO (@DATACARGA DATETIME) AS
BEGIN
	DECLARE @cod_hora INT, @hora INT, @minuto INT, @flag varchar(10)

	DECLARE C_Cursor CURSOR FOR 
				SELECT h.HOR_Codigo, h.HOR_Hora, h.HOR_Minuto, h.HOR_Flag FROM TB_AUX_HORARIO h WHERE h.DATA_CARGA = @DATACARGA

	OPEN C_Cursor
	FETCH C_Cursor INTO @cod_hora, @hora, @minuto, @flag
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		IF(EXISTS(SELECT h.Cod_Horario FROM DIM_HORARIO h WHERE h.Cod_Horario = @cod_hora AND h.Flag = @flag))
		BEGIN
				UPDATE DIM_Horario SET Cod_Horario = @cod_hora, Hora = @hora, Minuto = @minuto, Flag = @flag  WHERE Cod_Horario = @cod_hora
		END
		ELSE
		BEGIN
			INSERT INTO DIM_Horario(Cod_Horario, Hora, Minuto, Flag) VALUES(@cod_hora, @hora, @minuto, @flag)
		END
		FETCH C_Cursor INTO @cod_hora, @hora, @minuto, @flag
	END
	CLOSE C_Cursor
	DEALLOCATE C_Cursor
END

/*select * from TB_AUX_HORARIO
exec SP_DIM_HORARIO '20170102'
select * from DIM_Horario*/

--PROCEDIMENTO PARA DIMENSAO TEMPO
create procedure SP_Dim_Tempo(@dataInicio datetime, @dataFinal datetime) as
begin
	set language Brazilian
	declare @start datetime, @end datetime
	set @start = case 
					when (@dataInicio <= @dataFinal) then @dataInicio
					else @dataFinal
				end
	set @end = case 
					when (@dataInicio >= @dataFinal) then @dataInicio
					else @dataFinal
				end
	if(exists(select t.Data from DIM_Tempo t where t.Data = @end))
		print 'Data já existente'
	else
	begin
		declare @nivel varchar(8), @dat datetime, @dia int, @diaSemana varchar(25), @util char(3), @quinzena smallint,
				@fimSemana char(3), @mes smallint, @nomemes varchar(20), @fimmes char(3), @trimestre smallint, @nometrimestre varchar(20),
				@semestre smallint, @nomeSemestre varchar(20), @ano int
		while (@start <= @end)
		begin
				set @ano =  DATEPART(YYYY,@start)
				if(not exists(select t.Mes from DIM_Tempo t where t.Ano = DATEPART(YYYY,@start)))
				begin
					set @ano =  DATEPART(YYYY,@start)
					set @nivel = 'ANO'
					insert into DIM_Tempo values(@nivel,@start,null,null,null,null,null,null,null,null,null,null,
										null,null,null,null,@ano);
				end
				if(not exists(select t.Mes from DIM_Tempo t where t.Mes = DATEPART(MM,@start)))
				begin
					set @nivel = 'MES';
					set @ano = DATEPART(YYYY,@start);
					select @mes = DATEPART(MM,@start), @nomemes = DATENAME(MM, @start),
						@trimestre = case
										when (DATEPART(MM,@start) <= 3) then 1
										when (DATEPART(MM,@start) <= 6) then 2
										when (DATEPART(MM,@start) <= 9) then 3
										else 4
									end,
						@nometrimestre = case
										when (DATEPART(MM,@start) <= 3) then '1º Trimestre/'+(convert(varchar,@ano))
										when (DATEPART(MM,@start) <= 6) then '2º Trimestre/'+(convert(varchar,@ano))
										when (DATEPART(MM,@start) <= 9) then '3º Trimestre/'+(convert(varchar,@ano))
										else '4º Trimestre/'+str(@ano)
									end,
						@semestre = case
										when (DATEPART(MM,@start) <= 6) then 1
										else 2
									end,
						@nomeSemestre = case
										when (DATEPART(MM,@start) <= 6) then '1º Semestre/'+(convert(varchar,@ano))
										else '2º Semestre/'+(convert(varchar,@ano))
									end;
						insert into DIM_Tempo values(@nivel,@start,null,null,null,null,null,null,null,@mes,@nomemes,null,
										@trimestre,@nometrimestre,@semestre,@nomeSemestre,@ano);
				end
				select @nivel = 'DIA', @dat = @start, @dia = DATEPART(DD,@start), @diaSemana = DATENAME(DW,@start),
						@util = case 
									when (DATENAME(dw,@start) <> 'Domingo' and DATENAME(dw,@start) <> 'Sábado' ) then 'SIM'
									else 'NÃO'
								end,
						@quinzena = case
										when (DATEPART(dd,@start) < 15) then 1
										else 2
								end,
						@fimSemana = case 
										when (DATENAME(dw,@start) = 'Domingo') then 'SIM'
										when (DATENAME(dw,@start) = 'Sábado') then 'SIM'
										else 'NÃO'
								end,
						@fimmes = case
									when (DATEPART(DD,@start) = 30 or DATEPART(DD,@start) = 31) then 'SIM'
									else 'NÃO'
								end;
				insert into DIM_Tempo values(@nivel,@dat,@dia,@diaSemana,@util,null,null,@fimSemana,@quinzena,null,null,@fimmes,null,null,null,null,@ano);
				set @start = @start+1
		end
	end	
end
/*exec SP_Dim_Tempo '20160101', '20180101'
truncate table DIM_TEMPO
select * from DIM_Tempo
*/

/* PROCEDIMENTO DO FATO */
CREATE PROCEDURE SP_FATO_Fluxo(@DataCarga DATETIME)
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
		DECLARE @id_fato_fluxo INT, @cod_data_fato INT, @cod_horarioEntrada_fato INT, @cod_horarioSaida_fato INT,
				@cod_aluno_fato INT, @cod_empresa_fato INT, @cod_faixaEtaria_fato INT, @cod_localizacao_fato INT, @cod_turno_fato INT
		
		
		select @cod_aluno_fato = a.id_Aluno FROM DIM_Aluno a
				where a.Cod_Aluno = @cod_aluno

		select @cod_horarioEntrada_fato = h.Id_Horario FROM DIM_Horario h
					where h.Cod_Horario = @cod_fluxo and h.Flag = 'ENTRADA'

		select @cod_horarioSaida_fato = h.Id_Horario FROM DIM_Horario h
					where h.Cod_Horario = @cod_fluxo and h.Flag = 'SAIDA'
		
		select @cod_data_fato = t.Id_Tempo FROM DIM_Tempo t
											where t.Data = @h_entrada
		
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

		DECLARE @cod_endereco INT

		select @cod_endereco = e.END_Codigo from TB_Usuario u
							INNER JOIN TB_Aluno a ON (a.USU_Codigo = u.USU_Codigo)
							INNER JOIN TB_Endereco e ON (e.END_Codigo = u.END_Codigo)
							where a.ALU_Codigo = @cod_aluno
	
		select @cod_localizacao_fato = l.Id_Localizacao FROM DIM_Localizacao l
				where l.Cod_Localizacao = @cod_endereco
				
		select @cod_turno_fato = t.Id_Turno FROM DIM_Turno t
			where t.Cod_Turno = @cod_turno

		DECLARE @CONTADOR INT, @ID INT
		
		DELETE FROM FATO_Fluxo
				WHERE (Cod_Aluno = @cod_aluno_fato AND Cod_Data = @cod_data_fato AND Cod_Empresa = @cod_empresa_fato AND
					   Cod_HorarioEntrada = @cod_horarioEntrada_fato AND Cod_HorarioSaida = @cod_horarioSaida_fato   AND
					   Cod_Empresa = @cod_empresa_fato AND Cod_FaixaEtaria = @cod_faixaEtaria_fato                   AND
					   Cod_Localizacao = @cod_localizacao_fato AND Cod_Turno = @cod_turno_fato)
		
		INSERT INTO FATO_Fluxo(Cod_Fluxo, Cod_Data, Cod_HorarioEntrada, Cod_HorarioSaida, Cod_Aluno, Cod_Empresa, Cod_FaixaEtaria, Cod_Localizacao, Cod_Turno, Quantidade)
					VALUES (@cod_fluxo, @cod_data_fato, @cod_horarioEntrada_fato, @cod_horarioSaida_fato, @cod_aluno_fato, @cod_empresa_fato, @cod_faixaEtaria_fato, @cod_localizacao_fato, @cod_turno_fato, 1)
				
		FETCH C_Cursor INTO @cod_fluxo, @h_entrada, @h_saida, @cod_aluno, @cod_empresa, @cod_turno
		END 
	

	CLOSE C_Cursor
	DEALLOCATE C_CURSOR
END

/*select * from TB_AUX_FLUXO
/* confiram a data do tb_aux_fluxo para executar a data certa no procedimento */
EXEC SP_FATO_Fluxo '20170902'
select * from FATO_Fluxo*/


/* TRIGGER PARA O AGREGADO */
go
create trigger TG_AGR_FLUXO on FATO_FLUXO
after insert
as
begin
	declare @codigo int, @data datetime, @codMes int, @mes int, @ano int

	declare CR_PREENCHE cursor for
	select i.Cod_Empresa, i.Cod_Data from inserted i

	open CR_PREENCHE
	fetch CR_PREENCHE into @codigo, @data
	while(@@FETCH_STATUS = 0)
	begin

	set @mes = DATEPART(MM, @data)
	set @ano = DATEPART(YYYY, @data)
	set @codMes = (select t.Id_Tempo from DIM_Tempo t where t.Mes = @mes and t.Nivel = 'MES' and t.Ano = @ano)

	if(exists(select a.Cod_Data from AGR_FLUXO_EMPRESA a where a.Cod_Data = @codMes and a.Cod_Empresa = @codigo))
		update AGR_FLUXO_EMPRESA set Quantidade = Quantidade + 1 where Cod_Data = @codMes and Cod_Empresa = @codigo
	else
		insert into AGR_FLUXO_EMPRESA values(@codMes,@codigo,1)

		fetch CR_PREENCHE into @codigo, @data
	end
	close CR_PREENCHE
	deallocate CR_PREENCHE
end
go

select *from AGR_FLUXO_EMPRESA
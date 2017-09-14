alter procedure SP_Dim_Tempo(@dataInicio datetime, @dataFinal datetime) as
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
exec SP_Dim_Tempo '20090101', '20090201'
truncate table DIM_TEMPO;
select * from DIM_Tempo;
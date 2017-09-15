/*
 * Procedimentos para a carga da área de Staging para o ambiente OLAP
 *
*/
-- DIMENSÃO EMPRESA TIPO 2
create procedure SP_DIM_ACADEMIA (@datacarga datetime) as
begin
	declare @nome varchar(60), @nomeA varchar(60), @codigo int
	
	declare CR_VARRE_AUX cursor for 
	select a.EMP_Nome, a.EMP_Codigo from TB_AUX_ACADEMIA a where a.DATA_CARGA = @datacarga

	open CR_VARRE_AUX
	fetch CR_VARRE_AUX into @nome, @codigo
	while(@@FETCH_STATUS = 0)
	begin
		if(exists(select E.Cod_Empresa from DIM_Empresa E where E.Cod_Empresa = @codigo and E.FLAG = 'SIM'))
		begin
			set @nomeA = (select E.NomeEmpresa from DIM_Empresa E where E.Cod_Empresa = @codigo and E.FLAG = 'SIM')
			if(@nome <> @nomeA)
			begin
				update DIM_Empresa set FLAG = 'NÃO', DT_FIM = @datacarga where Cod_Empresa = @codigo and FLAG = 'SIM'
				insert into DIM_EMPRESA values(@codigo,@nome,@datacarga,null,'SIM')
			end
		end
		else
		begin
			insert into DIM_EMPRESA values(@codigo,@nome,@datacarga,null,'SIM')
		end
		fetch CR_VARRE_AUX into @nome, @codigo
	end
	close CR_VARRE_AUX
	deallocate CR_VARRE_AUX

end
/*
update TB_AUX_ACADEMIA set EMP_Nome = 'Academia Form and Muscle' where EMP_Codigo = 1
select * from TB_AUX_ACADEMIA
EXEC SP_DIM_ACADEMIA'20170102'
select * from DIM_Empresa
*/

-- DIMENSÃO ALUNO TIPO 1
alter procedure SP_DIM_ALUNO (@datacarga datetime) as
begin
	declare @nome varchar(60), @nomeA varchar(60), @codigo int
	
	declare CR_VARRE_AUX_ALUNO cursor for 
	select a.ALU_Nome, a.ALU_Codigo from TB_AUX_ALUNO a where a.DATA_CARGA = @datacarga

	open CR_VARRE_AUX_ALUNO
	fetch CR_VARRE_AUX_ALUNO into @nome, @codigo
	while(@@FETCH_STATUS = 0)
	begin
		if(exists(select A.Cod_Aluno from DIM_Aluno A where A.Cod_Aluno = @codigo))
		begin
			set @nomeA = (select A.NomeAluno from DIM_Aluno A where A.Cod_Aluno = @codigo)
			if(@nome <> @nomeA)
			begin
				update DIM_Aluno set NomeAluno = @nome where Cod_Aluno = @codigo
			end
		end
		else
		begin
			insert into DIM_Aluno values(@codigo,@nome)
		end
		fetch CR_VARRE_AUX_ALUNO into @nome, @codigo
	end
	close CR_VARRE_AUX_ALUNO
	deallocate CR_VARRE_AUX_ALUNO

end

/*
update TB_AUX_ALUNO set ALU_Nome = 'Ana Freitas Santos' where ALU_Codigo = 1
select * from TB_AUX_ALUNO
EXEC SP_DIM_ALUNO '20170102'
select * from DIM_Aluno
*/

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
select * from TB_AUX_TURNO
exec sp_dim_turno '02-01-2017'
select * from dim_turno
*/
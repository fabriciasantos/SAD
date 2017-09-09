/*
PROCEDIMENTOS PARA A CARGA DA ÁREA OPERACIONAL PARA A ÁREA DE STAGING
*/

-- CARGA PARA TB_AUX_PACOTE
create procedure SP_OLTP_PACOTE(@dataCarga datetime) as
begin
	delete from TB_AUX_PACOTE where  DATA_CARGA = @dataCarga

	declare @codigo int, @nome varchar(60), @valor numeric(10,2)
	
	declare CR_INSERT cursor for
	select P.PAC_Codigo, P.PAC_Nome, P.PAC_Valor from  TB_Pacote P;

	
	open CR_INSERT
		fetch CR_INSERT into @codigo, @nome, @valor
		while(@@FETCH_STATUS = 0 )
		begin
			insert TB_AUX_PACOTE values(@dataCarga, @codigo, @nome, @valor);
			fetch CR_INSERT into @codigo, @nome, @valor
		end
	close CR_INSERT
	deallocate CR_INSERT
end

/* TESTES
exec SP_OLTP_PACOTE'20170102'
select * from TB_AUX_PACOTE
truncate table TB_AUX_PACOTE
*/

-- CARGA PARA TB_AUX_ALUNO
create procedure SP_OLTP_ALUNO(@dataCarga datetime) as
begin
	delete from TB_AUX_ALUNO where  DATA_CARGA = @dataCarga

	declare @codigo int, @nome varchar(60)
	
	declare CR_INSERT_ALUNO cursor for
	select A.ALU_Codigo, u.USU_Nome from  TB_Aluno A
	inner join TB_Usuario u on (a.USU_Codigo = u.USU_Codigo);

	
	open CR_INSERT_ALUNO
		fetch CR_INSERT_ALUNO into @codigo, @nome
		while(@@FETCH_STATUS = 0 )
		begin
			insert TB_AUX_ALUNO values(@dataCarga, @codigo, @nome);
			fetch CR_INSERT_ALUNO into @codigo, @nome
		end
	close CR_INSERT_ALUNO
	deallocate CR_INSERT_ALUNO
end

/* TESTES
exec SP_OLTP_ALUNO '20170102'
select * from TB_AUX_ALUNO
truncate table TB_AUX_ALUNO
*/

-- CARGA PARA TB_AUX_LOCALIZACAO
create procedure SP_OLTP_LOCALIZACAO(@dataCarga datetime) as
begin
	delete from TB_AUX_LOCALIZACAO where  DATA_CARGA = @dataCarga

	declare @codigo int, @estado varchar(60), @cidade varchar(60), @bairro varchar(60)
	
	declare CR_INSERT_LOCALIZACAO cursor for
	select e.END_Codigo, e.END_Estado, e.END_Cidade, e.END_Bairro from  TB_Endereco E;

	open CR_INSERT_LOCALIZACAO
		fetch CR_INSERT_LOCALIZACAO into @codigo, @estado, @cidade, @bairro
		while(@@FETCH_STATUS = 0 )
		begin
			insert TB_AUX_LOCALIZACAO values(@dataCarga, @codigo, @estado, @cidade, @bairro);
			fetch CR_INSERT_LOCALIZACAO into @codigo, @estado, @cidade, @bairro
		end
	close CR_INSERT_LOCALIZACAO
	deallocate CR_INSERT_LOCALIZACAO
end

/* TESTES
exec SP_OLTP_LOCALIZACAO '20170102'
select * from TB_AUX_LOCALIZACAO
truncate table TB_AUX_LOCALIZACAO
*/
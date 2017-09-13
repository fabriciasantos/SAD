/* PROJETO SAD - POVOAMENTO DAS TABELAS*/
 USE ProjetoSad

/* ESSES TRES PRIMEIROS SAO REFERENTES AS ACADEMIAS: UMA EM ARACAJU E DUAS EM ITABAIANA */
INSERT INTO TB_ENDERECO(END_Codigo,END_Estado,END_Cidade,END_Bairro,END_Rua,END_Numero,END_Cep)
						VALUES (1,'Sergipe','Aracaju','Coroa do Meio','Av. Mario Jorge Menezes Viêira',1680,'49035-490')

INSERT INTO TB_ENDERECO(END_Codigo,END_Estado,END_Cidade,END_Bairro,END_Rua,END_Numero,END_Cep)
						VALUES (2,'Sergipe','Itabaiana','Anísio Amâncio de Oliveira','R. Manoel Domingos Pereira',345,'4500-000')

INSERT INTO TB_ENDERECO(END_Codigo,END_Estado,END_Cidade,END_Bairro,END_Rua,END_Numero,END_Cep)
						VALUES (3,'Sergipe','Itabaiana','Centro','R. Manoel Antônio de Oliveira',635,'49500-000')

/* INSERCAO DAS ACADEMIAS*/
INSERT INTO TB_ACADEMIA(END_Codigo, ACA_RazaoSocial) VALUES (1,'Academia Corpo e Forma')
INSERT INTO TB_ACADEMIA(END_Codigo, ACA_RazaoSocial) VALUES (2,'Academia Conexão Física')
INSERT INTO TB_ACADEMIA(END_Codigo, ACA_RazaoSocial) VALUES (2,'Academia Vip Fitness')

/* ESSES REGSITROS REFERENCIAM APENAS OS BAIRROS, PORQUE É O IMPORTANTE */
INSERT INTO TB_ENDERECO(END_Codigo,END_Estado,END_Cidade,END_Bairro,END_Cep)
						VALUES (4,'Sergipe','Aracaju','Luzia','49048-500')

INSERT INTO TB_ENDERECO(END_Codigo,END_Estado,END_Cidade,END_Bairro,END_Cep)
						VALUES (5,'Sergipe','Aracaju','Jardim Centenário','49090-490')

INSERT INTO TB_ENDERECO(END_Codigo,END_Estado,END_Cidade,END_Bairro,END_Cep)
						VALUES (6,'Sergipe','Itabaiana','Rotary Club','49338-500')

INSERT INTO TB_ENDERECO(END_Codigo,END_Estado,END_Cidade,END_Bairro,END_Cep)
						VALUES (7,'Sergipe','Itabaiana','Serrano','49210-490')

INSERT INTO TB_ENDERECO(END_Codigo,END_Estado,END_Cidade,END_Bairro,END_Cep)
						VALUES (8,'Sergipe','Itabaiana','Campo Grande','49600-490')

	/* REGISTROS DE USUARIOS COM ENDERECOS DE ARACAJU */
		
INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Luis Barreto', '271117813','960.530.119-91','16/11/1958','luis@dominio.com.br', 4, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Ana Freitas', '467466269','871.523.963-29','16/01/1967','ana@dominio.com.br', 4, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Carolina Silva','468238992','120.713.611-56','17/09/1955','carolina@dominio.com.br', 4, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Fabio Figueira', '110336793', '484.779.158-49', '25/10/1994', 'fabio@dominio.com.br', 4, 'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Yara Oliveira', '110336793', '915.969.378-90', '25/03/1980', 'yara@dominio.com.br', 4, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Filipe Menezzes', '337310026', '992.971.077-96', '28/05/1963', 'filipe@dominio.com.br', 5, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Amanda Lima', '483710027', '848.024.582-40', '10/05/1972', 'amanda@dominio.com.br', 5, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Melissa Morais', '110336793', '775.442.826-19', '24/10/2001', 'melissa@dominio.com.br', 5, 'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Raul Moreira', '294854459', '951.965.614-63','26/09/1981','raul@dominio.com.br', 5, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Bianca Xavier','483710027','050.770.948-96','21/07/1989','bianca@dominio.com.br', 5, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Manuel Gonçalves','271117813','793.736.448-31','20/02/1957','manuel@dominio.com.br', 5, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Jonathan Frias','294854459','298.349.965-00','24/12/1957','jonathan@dominio.com.br', 5, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Calebe Freitas','389773645','746.141.184-53','21/11/1956','calebe@dominio.com.br', 5, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Lara Moreira','438133018','674.942.278-06','28/07/1953','lara@dominio.com.br', 5, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Heitor Martinez','483710027','392.273.035-37','23/04/1985','heitor@dominio.com.br', 5, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Abel Moraes','337310026','507.966.357-06','21/11/1959','abel@dominio.com.br', 5, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Lara Novaes','348280683','853.086.117-50','01/01/2002','lara@dominio.com.br', 5, 'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Anabela Gonçalves','467466269','849.843.177-87','25/10/1984','anabela@dominio.com.br', 5, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Analice Paris','438133018','334.376.601-10','12/06/1973','analice@dominio.com.br', 5, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Leticia Lima','165980187','257.899.069-74','09/09/1957','leticia@dominio.com.br', 5, 'Idoso')


	/* REGISTROS DE USUARIOS COM ENDERECOS DE ITABAIANA */

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Bernardo Medeiros','438133018','411.682.387-22','14/01/1970','bernardo@dominio.com.br', 6, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Yasmin Oliveira','294854459','924.663.953-71','28/06/1991','yasmin@dominio.com.br', 6, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Mateus Garcia','483710027','608.550.231-12','02/06/2000','mateus@dominio.com.br', 6,'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Clara Dias','271117813','160.566.416-27','18/04/1969','clara@dominio.com.br', 6, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Mateus Moraes','429085072','999.433.230-94','04/02/1969','mateus@dominio.com.br', 6, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Esther Silva','468238992','027.465.082-73','11/08/1961','esther@dominio.com.br', 6, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Maisa Oliveira','337310026','373.194.564-94','28/04/1974','maisa@dominio.com.br', 7, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Joao Vitor Garcia','467466269','320.207.629-94','10/01/2002','joao vitor@dominio.com.br', 7,'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Jose Ribeiro','338627017','575.977.299-60','03/12/1990','jose@dominio.com.br', 7, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Vicente Paris','165980187','022.257.766-52','13/10/1974','vicente@dominio.com.br', 7, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Melissa Xavier','468238992','860.713.851-05','05/08/1963','melissa@dominio.com.br', 7, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Melissa Lessa','110336793','492.221.976-58','21/02/1954','melissa@dominio.com.br', 7, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Helena Figueira','348280683','491.198.663-80','31/05/1979','helena@dominio.com.br', 7, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Luis Reis','429085072','400.166.362-79','28/05/1952','luis@dominio.com.br', 7, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Eduarda Araujo','110336793','080.513.137-04','10/12/1970','eduarda@dominio.com.br', 8, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Augusto Sampaio','483710027','233.036.283-86','24/06/1978','augusto@dominio.com.br', 8, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Cloe Paris','348280683','279.086.484-52','03/07/1984','cloe@dominio.com.br', 8, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Lavinia Alves','389773645','912.687.726-07','10/08/1956','lavinia@dominio.com.br', 8, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Rafaela Albuquerque','294854459','631.544.563-25','06/11/1961','rafaela@dominio.com.br', 8, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Isis Garcia','438133018','214.097.423-93','27/11/1969','isis@dominio.com.br', 8, 'Adulto')

		/* USUARIOS COM ENDERECOS VOLTADOS A ITABAIANA */

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Sofia Pereira','337310026','915.144.328-70','09/08/1962','sofia@dominio.com.br', 8, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Nicole Oliveira','337310026','249.907.002-10','07/02/1963','nicole@dominio.com.br', 8, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Valentina Pilar','348280683','138.022.246-04','02/01/1997','valentina@dominio.com.br', 8, 'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Emanuelly Dias','294854459','213.804.936-17','21/08/1994','emanuelly@dominio.com.br', 7 , 'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Alicia Vasconcelos','429085072','099.954.599-06','25/09/1997','alicia@dominio.com.br', 7, 'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Angelina Pinheiro','165980187','264.808.809-19','01/12/1971','angelina@dominio.com.br', 7, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Henrique Cavalcante','294854459','261.840.590-09','08/01/1954','henrique@dominio.com.br', 7, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Cecilia Carvalho','110336793','502.445.477-42','02/12/1984','cecilia@dominio.com.br', 7, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Anderson Moreira','389773645','068.932.793-53','08/03/1957','anderson@dominio.com.br', 7, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Diogo Alencar','468238992','732.044.065-20','08/07/1951','diogo@dominio.com.br', 7, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Ester Paiva','110336793','123.967.277-29','08/04/1990','ester@dominio.com.br', 7, 'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Murilo Maia','467466269','918.426.305-98','20/05/1976','murilo@dominio.com.br',6, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Heitor Rodrigues','165980187','624.187.888-30','09/08/1954','heitor@dominio.com.br', 6, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Rebeca Duarte','110336793','256.267.736-65','04/07/1956','rebeca@dominio.com.br', 6, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Marina Boaventura','467466269','178.451.132-39','04/04/1991','marina@dominio.com.br', 7, 'Jovem')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Nicole Martins','338627017','764.396.190-55','08/10/1959','nicole@dominio.com.br', 8, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Tomas Albuquerque','271117813','661.731.467-03','27/01/1975','tomas@dominio.com.br', 6, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Ariela Batista','337310026','399.362.841-19','07/12/1978','ariela@dominio.com.br', 6, 'Adulto')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Iris Oliveira','438133018','308.887.177-33','16/09/1952','iris@dominio.com.br', 6, 'Idoso')

INSERT INTO TB_Usuario(USU_NOME, USU_Rg, USU_Cpf, USU_DataNascimento, USU_Email, END_Codigo, USU_FaixaEtaria)
				VALUES('Fernanda Costa','389773645','348.519.612-60','05/10/1953','fernanda@dominio.com.br', 6, 'Idoso')

/* TABELA TURNO */
INSERT INTO TB_Turno VALUES (1, 'Manha')
INSERT INTO TB_Turno VALUES (2, 'Tarde')
INSERT INTO TB_Turno VALUES (3, 'Noite')

/* ADMINISTRADORES */
INSERT INTO TB_Administrador VALUES(1,1)
INSERT INTO TB_Administrador VALUES(2,24)

/* ORIENTADORES */
INSERT INTO TB_Orientador VALUES(1,'--','--',4)
INSERT INTO TB_Orientador VALUES(2,'--','--',25)
INSERT INTO TB_Orientador VALUES(3,'--','--',29)
INSERT INTO TB_Orientador VALUES(4,'--','--',28)

/* PACOTES OFERECIDOS PELA REDE DE ACADEMIAS */
INSERT INTO TB_Pacote VALUES(1,'AERÓBICO', 30.00)
INSERT INTO TB_Pacote VALUES(2,'MUSCULAÇÃO', 50.00)
INSERT INTO TB_Pacote VALUES(3,'MUAY THAI', 60.00)
INSERT INTO TB_Pacote VALUES(4,'ZUMBA', 40.00)
INSERT INTO TB_Pacote VALUES(5,'AERÓBICO + MUSCULAÇÃO', 70.00)
INSERT INTO TB_Pacote VALUES(6,'AERÓBICO + MUAY THAI', 80.00)
INSERT INTO TB_Pacote VALUES(7,'AERÓBICO + ZUMBA', 60.00)
INSERT INTO TB_Pacote VALUES(8,'MUSCULAÇÃO + MUAY THAI', 100.00)
INSERT INTO TB_Pacote VALUES(9,'MUSCULAÇÃO + ZUMBA', 80.00)
INSERT INTO TB_Pacote VALUES(10,'MUAY THAI + ZUMBA}', 90.00)
INSERT INTO TB_Pacote VALUES(11,'AERÓBICO + MUSCULAÇÃO + MUAY THAI', 120.00)
INSERT INTO TB_Pacote VALUES(12,'AERÓBICO + MUSCULAÇÃO + ZUMBA', 100.00)
INSERT INTO TB_Pacote VALUES(13,'AERÓBICO + MUAY THAI + ZUMBA', 110.00)
INSERT INTO TB_Pacote VALUES(14,'MUSCULAÇÃO + MUAY THAI + ZUMBA', 130.00)
INSERT INTO TB_Pacote VALUES(15,'AERÓBICO + MUSCULAÇÃO + MUAY THAI + ZUMBA', 160.00)


CREATE FUNCTION dbo.RertornaAlunos()
RETURNS TABLE
AS
	RETURN
	(
		SELECT * FROM TB_Usuario U
				WHERE U.USU_Codigo NOT IN (SELECT USU_Codigo FROM TB_ADMINISTRADOR)
				AND
				U.USU_Codigo NOT IN (SELECT USU_Codigo FROM TB_ORIENTADOR)
	)

/* PROCEDIMENTO PARA POVOAR ALUNOS */
CREATE PROCEDURE SP_POVOAR_TB_ALUNOS
AS
	DECLARE @CODIGO INT
	DECLARE C_CURSOR CURSOR FOR	SELECT USU_Codigo FROM dbo.RertornaAlunos()
	OPEN C_CURSOR

	FETCH C_CURSOR INTO @CODIGO

	WHILE (@@FETCH_STATUS = 0)
		BEGIN
		INSERT INTO TB_ALUNO(USU_Codigo, ALU_STATUS) VALUES (@CODIGO, 'ATIVO')
		FETCH C_CURSOR INTO @CODIGO
		END
	CLOSE C_CURSOR
	DEALLOCATE C_CURSOR

EXEC SP_POVOAR_TB_ALUNOS

/* PROCEDIMENTO QUE POVOA O FLUXO, TENDO COMO PARAMETRO UMA DATA INICIAL E UMA DATA FINAL*/
CREATE PROCEDURE SP_POVOAMENTO_TBFLUXO(@data_inicial DATETIME, @data_final datetime)
AS
BEGIN
	DECLARE C_CURSOR CURSOR FOR
					SELECT ALU_Codigo FROM TB_aluno
	
	WHILE (DATEDIFF(dd,@data_inicial,@data_final) >= 0)
		BEGIN	
		DECLARE @CODIGO INT
		OPEN C_CURSOR
		FETCH C_CURSOR INTO @CODIGO

		WHILE (@@FETCH_STATUS = 0)
			BEGIN
			DECLARE @TURNO INT, @HORA INT, @MINUTO INT, @DATA_ENTRADA DATETIME, @DATA_SAIDA DATETIME
			SET @DATA_ENTRADA = @data_inicial
			SET @HORA = (SELECT ROUND(((22 - 5 -1) * RAND() + 5), 0))
			
			IF (@HORA >= 5 AND @HORA < 12)
				BEGIN
				SET @TURNO = 1
				END
			ELSE IF (@HORA >= 12 AND @HORA < 18)
				BEGIN
				SET @TURNO = 2
				END
			ELSE 
				BEGIN
				SET @TURNO = 3
				END

			SET @MINUTO = (SELECT ROUND(((59 - 0 -1) * RAND() + 0), 0))
			SET @DATA_ENTRADA = (SELECT DATEADD(hh,@HORA,@DATA_ENTRADA))
			SET @DATA_ENTRADA = (SELECT DATEADD(mi,@MINUTO,@DATA_ENTRADA))
			SET @DATA_SAIDA = (SELECT DATEADD(hh,1,@DATA_ENTRADA))
			INSERT INTO TB_Fluxo(FLU_DataEntrada,FLU_DataSaida,TUR_Codigo,ALU_Codigo)
						VALUES(@DATA_ENTRADA,@DATA_SAIDA,@TURNO,@CODIGO)
			FETCH C_CURSOR INTO @CODIGO
			END
		CLOSE C_CURSOR
		SET @data_inicial = (SELECT DATEADD(dd,1,@data_inicial))
		END
		DEALLOCATE C_CURSOR
END


EXEC SP_POVOAMENTO_TBFLUXO '02-09-2017','05-09-2017' 

select * from TB_Fluxo
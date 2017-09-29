/*QUANTIDADE DE ALUNOS POR TURNO*/
SELECT SUM(F.Quantidade) AS ALUNOS, T.Cod_Turno AS TURNO FROM FATO_Fluxo F INNER JOIN DIM_Turno T ON t.Id_Turno = f.Cod_Turno
GROUP BY t.Cod_Turno

/*QUANTIDADE DE ALUNOS POR TURNO, SEGUIDO DE SEU NOME*/
SELECT SUM(F.Quantidade) AS ALUNOS, T.Cod_Turno AS TURNO, T.NomeTurno FROM FATO_Fluxo F INNER JOIN DIM_Turno T ON t.Id_Turno = f.Cod_Turno
GROUP BY t.Cod_Turno, T.NomeTurno

/*QUANTIDADE DE ALUNOS POR TURNO E POR EMPRESA*/
SELECT SUM(F.Quantidade) AS ALUNOS, T.Cod_Turno AS TURNO, f.Cod_Empresa FROM FATO_Fluxo F INNER JOIN DIM_Turno T ON t.Cod_Turno = f.Cod_Turno INNER JOIN DIM_Empresa E ON E.Id_Empresa = F.Cod_Empresa
GROUP BY t.Cod_Turno, F.Cod_Empresa

/*QUANTIDADE DE ALUNOS POR DIA */
SELECT SUM(F.Quantidade) AS ALUNOS, F.Cod_Data AS DIA FROM FATO_Fluxo F INNER JOIN DIM_Tempo T ON t.Id_Tempo = f.Cod_Data
WHERE T.Nivel = 'DIA'
GROUP BY F.Cod_Data

/*QUANTIDADE DE ALUNOS POR DIA, MOSTRANDO O DIA */
SELECT SUM(F.Quantidade) AS ALUNOS, t.Dia  FROM FATO_Fluxo F INNER JOIN DIM_Tempo T ON t.Id_Tempo = f.Cod_Data
WHERE T.Nivel = 'DIA'
GROUP BY t.Dia

/*QUANTIDADE DE ALUNOS POR FAIXA ETARIA*/
SELECT SUM(F.Quantidade) AS QUANTIDADE, F.Cod_FaixaEtaria, E.FaixaEtaria FROM FATO_Fluxo F INNER JOIN DIM_FaixaEtaria E ON F.Cod_FaixaEtaria = E.Id_FaixaEtaria
GROUP BY F.Cod_FaixaEtaria, E.FaixaEtaria

/*QUANTIDADE DE ALUNOS POR BAIRRO*/
SELECT SUM(F.Quantidade) AS QUANTIDADE, F.Cod_Localizacao, L.Bairro FROM FATO_Fluxo F INNER JOIN DIM_Localizacao L ON L.Id_Localizacao = F.Cod_Localizacao
GROUP BY F.Cod_Localizacao, L.Bairro

/*QUANTIDADE DE ALUNOS POR CIDADE*/
SELECT SUM(F.Quantidade) AS QUANTIDADE, L.Cidade FROM FATO_Fluxo F INNER JOIN DIM_Localizacao L ON L.Id_Localizacao = F.Cod_Localizacao
GROUP BY L.Cidade

/*QUANTIDADE DE ALUNOS POR FAIXA ETARIA EM DETERMINADO TURNO*/
SELECT SUM(F.Quantidade) AS QUANTIDADE, F.Cod_FaixaEtaria, F.Cod_Turno FROM FATO_Fluxo F INNER JOIN DIM_FaixaEtaria E ON E.Id_FaixaEtaria = F.Cod_FaixaEtaria INNER JOIN DIM_Turno T ON F.Cod_Turno = T.Id_Turno
GROUP BY F.Cod_FaixaEtaria, F.Cod_Turno

/*QUAIS OS HORARIOS QUE TEM MAIS FLUXO*/
SELECT SUM(F.Quantidade) AS QUANTIDADE, H.Hora FROM FATO_Fluxo F INNER JOIN DIM_Horario H ON F.Cod_HorarioEntrada = H.Id_Horario
WHERE H.Flag = 'ENTRADA'
GROUP BY H.Hora

/*QUAIS OS HORARIOS QUE TEM MAIS FLUXO EM ORDEM DECRESCENTE*/
SELECT SUM(F.Quantidade) AS QUANTIDADE, H.Hora FROM FATO_Fluxo F INNER JOIN DIM_Horario H ON F.Cod_HorarioEntrada = H.Id_Horario
WHERE H.Flag = 'ENTRADA'
GROUP BY H.Hora
ORDER BY QUANTIDADE DESC

/*QUAL EMPRESA TEM MAIS FLUXO NO TURNO DA NOITE*/
SELECT F.Cod_Empresa, SUM(F.Quantidade) AS QUANTIDADE FROM FATO_Fluxo F INNER JOIN DIM_Empresa E ON E.Id_Empresa = F.Cod_Empresa INNER JOIN DIM_Turno T ON T.Id_Turno = F.Cod_Turno
WHERE T.NomeTurno = 'Noite'
GROUP BY F.Cod_Empresa
ORDER BY QUANTIDADE DESC
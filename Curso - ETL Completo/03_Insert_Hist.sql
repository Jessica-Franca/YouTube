/*
  Script: 03_Insert_Hist.sql
  V�deo: [SQL] Como Inserir Dados na Tabela Hist�rico com INSERT INTO
  YouTube: https://www.youtube.com/watch?v=kKSHBAJujzU
  Tamb�m: [SQL] Como Criar uma Procedure para Tabela de Hist�rico
  YouTube: https://www.youtube.com/watch?v=W2gKG-eCh2k
  Objetivo: Procedure com CONVERT, #temp, WHILE e INSERT ... WHERE NOT EXISTS
  Banco: dbCallCenter � Schema: ClienteX
*/

USE [dbCallCenter]

GO

CREATE PROCEDURE [ClienteX].[PrcHistAtendimentoCSAT2] 
(@InitialDateCtrl	DATETIME
,@FinalDateCtrl		DATETIME)

AS

DECLARE 
 @InsertedDateCtrl	DATETIME
,@DtIni				DATE
,@DtFim				DATE

SET @InsertedDateCtrl	= GETDATE()
SET @DtIni = @InitialDateCtrl
SET @DtFim = @FinalDateCtrl

DROP TABLE IF EXISTS #Base
SELECT
	 [Data_Hora_Contato]			=  CONVERT(DATETIME,A.Data_Contato,120)
	,[Data_Contato]					=  CONVERT(DATE,A.Data_Contato,120)
	,[Canal]
	,[Produto]
	,[Respondeu_Pesquisa]			= CONVERT(INT,A.[Respondeu_Pesquisa])
	,[Nota_Satisfacao]				= CASE WHEN A.[Nota_Satisfacao] = '' THEN -1 ELSE CONVERT(INT,CONVERT(FLOAT,A.[Nota_Satisfacao])) END
	,[Motivo_Satisfacao]
	,[Tempo_Atendimento_Segundos]	= CONVERT(FLOAT,[Tempo_Atendimento_Segundos])
	,[Tempo_Fila_Segundos]			= CONVERT(FLOAT,[Tempo_Fila_Segundos])
	,[Tempo_Operacional_Segundos]	= CONVERT(FLOAT,[Tempo_Operacional_Segundos])
	,[FCR]							= CASE WHEN A.[FCR] = '' THEN -1 ELSE CONVERT(INT,CONVERT(FLOAT,A.[FCR])) END
	,[Matricula_Expert]				= CONVERT(INT,A.[Matricula_Expert]) 
INTO #Base
FROM [dbCallCenter].[ClienteX].[stgAtendimentoCSAT] AS A

DROP TABLE IF EXISTS #BaseFim
SELECT
	*
	,[InsertedDateCtrl]	= @InsertedDateCtrl
	,[InitialDateCtrl]	= @InitialDateCtrl
	,[FinalDateCtrl	]	= @FinalDateCtrl	
INTO #BaseFim
FROM #Base

WHILE (@DtIni <= @DtFim)
BEGIN
	INSERT INTO [dbCallCenter].[ClienteX].[HistAtendimentoCSAT]
		(	 [Data_Hora_Contato]
			,[Data_Contato]					
			,[Canal]
			,[Produto]
			,[Respondeu_Pesquisa]			
			,[Nota_Satisfacao]				
			,[Motivo_Satisfacao]
			,[Tempo_Atendimento_Segundos]	
			,[Tempo_Fila_Segundos]			
			,[Tempo_Operacional_Segundos]	
			,[FCR]							
			,[Matricula_Expert]
			,[InsertedDateCtrl]	
			,[InitialDateCtrl]	
			,[FinalDateCtrl]		
			)
	SELECT * FROM #BaseFim A
	WHERE NOT EXISTS (SELECT 1 FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] B
				WHERE		A.Data_Hora_Contato		 = B.Data_Hora_Contato
						AND A.[Canal]				 = B.[Canal]
						AND A.[Produto]				 = B.[Produto]
						AND A.[Motivo_Satisfacao]	 = B.[Motivo_Satisfacao]
						AND A.[Matricula_Expert]	 = B.[Matricula_Expert]
						)
	AND A.[Data_Contato] = @DtIni

	-- Limpa dados j� processados
	--DELETE FROM [dbCallCenter].[ClienteX].[stgAtendimentoCSAT]
	--WHERE CONVERT(DATE, [Data_Contato],120) = @DtIni

				
	SET @DtIni = DATEADD(DAY,1,@DtIni)
END
DROP TABLE IF EXISTS #Base, #BaseFim
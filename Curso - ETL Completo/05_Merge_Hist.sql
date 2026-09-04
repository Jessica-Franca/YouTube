/*
  Script: 05_Merge_Hist.sql
  V?deo: [SQL] Como Usar o MERGE para Alimentar Tabelas HIST?RICAS
  YouTube: https://www.youtube.com/watch?v=V8tWBXlMAtI
  Objetivo: Procedure com MERGE na HistAtendimentoCSAT
  Banco: dbCallCenter ? Schema: ClienteX
*/

USE [dbCallCenter]

GO

CREATE OR ALTER PROCEDURE [ClienteX].[PrcHistAtendimentoCSAT2] 
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
	,[FCR]							= CASE WHEN A.[FCR] = '' THEN 0 ELSE CONVERT(INT,CONVERT(FLOAT,A.[FCR])) END
	,[Matricula_Expert]				= CONVERT(INT,A.[Matricula_Expert]) 
INTO #Base
FROM [dbCallCenter].[ClienteX].[stgAtendimentoCSAT] AS A

WHILE (@DtIni <= @DtFim)
BEGIN
	DROP TABLE IF EXISTS #BaseFim
	SELECT
		*
		,[InsertedDateCtrl]	= @InsertedDateCtrl
		,[InitialDateCtrl]	= @InitialDateCtrl
		,[FinalDateCtrl]	= @FinalDateCtrl	
	INTO #BaseFim
	FROM #Base
	WHERE [Data_Contato] = @DtIni

	MERGE [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] AS DESTINO -- TABELA QUE RECEBE OS DADOS
	USING #BaseFim AS ORIGEM -- TABELA QUE TEM OS DADOS GERADOS
	ON (
			DESTINO.Data_Hora_Contato		= ORIGEM.Data_Hora_Contato
		AND DESTINO.[Canal]					= ORIGEM.[Canal]
		AND DESTINO.[Produto]				= ORIGEM.[Produto]
		AND DESTINO.[Motivo_Satisfacao]		= ORIGEM.[Motivo_Satisfacao]
		AND DESTINO.[Matricula_Expert]		= ORIGEM.[Matricula_Expert]
		) -- VALIDA��O DOS DADOS ENTRE AS TABELAS ORIGEM E DESTINO

	WHEN NOT MATCHED THEN
	
	INSERT
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
		VALUES
		(	 ORIGEM.[Data_Hora_Contato]
			,ORIGEM.[Data_Contato]					
			,ORIGEM.[Canal]
			,ORIGEM.[Produto]
			,ORIGEM.[Respondeu_Pesquisa]			
			,ORIGEM.[Nota_Satisfacao]				
			,ORIGEM.[Motivo_Satisfacao]
			,ORIGEM.[Tempo_Atendimento_Segundos]	
			,ORIGEM.[Tempo_Fila_Segundos]			
			,ORIGEM.[Tempo_Operacional_Segundos]	
			,ORIGEM.[FCR]							
			,ORIGEM.[Matricula_Expert]
			,ORIGEM.[InsertedDateCtrl]	
			,ORIGEM.[InitialDateCtrl]	
			,ORIGEM.[FinalDateCtrl]		
			);

	---- Limpa dados j� processados
	--DELETE FROM [dbCallCenter].[ClienteX].[stgAtendimentoCSAT]
	--WHERE CONVERT(DATE, [Data_Contato],120) = @DtIni

				
	SET @DtIni = DATEADD(DAY,1,@DtIni)
END
DROP TABLE IF EXISTS #Base, #BaseFim
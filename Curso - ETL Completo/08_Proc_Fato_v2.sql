/*
  Script: 08_Proc_Fato_v2.sql
  V?deo: [SQL] Como Criar e Alimentar uma Tabela FATO com MERGE
  YouTube: https://www.youtube.com/watch?v=RzKSyF4YOII
  Objetivo: Variante da procedure de carga da Fato (vers?o 2)
  Banco: dbCallCenter ? Schema: ClienteX
*/

USE [dbCallCenter]
GO
CREATE or alter PROCEDURE [ClienteX].[PrcFatoAtendimentoCSAT] 
(@InitialDateCtrl	DATETIME
,@FinalDateCtrl		DATETIME)

AS

DECLARE 
	 @InsertedDateCtrl	DATETIME
	,@DtIni DATE
	,@DtFim DATE

SET @InsertedDateCtrl	= GETDATE()
SET @DtIni = (
			SELECT MIN(A.[Data_Contato]) 
			FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] AS A WITH(NOLOCK) 
			WHERE A.[FinalDateCtrl] = @FinalDateCtrl)
SET @DtFim = (SELECT MAX(A.[Data_Contato]) FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] AS A WITH(NOLOCK) WHERE A.[FinalDateCtrl] = @FinalDateCtrl)


WHILE @DtIni <= @DtFim
BEGIN
	DROP TABLE IF EXISTS #BASE
	SELECT 
		 [Data_Contato]					= A.[Data_Contato]
		,[Matricula_Expert]				= ISNULL(A.[Matricula_Expert],-1)
		,[IdCanal]						= ISNULL(B.[ID],-1)
		,[IdProduto]					= ISNULL(C.[ID],-1)
		,[IdMotivoSatisfacao]			= ISNULL(D.[ID],-1)
		,[Respondeu_Pesquisa]			= ISNULL(A.[Respondeu_Pesquisa],-1)
		,[Nota_Satisfacao]				= ISNULL(A.[Nota_Satisfacao],-1)
		,[FCR]							= ISNULL(A.[FCR],-1)
		,[TempAtendSeg]					= SUM(A.[Tempo_Atendimento_Segundos])
		,[TempFilaSeg]					= SUM(A.[Tempo_Fila_Segundos])
		,[TempOperSeg]					= SUM(A.[Tempo_Operacional_Segundos])
		,[QtdAtendimentos]				= COUNT(A.[Data_Contato]) 
	INTO #BASE
	FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] AS A WITH(NOLOCK)
	LEFT JOIN [dbCallCenter].[ClienteX].[DimCanal] AS B WITH(NOLOCK) ON A.Canal = B.Canal
	LEFT JOIN [dbCallCenter].[ClienteX].[DimProduto] AS C WITH(NOLOCK) ON A.Produto = C.Produto
	LEFT JOIN [dbCallCenter].[ClienteX].[DimMotivoSatisfacao] AS D WITH(NOLOCK) ON A.Motivo_Satisfacao = D.Motivo_Satisfacao
	WHERE A.Data_Contato = @DtIni 
	AND A.[FinalDateCtrl] = @FinalDateCtrl
	GROUP BY 
		 A.[Data_Contato]
		,ISNULL(A.[Matricula_Expert],-1)
		,ISNULL(B.[ID],-1)
		,ISNULL(C.[ID],-1)
		,ISNULL(D.[ID],-1)
		,ISNULL(A.[Respondeu_Pesquisa],-1)
		,ISNULL(A.[Nota_Satisfacao],-1)
		,ISNULL(A.[FCR],-1)

	DROP TABLE IF EXISTS #BaseFim
	SELECT
		*
		,[ChecksumId]		= CHECKSUM(*) 
		,[InsertedDateCtrl]	= @InsertedDateCtrl
		,[InitialDateCtrl]	= @InitialDateCtrl
		,[FinalDateCtrl]	= @FinalDateCtrl	
	INTO #BaseFim
	FROM #BASE

	MERGE [dbCallCenter].[ClienteX].[FatoAtendimentoCSAT] AS DESTINO -- TABELA QUE RECEBE OS DADOS
	USING #BaseFim AS ORIGEM -- TABELA QUE TEM OS DADOS GERADOS
	ON (
			DESTINO.[Data_Contato]			= ORIGEM.[Data_Contato]
		AND DESTINO.[Matricula_Expert]		= ORIGEM.[Matricula_Expert]
		AND DESTINO.[IdCanal]				= ORIGEM.[IdCanal]			
		AND DESTINO.[IdProduto]				= ORIGEM.[IdProduto]			
		AND DESTINO.[IdMotivoSatisfacao]	= ORIGEM.[IdMotivoSatisfacao]
		AND DESTINO.[Nota_Satisfacao]		= ORIGEM.[Nota_Satisfacao]
		AND DESTINO.[FCR]					= ORIGEM.[FCR]
		) -- VALIDA��O DOS DADOS ENTRE AS TABELAS ORIGEM E DESTINO

	WHEN MATCHED AND ORIGEM.[ChecksumId] != DESTINO.[ChecksumId] THEN
	UPDATE SET
			 
			 DESTINO.[TempAtendSeg]					= ORIGEM.[TempAtendSeg]
			,DESTINO.[TempFilaSeg]					= ORIGEM.[TempFilaSeg]
			,DESTINO.[TempOperSeg]					= ORIGEM.[TempOperSeg]
			,DESTINO.[QtdAtendimentos]				= ORIGEM.[QtdAtendimentos]	
			,DESTINO.[Respondeu_Pesquisa]			= ORIGEM.[Respondeu_Pesquisa]	
			,DESTINO.[ChecksumId]					= ORIGEM.[ChecksumId]					
			,DESTINO.[InsertedDateCtrl]				= ORIGEM.[InsertedDateCtrl]				
			,DESTINO.[InitialDateCtrl]				= ORIGEM.[InitialDateCtrl]				
			,DESTINO.[FinalDateCtrl]				= ORIGEM.[FinalDateCtrl]				 
														 
	WHEN NOT MATCHED THEN
	
	INSERT
		(	 [Data_Contato]					
			,[Matricula_Expert]				
			,[IdCanal]						
			,[IdProduto]					
			,[IdMotivoSatisfacao]			
			,[Respondeu_Pesquisa]			
			,[Nota_Satisfacao]				
			,[FCR]							
			,[TempAtendSeg]
			,[TempFilaSeg]
			,[TempOperSeg]
			,[QtdAtendimentos]	
			,[ChecksumId]
			,[InsertedDateCtrl]	
			,[InitialDateCtrl]	
			,[FinalDateCtrl]		
			)
		VALUES
		(	 ORIGEM.[Data_Contato]					
			,ORIGEM.[Matricula_Expert]					
			,ORIGEM.[IdCanal]
			,ORIGEM.[IdProduto]					
			,ORIGEM.[IdMotivoSatisfacao]
			,ORIGEM.[Respondeu_Pesquisa]
			,ORIGEM.[Nota_Satisfacao]
			,ORIGEM.[FCR]
			,ORIGEM.[TempAtendSeg]
			,ORIGEM.[TempFilaSeg]
			,ORIGEM.[TempOperSeg]	
			,ORIGEM.[QtdAtendimentos]
			,ORIGEM.[ChecksumId]
			,ORIGEM.[InsertedDateCtrl]
			,ORIGEM.[InitialDateCtrl]
			,ORIGEM.[FinalDateCtrl]
			);
	SET @DtIni = DATEADD(DAY,1,@DtIni)
END 
DROP TABLE IF EXISTS #BASE, #BaseFim
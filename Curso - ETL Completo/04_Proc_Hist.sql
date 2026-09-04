/*
  Script: 04_Proc_Hist.sql
  V?deo: [SQL] Como Criar uma Procedure para Tabela de Hist?rico
  YouTube: https://www.youtube.com/watch?v=W2gKG-eCh2k
  Objetivo: Procedure de carga hist?rica (loop por data + MERGE)
  Observa??o: a aula de INSERT/NOT EXISTS usa 03_Insert_Hist.sql
  Banco: dbCallCenter ? Schema: ClienteX
*/

USE [dbCallCenter]
GO

CREATE OR ALTER PROCEDURE [ClienteX].[PrcHistAtendimentoCSAT](
				 @InitialDateCtrl	AS DATETIME
				,@FinalDateCtrl		AS DATETIME
)AS

BEGIN
	--DECLARE  @InitialDateCtrl	AS DATETIME = '20/09/2025'--CONVERT(DATETIME,'2025-09-20 00:00:00',120)
	--		,@FinalDateCtrl		AS DATETIME = '25/09/2025'--CONVERT(DATETIME,'2025-09-30 23:59:59',120)

	DECLARE  @DataIni           AS DATE
			,@DataFim           AS DATE
			,@InsertedDateCtrl	AS DATETIME

	SET @DataIni            = @InitialDateCtrl
	SET @DataFim            = @FinalDateCtrl
	SET @InsertedDateCtrl	= GETDATE()

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DROP TABLE IF EXISTS #BASE
	SELECT 
		 [Data_Hora_Contato]			= CONVERT(DATETIME, [Data_Contato],120)
		,[Data_Contato]					= CONVERT(DATE, [Data_Contato],120)
		,[Canal]						= [Canal]
		,[Produto]						= [Produto]
		,[Respondeu_Pesquisa]			= CONVERT(INT,[Respondeu_Pesquisa])
		,[Nota_Satisfacao]				= CONVERT(INT,CONVERT(FLOAT, [Nota_Satisfacao]))
		,[Motivo_Satisfacao]			= [Motivo_Satisfacao]
		,[Tempo_Atendimento_Segundos]	= CONVERT(INT,CONVERT(FLOAT, [Tempo_Atendimento_Segundos]))
		,[Tempo_Fila_Segundos]			= CONVERT(INT,CONVERT(FLOAT, [Tempo_Fila_Segundos]))
		,[Tempo_Operacional_Segundos]	= CONVERT(INT,CONVERT(FLOAT, [Tempo_Operacional_Segundos]))
		,[FCR]							= CONVERT(INT,CONVERT(FLOAT, [FCR]))
		,[Matricula_Expert]				= CONVERT(INT,[Matricula_Expert])
		,[data_insercao]				= CONVERT(DATE, [data_insercao], 126)
		,[data_insercao_Hora]			= CONVERT(DATETIME, [data_insercao], 126)
	INTO #BASE
	FROM [dbCallCenter].[ClienteX].[stgAtendimentoCSAT] WITH(NOLOCK)

	-- ============== LOOP M�S A M�S ==============
	WHILE (@DataIni <= @DataFim)
	BEGIN
		
				DROP TABLE IF EXISTS #BASE_FIM
				SELECT 
				 * 
				,InsertedDateCtrl	= @InsertedDateCtrl
				,InitialDateCtrl	= @InitialDateCtrl	
				,FinalDateCtrl		= @FinalDateCtrl
				INTO #BASE_FIM
				FROM #BASE A 
				WHERE A.Data_Contato = @DataIni

				MERGE [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] AS DESTINO -- TABELA QUE VAI RECEBER OS DADOS
				USING #BASE_FIM AS ORIGEM -- TABELA QUE TEM OS DADOS GERADOS
		
						ON (	
								DESTINO.[Data_Hora_Contato]	= ORIGEM.[Data_Hora_Contato]
							AND DESTINO.[Matricula_Expert]	= ORIGEM.[Matricula_Expert]
							AND DESTINO.[Canal]				= ORIGEM.[Canal]	
							AND DESTINO.[Produto]			= ORIGEM.[Produto]
							AND DESTINO.[Motivo_Satisfacao]	= ORIGEM.[Motivo_Satisfacao]
							) -- COMPARA��O DOS DADOS PARA VER SE VAI FAZER UPDATE OU INSERT
			
						WHEN NOT MATCHED THEN -- SE N�O TIVER DADOS IGUAIS

											INSERT (
													 [Data_Hora_Contato]
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
													) -- COLUNAS DA TABELA DESTINO 

											VALUES (
													 ORIGEM.[Data_Hora_Contato]
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
													); -- COLUNA DA TABELA ORIGEM
				
				PRINT('Data: '+convert(varchar,@DataIni)+' Processada')
				
				-- ============== Apaga dados j� processados ==============
				
				--DELETE FROM [dbCallCenter].[ClienteX].[stgAtendimentoCSAT]
				--SELECT * FROM [dbCallCenter].[ClienteX].[stgAtendimentoCSAT]
				--WHERE CONVERT(DATE, [Data_Contato],120) = @DataIni
				SET 	@DataIni = DATEADD(DAY,1,@DataIni)

	END
	DROP TABLE IF EXISTS #BASE,#BASE_FIM
END
--TRUNCATE TABLE [dbCallCenter].[ClienteX].[HistAtendimentoCSAT]
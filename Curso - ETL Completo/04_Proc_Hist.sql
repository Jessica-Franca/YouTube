/*
  Script: 04_Proc_Hist.sql
  V?deo: [SQL] Como Criar uma Procedure para Tabela de Hist?rico
  YouTube: https://www.youtube.com/watch?v=W2gKG-eCh2k
  Objetivo: Encapsular a carga do Hist?rico em procedure (WHILE por data + INSERT + NOT EXISTS)
  Como estudar: compare com 03_Insert_Hist.sql ? mesma l?gica, agora com loop e procedure
  Banco: dbCallCenter ? Schema: ClienteX
*/

USE [dbCallCenter]
GO

CREATE OR ALTER PROCEDURE [ClienteX].[PrcHistAtendimentoCSAT2]
(
	 @InitialDateCtrl	DATETIME
	,@FinalDateCtrl		DATETIME
)
AS
BEGIN
	DECLARE
		 @InsertedDateCtrl	DATETIME
		,@DtIni				DATE
		,@DtFim				DATE

	-- DATETIME ? DATE: a hora ? descartada (ex.: 22/09/2025 00:00 ? 2025-09-22)
	SET @InsertedDateCtrl = GETDATE()
	SET @DtIni = @InitialDateCtrl
	SET @DtFim = @FinalDateCtrl

	-- Stage ? tipagem ? #Base (sem filtro: Stage traz tudo)
	DROP TABLE IF EXISTS #Base
	SELECT
		 [Data_Hora_Contato]			= CONVERT(DATETIME, A.Data_Contato, 120)
		,[Data_Contato]					= CONVERT(DATE, A.Data_Contato, 120)
		,[Canal]
		,[Produto]
		,[Respondeu_Pesquisa]			= CONVERT(INT, A.[Respondeu_Pesquisa])
		,[Nota_Satisfacao]				= CASE WHEN A.[Nota_Satisfacao] = '' THEN -1 ELSE CONVERT(INT, CONVERT(FLOAT, A.[Nota_Satisfacao])) END
		,[Motivo_Satisfacao]
		,[Tempo_Atendimento_Segundos]	= CONVERT(FLOAT, [Tempo_Atendimento_Segundos])
		,[Tempo_Fila_Segundos]			= CONVERT(FLOAT, [Tempo_Fila_Segundos])
		,[Tempo_Operacional_Segundos]	= CONVERT(FLOAT, [Tempo_Operacional_Segundos])
		,[FCR]							= CASE WHEN A.[FCR] = '' THEN -1 ELSE CONVERT(INT, CONVERT(FLOAT, A.[FCR])) END
		,[Matricula_Expert]				= CONVERT(INT, A.[Matricula_Expert])
	INTO #Base
	FROM [dbCallCenter].[ClienteX].[stgAtendimentoCSAT] AS A

	DROP TABLE IF EXISTS #BaseFim
	SELECT
		 *
		,[InsertedDateCtrl] = @InsertedDateCtrl
		,[InitialDateCtrl]  = @InitialDateCtrl
		,[FinalDateCtrl]    = @FinalDateCtrl
	INTO #BaseFim
	FROM #Base

	-- Loop dia a dia: processa enquanto @DtIni <= @DtFim
	WHILE (@DtIni <= @DtFim)
	BEGIN
		-- PRINT @DtIni  -- ?til no estudo; no dia a dia pode remover

		INSERT INTO [dbCallCenter].[ClienteX].[HistAtendimentoCSAT]
		(
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
		)
		SELECT *
		FROM #BaseFim AS A
		WHERE NOT EXISTS (
			SELECT 1
			FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] AS B
			WHERE A.Data_Hora_Contato    = B.Data_Hora_Contato
			  AND A.[Canal]              = B.[Canal]
			  AND A.[Produto]            = B.[Produto]
			  AND A.[Motivo_Satisfacao] = B.[Motivo_Satisfacao]
			  AND A.[Matricula_Expert]   = B.[Matricula_Expert]
		)
		AND A.[Data_Contato] = @DtIni

		-- Limpa dados j? processados na Stage (descomente em produ??o)
		--DELETE FROM [dbCallCenter].[ClienteX].[stgAtendimentoCSAT]
		--WHERE CONVERT(DATE, [Data_Contato], 120) = @DtIni

		-- Obrigat?rio: sen?o vira loop infinito
		SET @DtIni = DATEADD(DAY, 1, @DtIni)
	END

	DROP TABLE IF EXISTS #Base, #BaseFim
END
GO

-- Exemplo de execu??o (ajuste as datas ao que existe na Stage):
-- EXEC [ClienteX].[PrcHistAtendimentoCSAT2]
--	 @InitialDateCtrl = '24/09/2025 00:00:00'
--	,@FinalDateCtrl   = '25/09/2025 23:59:59'

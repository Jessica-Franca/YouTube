/*
  Script: 03_Insert_HistStudio.sql
  Mini curso: Base Studio (salão de beleza) — CSV → Stage → Histórico — aula 3/3
  Vídeo: Como criar o Histórico no SQL Server e inserir dados da Stage
  YouTube: https://www.youtube.com/watch?v=oTvTQ4SgFqA
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Tipar Stage.StgStudio (CONVERT) em #temp e gravar em Historico.HistStudio
  Como estudar: execute por partes no SSMS (igual ao vídeo)
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: 01_BULK_INSERT_CSV_Stage.sql + 02_Create_HistStudio.sql
*/

USE [dbTestes]
GO

-- Schema Stage (precisa existir; a aula 1 já cria e alimenta Stage.StgStudio)
IF SCHEMA_ID('Stage') IS NULL
	EXEC('CREATE SCHEMA Stage');
GO

-- 1) Stage (texto) → tipagem com CONVERT → #StgStudio
DROP TABLE IF EXISTS #StgStudio
SELECT
	 [id_atendimento]		= CONVERT(INT, A.[id_atendimento])
	,[data_atendimento]		= CONVERT(DATE, A.[data_atendimento])
	,[hora_atendimento]		= CAST(A.[hora_atendimento] + ':00' AS TIME)
	,[cliente]
	,[telefone]
	,[cidade]
	,[uf]
	,[profissional]
	,[servico]
	,[categoria]
	,[valor]				= TRY_CONVERT(decimal(10,1), A.[valor])
	,[forma_pagamento]
	,[status]
	,[canal_agendamento]
	,[NomeArquivo]
INTO #StgStudio
FROM [dbTestes].[Stage].[StgStudio] AS A

-- 2) #StgStudio + colunas de controle → #Fim
DROP TABLE IF EXISTS #Fim
SELECT
	 *
	,[InsertedDateCtrl] = GETDATE() -- @InsertedDateCtrl
	,[InitialDateCtrl]	= GETDATE() -- @InitialDateCtrl
	,[FinalDateCtrl]	= GETDATE() -- @FinalDateCtrl
	,[ProcessKeyCtrl]	= 1         -- @ProcessKeyCtrl
INTO #Fim
FROM #StgStudio AS t

-- Conferência
SELECT TOP 5 * FROM #Fim

-- 3) INSERT no Histórico
INSERT INTO [Historico].[HistStudio]
SELECT * FROM #Fim

-- Prova: quantas linhas entraram?
SELECT COUNT(*) AS [Total Linhas Stage] FROM [Stage].[StgStudio]
SELECT COUNT(*) AS [Total Linhas Hist]  FROM [Historico].[HistStudio]
SELECT TOP 5 * FROM [Historico].[HistStudio]

GO

/*
  Extra de estudo: tamanho de VARCHAR (MAX(LEN) + 10)
  Use na Stage para calibrar o CREATE da Hist (aula 2).

SELECT
	 10 + MAX(LEN([cliente]))            AS [cliente]
	,10 + MAX(LEN([telefone]))           AS [telefone]
	,10 + MAX(LEN([cidade]))             AS [cidade]
	,10 + MAX(LEN([uf]))                 AS [uf]
	,10 + MAX(LEN([profissional]))       AS [profissional]
	,10 + MAX(LEN([servico]))            AS [servico]
	,10 + MAX(LEN([categoria]))          AS [categoria]
	,10 + MAX(LEN([forma_pagamento]))    AS [forma_pagamento]
	,10 + MAX(LEN([status]))             AS [status]
	,10 + MAX(LEN([canal_agendamento]))  AS [canal_agendamento]
	,10 + MAX(LEN([NomeArquivo]))        AS [NomeArquivo]
FROM [dbTestes].[Stage].[StgStudio] AS A
*/

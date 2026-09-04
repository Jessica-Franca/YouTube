/*
  Script: 03_Insert_Hist.sql
  Vídeo: [SQL] Como Inserir Dados na Tabela Histórico com INSERT INTO
  YouTube: https://www.youtube.com/watch?v=kKSHBAJujzU
  Objetivo: CONVERT + #temp + INSERT INTO no Histórico com WHERE NOT EXISTS
  Como estudar: execute por partes no SSMS (igual ao vídeo)
  Banco: dbCallCenter · Schema: ClienteX
*/

DECLARE
	 @InsertedDateCtrl	DATETIME
	,@InitialDateCtrl	DATETIME
	,@FinalDateCtrl		DATETIME

SET @InsertedDateCtrl	= GETDATE()
SET @InitialDateCtrl	= '22/09/2025 00:00:00'
SET @FinalDateCtrl		= '30/09/2025 23:59:59'

-- 1) Stage ? tipagem ? #Base
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

-- 2) #Base + colunas de controle ? #BaseFim
DROP TABLE IF EXISTS #BaseFim
SELECT
	 *
	,[InsertedDateCtrl]	= @InsertedDateCtrl
	,[InitialDateCtrl]	= @InitialDateCtrl
	,[FinalDateCtrl]	= @FinalDateCtrl
INTO #BaseFim
FROM #Base

-- Conferência (como no vídeo)
SELECT * FROM #BaseFim

-- 3) Exemplo intermediário do vídeo: INSERT sem colunas de controle (a partir de #Base)
-- INSERT INTO [dbCallCenter].[ClienteX].[HistAtendimentoCSAT]
-- (
-- 	 [Data_Hora_Contato]
-- 	,[Data_Contato]
-- 	,[Canal]
-- 	,[Produto]
-- 	,[Respondeu_Pesquisa]
-- 	,[Nota_Satisfacao]
-- 	,[Motivo_Satisfacao]
-- 	,[Tempo_Atendimento_Segundos]
-- 	,[Tempo_Fila_Segundos]
-- 	,[Tempo_Operacional_Segundos]
-- 	,[FCR]
-- 	,[Matricula_Expert]
-- )
-- SELECT * FROM #Base

-- 4) Versão final: INSERT com controle + WHERE NOT EXISTS (evita duplicidade)
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
SELECT * FROM #BaseFim AS A
WHERE NOT EXISTS (
	SELECT 1
	FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] AS B
	WHERE A.Data_Hora_Contato    = B.Data_Hora_Contato
	  AND A.[Canal]              = B.[Canal]
	  AND A.[Produto]            = B.[Produto]
	  AND A.[Motivo_Satisfacao] = B.[Motivo_Satisfacao]
	  AND A.[Matricula_Expert]   = B.[Matricula_Expert]
)

-- SELECT * FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT]

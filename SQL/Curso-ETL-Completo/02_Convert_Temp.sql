/*
  Script: 02_Convert_Temp.sql
  Vídeo: [SQL] Como Fazer Conversão de Tipos (CONVERT) e Criar Tabela Temporária
  YouTube: https://www.youtube.com/watch?v=N82GIjWbKy0
  Objetivo: Converter tipos da Stage (VARCHAR) e gravar em #temp (#Base)
  Como estudar: abra no SSMS, execute e compare com o vídeo
  Pré-requisito: 00_Script_Inicial.sql + dados na Stage
  Banco: dbCallCenter · Schema: ClienteX
*/

USE [dbCallCenter]
GO

-- Stage (texto) → tipagem com CONVERT → tabela temporária #Base
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

-- Conferência
SELECT TOP 20 * FROM #Base

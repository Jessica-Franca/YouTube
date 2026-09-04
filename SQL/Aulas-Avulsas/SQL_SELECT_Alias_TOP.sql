/*
  Script: SQL_SELECT_Alias_TOP.sql
  Vídeo: [SQL] Como usar SELECT, Alias e TOP 10 no SQL Server (com exemplos práticos)
  YouTube: https://www.youtube.com/watch?v=iY63k8jpD_k
  Objetivo: Selecionar colunas, limitar com TOP, renomear com Alias e explorar com SELECT *
  Como estudar: abra no SSMS, execute por partes e compare com o vídeo
  Banco: dbVideoGameSales
*/

-- Colunas específicas (sem limitar linhas)
SELECT
	 [NomeJogo]
	,[NomeConsoleLancamento]
	,[VendasGlobais]
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales]


-- TOP 10: limite seguro para explorar a base
SELECT TOP 10
	 [NomeJogo]
	,[NomeConsoleLancamento]
	,[VendasGlobais]
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales]


-- Alias (AS) nas colunas
SELECT TOP 10
	 [NomeJogo]					AS [Jogo]
	,[NomeConsoleLancamento]	AS [Console]
	,[VendasGlobais]			AS [Vendas]
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales]


-- Alias na tabela + colunas
SELECT TOP 10
	 A.[NomeJogo]				AS [Jogo]
	,A.[NomeConsoleLancamento]	AS [Console]
	,A.[VendasGlobais]			AS [Vendas]
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales] AS A


-- SELECT * com TOP (explorar todas as colunas com segurança)
SELECT TOP 10
	 *
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales]


-- SELECT * usando o alias da tabela
SELECT TOP 10
	 A.*
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales] AS A

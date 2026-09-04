/*
  Script: SQL_WHERE.sql
  Vídeo: [SQL] Como Usar WHERE no SQL Server para Filtrar Dados e Tabelas (Guia para Iniciantes)
  YouTube: https://www.youtube.com/watch?v=2iOMpEOHQiY
  Objetivo: Filtrar com =, !=/<>, >, IN, BETWEEN, IS NULL e IS NOT NULL
  Como estudar: abra no SSMS, execute por partes e compare com o vídeo
  Banco: dbVideoGameSales
*/

-- Igualdade (=) — por volta de 01:06
SELECT 
	 NomeJogo
	,NomeConsoleLancamento  
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales]  
WHERE NomeConsoleLancamento = 'PS3'
ORDER BY NomeConsoleLancamento

-- Diferente (!= ou <>) — por volta de 01:48
SELECT 
	 NomeJogo
	,NomeConsoleLancamento  
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales]  
WHERE NomeConsoleLancamento != 'PC' 

SELECT 
	 NomeJogo
	,NomeConsoleLancamento  
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales]  
WHERE NomeConsoleLancamento <> 'PC' 

-- Maior e menor (>, <, >=, <=) — por volta de 03:02
SELECT 
	 NomeJogo
	,NomeConsoleLancamento  
	,NotaCritica
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales]  
WHERE NotaCritica > 9  -- [>= 9] ou [<= 9] ou  [< 9] ou [> 9]
ORDER BY NotaCritica DESC

-- IN (dentro de uma lista) — por volta de 03:56
SELECT
	 NomeJogo
	,NomeConsoleLancamento
	,NomeGenero
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales] 
WHERE NomeGenero IN ('Action', 'Sports') 
ORDER BY NomeGenero

-- BETWEEN (entre dois valores) — por volta de 04:50
SELECT
	 DataLancamento
	,NomeJogo
	,NomeConsoleLancamento
	,NomeGenero
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales] 
WHERE DataLancamento BETWEEN '2002-01-01' AND '2002-12-31' 
ORDER BY DataLancamento

-- IS NULL (valores ausentes) — por volta de 05:28
SELECT
	 NomeJogo
	,NomeConsoleLancamento
	,NomeGenero
	,NotaCritica
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales] 
WHERE NotaCritica IS NULL  
ORDER BY NotaCritica

-- IS NOT NULL (valores existentes)
SELECT
	 NomeJogo
	,NomeConsoleLancamento
	,NomeGenero
	,NotaCritica
FROM [dbVideoGameSales].[Historico].[HistVideoGameSales] 
WHERE NotaCritica IS NOT NULL  
ORDER BY NotaCritica

/*
  Script: 01_BULK_INSERT_CSV_Stage.sql
  Mini curso: Estúdio (CSV → Stage → Histórico) — aula 1/3
  Vídeo: Como importar CSV no SQL Server com BULK INSERT (e criar a Stage)
  YouTube: https://www.youtube.com/watch?v=5ISu6r8Cad0
  Objetivo: CSV -> tabela temporaria -> BULK INSERT -> Stage.StgStudio (SELECT INTO) e validar as linhas
  Como estudar:
    1. Baixe o CSV: BasesFakes/historico_studio.csv
    2. Salve no seu PC (exemplo: C:\Dados\historico_studio.csv)
    3. Ajuste o caminho do BULK INSERT abaixo
    4. Execute por partes no SSMS e compare com o video
  Banco: dbTestes (ou outro banco de teste)
  CSV: BasesFakes/historico_studio.csv
  Proximo: 02_Create_HistStudio.sql
*/

USE [dbTestes];
GO

-- Schema Stage (precisa existir para o SELECT INTO)
IF SCHEMA_ID('Stage') IS NULL
	EXEC('CREATE SCHEMA Stage');
GO

-- Tabela temporaria = mesmas colunas do CSV (ainda sem Stage fixa)
DROP TABLE IF EXISTS #TmpStgStudio;
CREATE TABLE #TmpStgStudio
(
	 id_atendimento			VARCHAR(MAX)
	,data_atendimento		VARCHAR(MAX)
	,hora_atendimento		VARCHAR(MAX)
	,cliente				VARCHAR(MAX)
	,telefone				VARCHAR(MAX)
	,cidade					VARCHAR(MAX)
	,uf						VARCHAR(MAX)
	,profissional			VARCHAR(MAX)
	,servico				VARCHAR(MAX)
	,categoria				VARCHAR(MAX)
	,valor					VARCHAR(MAX)
	,forma_pagamento		VARCHAR(MAX)
	,status					VARCHAR(MAX)
	,canal_agendamento		VARCHAR(MAX)
);
SELECT 'Tabela #TmpStgStudio Criada - '+ FORMAT(GETDATE(), 'dd/MM/yyyy HH:mm:ss') AS Mensagem;


-- BULK INSERT: le o arquivo do disco e "cola" na #Tmp de uma vez
-- Ajuste o FROM para o caminho onde VOCE salvou o CSV
BULK INSERT #TmpStgStudio
FROM 'C:\Dados\historico_studio.csv'
WITH
(
    FIRSTROW = 2,              -- pula linha 1 (cabecalho)
    FIELDTERMINATOR = ';',     -- separador entre colunas
    ROWTERMINATOR = '0x0a',    -- fim de cada linha
    CODEPAGE = '65001',        -- UTF-8 (acentos)
    TABLOCK                    -- performance em carga grande
);
SELECT 'Tabela #TmpStgStudio Alimentada com BULK INSERT - '+ FORMAT(GETDATE(), 'dd/MM/yyyy HH:mm:ss') AS Mensagem;

-- PASSO 3: INSERT na Stage com metadados de controle
DROP TABLE IF EXISTS Stage.StgStudio;
SELECT
	 *
	,[NomeArquivo]		= 'historico_studio.csv' -- @NomeArquivo
	,[InsertedDateCtrl] = GETDATE() -- @InsertedDateCtrl
	,[InitialDateCtrl]	= GETDATE() -- @InitialDateCtrl
	,[FinalDateCtrl]	= GETDATE() -- @FinalDateCtrl
	,[ProcessKeyCtrl]	= 1  -- @ProcessKeyCtrl
INTO Stage.StgStudio
FROM #TmpStgStudio AS t;
SELECT 'Tabela Stage.StgStudio criada e alimentada com INTO - '+ FORMAT(GETDATE(), 'dd/MM/yyyy HH:mm:ss') AS Mensagem;
--DROP TABLE #TmpStgStudio;


-- Prova: quantas linhas entraram?
SELECT COUNT(*) AS [Total Linhas Temp] FROM #TmpStgStudio;
SELECT TOP 5 * FROM #TmpStgStudio;

SELECT COUNT(*) AS [Total Linhas Stage] FROM Stage.StgStudio;
SELECT TOP 5 * FROM Stage.StgStudio;

--TRUNCATE TABLE Stage.StgStudio

GO

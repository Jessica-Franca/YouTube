/*
  Script: 08_Alimentar_DimContato.sql
  Mini curso: Base Studio (salão de beleza) — aula 4 (dimensão de contato)
  Vídeo: Dimensão de Contato + atualização da fato | Base Studio
  YouTube: [https://www.youtube.com/watch?v=jMhzQbc7vls]
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Consolidar contatos por cliente e telefone, identificar o contato mais recente e atualizar/inserir a DimContato
  Como estudar: execute por partes no SSMS (igual ao vídeo)
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: 07_Create_DimContato.sql
  Próximo: 09_Select_Fato.sql
*/


DECLARE @DtFim DATE = (
	SELECT DATEADD(DAY, 1, MAX(FinalDateCtrl))
	FROM [dbTestes].[Historico].[HistStudio] WITH(NOLOCK)
);

DECLARE @DtIni DATE = DATEADD(DAY, -2, @DtFim);


-- 1) Consolida os contatos por cliente e telefone
DROP TABLE IF EXISTS #contatos01;

SELECT
	 B.idCliente
	,A.telefone
	,[de] = MIN(A.data_atendimento)
	,[ate] = MAX(A.data_atendimento)
INTO #contatos01
FROM [dbTestes].[Historico].[HistStudio] A
LEFT JOIN [dbTestes].[DataMart].[DimCliente] B WITH(NOLOCK)
	ON A.cliente = B.cliente
WHERE A.cliente IS NOT NULL
  AND A.telefone IS NOT NULL
  -- AND A.FinalDateCtrl >= @DtIni
  -- AND A.FinalDateCtrl < @DtFim
GROUP BY
	 B.idCliente
	,A.telefone;


-- Confer�ncia
SELECT *
FROM #contatos01
ORDER BY
	 de DESC
	,telefone;


-- 2) Identifica o contato mais recente de cada cliente
DROP TABLE IF EXISTS #contatos02;

SELECT
	 idCliente
	,telefone
	,de
	,ate
	,[ContatoMaisRecente] =
		CASE
			WHEN ROW_NUMBER() OVER (
				PARTITION BY idCliente
				ORDER BY ate DESC
			) = 1 THEN 1
			ELSE 0
		END
INTO #contatos02
FROM #contatos01;


-- Confer�ncia
SELECT *
FROM #contatos02
ORDER BY
	 idCliente
	,de
	,telefone;


-- 3) Adiciona controles e checksum
DROP TABLE IF EXISTS #Fim;

SELECT
	 A.*
	,[InsertedDateCtrl] = GETDATE() -- @InsertedDateCtrl
	,[InitialDateCtrl]  = GETDATE() -- @InitialDateCtrl
	,[FinalDateCtrl]    = GETDATE() -- @FinalDateCtrl
	,[ProcessKeyCtrl]   = 3         -- @ProcessKeyCtrl
	,[ChecksumId]       = CHECKSUM(*)
INTO #Fim
FROM #contatos02 AS A
WHERE 1=1;


-- Confer�ncia final
SELECT TOP 10 *
FROM #Fim
ORDER BY
	 idCliente
	,ate DESC;


-- 4) Atualiza registros existentes que sofreram altera��o
UPDATE B
SET
	 B.[de]                 = A.[de]
	,B.[ate]                = A.[ate]
	,B.[ContatoMaisRecente] = A.[ContatoMaisRecente]
	,B.[InitialDateCtrl]    = GETDATE()
	,B.[FinalDateCtrl]      = GETDATE()
	,B.[ProcessKeyCtrl]     = 3
	,B.[ChecksumId]         = A.[ChecksumId]
FROM [dbTestes].[DataMart].[DimContato] B
INNER JOIN #Fim A
	ON A.[telefone]  = B.[telefone]
   AND A.[idCliente] = B.[idCliente]
WHERE A.[ChecksumId] <> B.[ChecksumId];


-- 5) Insere novos registros
INSERT INTO [dbTestes].[DataMart].[DimContato]
SELECT *
FROM #Fim A
WHERE 1=1
  AND NOT EXISTS (
	SELECT 1
	FROM [dbTestes].[DataMart].[DimContato] B
	WHERE A.[telefone]  = B.[telefone]
	  AND A.[idCliente] = B.[idCliente]
  );
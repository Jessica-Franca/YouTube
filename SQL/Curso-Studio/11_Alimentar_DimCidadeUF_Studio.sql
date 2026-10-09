/*
  Script: 11_Alimentar_DimCidadeUF_Studio.sql
  Mini curso: Base Studio (salão de beleza) — dimensão Cidade/UF
  Vídeo: SQL Server na prática: criando a Dimensão Cidade/UF e atualizando a Fato | Base Studio
  YouTube: https://youtu.be/hELJQuNW204
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Inserir combinações distintas de cidade + UF na DimCidadeUF sem duplicar registros
  Como estudar: execute depois de criar a dimensão e confira os dados de origem e destino
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: 10_Create_DimCidadeUF_Studio.sql e HistStudio carregada
  Próximo: 12_Select_Fato_Studio.sql
*/

DECLARE @DtFim DATE = (
    SELECT DATEADD(DAY, 1, MAX(FinalDateCtrl))
    FROM [dbTestes].[Historico].[HistStudio] WITH (NOLOCK)
);

DECLARE @DtIni DATE = DATEADD(DAY, -2, @DtFim);

DROP TABLE IF EXISTS #CidadeUF;

SELECT DISTINCT
    A.cidade,
    A.uf
INTO #CidadeUF
FROM [dbTestes].[Historico].[HistStudio] AS A
WHERE A.cidade IS NOT NULL
  AND A.uf IS NOT NULL
  AND A.FinalDateCtrl >= @DtIni
  AND A.FinalDateCtrl < @DtFim;

-- Conferência da origem
SELECT *
FROM #CidadeUF
ORDER BY cidade, uf;

-- Insere somente combinações cidade/UF ainda inexistentes.
INSERT INTO [dbTestes].[DataMart].[DimCidadeUF]
(
    [cidade], [uf],
    [InsertedDateCtrl], [InitialDateCtrl], [FinalDateCtrl], [ProcessKeyCtrl]
)
SELECT
    A.[cidade],
    A.[uf],
    GETDATE(),
    GETDATE(),
    GETDATE(),
    4
FROM #CidadeUF AS A
WHERE NOT EXISTS
(
    SELECT 1
    FROM [dbTestes].[DataMart].[DimCidadeUF] AS B
    WHERE B.[cidade] = A.[cidade]
      AND B.[uf] = A.[uf]
);

-- Conferência final
SELECT *
FROM [dbTestes].[DataMart].[DimCidadeUF]
ORDER BY [idCidadeUF];
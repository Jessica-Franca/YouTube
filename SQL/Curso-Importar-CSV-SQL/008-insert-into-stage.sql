/*
  Script: 008-insert-into-stage.sql
  Vídeo: [008] CSV na temporária? Agora jogue na tabela Stage (INSERT INTO passo a passo)
  YouTube: https://www.youtube.com/watch?v=Qk52PNxX_24
  Objetivo: BULK INSERT na #Tmp → INSERT na Stage com colunas de controle
  Pré-requisito: 007-criar-tabela-stage.sql
  Roteiro: ../roteiros/008-insert-into-stage.md
  Banco: dbBaseHistoricaVendasRoupas
*/

USE dbBaseHistoricaVendasRoupas;
GO

-- Tabela temporária = 12 colunas iguais ao CSV (ainda sem Stage fixa)
DROP TABLE IF EXISTS #TmpStgVendasRoupas;
CREATE TABLE #TmpStgVendasRoupas
(
    DataDaVenda         VARCHAR(MAX) NULL,
    NomeProduto         VARCHAR(MAX) NULL,
    CategoriaItem       VARCHAR(MAX) NULL,
    PrecoUnit           VARCHAR(MAX) NULL,
    VendedorResponsavel VARCHAR(MAX) NULL,
    RegiaoVenda         VARCHAR(MAX) NULL,
    EstadoUF            VARCHAR(MAX) NULL,
    MeioVenda           VARCHAR(MAX) NULL,
    Quantidade          VARCHAR(MAX) NULL,
    ValorTotalBruto     VARCHAR(MAX) NULL,
    Devolvidos          VARCHAR(MAX) NULL,
    TempoProcSeg        VARCHAR(MAX) NULL
);
-- SELECT * FROM #TmpStgVendasRoupas


-- BULK INSERT: lê o arquivo do disco e "cola" na #Tmp de uma vez
BULK INSERT #TmpStgVendasRoupas
FROM 'C:\Users\jealu\Documents\001 ArbaSolutions\Curso\ETL_Inicial_CSV_EXCEL\etl-sqlserver-vendas-roupas\dados\amostra\vendas_2022_01.csv'
WITH
(
    FIRSTROW = 2,              -- pula linha 1 (cabeçalho)
    FIELDTERMINATOR = ';',     -- separador entre colunas
    ROWTERMINATOR = '0x0a',    -- fim de cada linha
    CODEPAGE = '65001',        -- UTF-8 (acentos)
    TABLOCK                    -- performance em carga grande
);

-- PASSO 3: INSERT na Stage com metadados de controle
INSERT INTO Stage.StgVendasRoupas
(
    DataDaVenda,
    NomeProduto,
    CategoriaItem,
    PrecoUnit,
    VendedorResponsavel,
    RegiaoVenda,
    EstadoUF,
    MeioVenda,
    Quantidade,
    ValorTotalBruto,
    Devolvidos,
    TempoProcSeg,
    NomeArquivo,
    InsertedDateCtrl,
    InitialDateCtrl,
    FinalDateCtrl,
    ProcessKeyCtrl
)
SELECT
    t.DataDaVenda,
    t.NomeProduto,
    t.CategoriaItem,
    t.PrecoUnit,
    t.VendedorResponsavel,
    t.RegiaoVenda,
    t.EstadoUF,
    t.MeioVenda,
    t.Quantidade,
    t.ValorTotalBruto,
    t.Devolvidos,
    t.TempoProcSeg,
    'vendas_2022_01.csv', -- @NomeArquivo     
    GETDATE(), -- @InsertedDateCtrl
    GETDATE(), -- @InitialDateCtrl 
    GETDATE(), -- @FinalDateCtrl   
    1  -- @ProcessKeyCtrl 
FROM #TmpStgVendasRoupas AS t;

DROP TABLE #TmpStgVendasRoupas;


/*
-- Prova: quantas linhas entraram?
SELECT COUNT(*) AS TotalLinhas FROM #TmpStgVendasRoupas;
SELECT COUNT(*) AS TotalLinhas FROM Stage.StgVendasRoupas;

-- falar sobre a diferença de uma e outra.
SELECT TOP 5 * FROM #TmpStgVendasRoupas;
SELECT TOP 5 * FROM Stage.StgVendasRoupas

--TRUNCATE TABLE Stage.StgVendasRoupas

GO

*/
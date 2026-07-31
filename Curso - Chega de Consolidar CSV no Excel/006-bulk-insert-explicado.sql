/*
  Script: 006-bulk-insert-explicado.sql
  Vídeo: [006] Importar CSV no SQL Server sem copiar no Excel | BULK INSERT passo a passo
  Objetivo: Demo didática — BULK INSERT na tabela temporária #Tmp
  Pré-requisito: prep-01-criar-banco.sql, prep-02-criar-schemas.sql
  Banco: dbBaseHistoricaVendasRoupas
*/

USE dbBaseHistoricaVendasRoupas;
GO

-- Tabela temporária = 12 colunas iguais ao CSV (ainda sem Stage fixa)
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

-- Prova: quantas linhas entraram?
SELECT COUNT(*) AS TotalLinhas FROM #TmpStgVendasRoupas;

SELECT TOP 5 * FROM #TmpStgVendasRoupas;

DROP TABLE #TmpStgVendasRoupas;
GO
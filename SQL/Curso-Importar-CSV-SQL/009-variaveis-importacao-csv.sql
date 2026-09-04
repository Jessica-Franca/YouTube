/*
  Script: 009-variaveis-importacao-csv.sql
  Vídeo: [009] Variáveis no SQL Server Automatizando a Importação de CSV
  YouTube: https://www.youtube.com/watch?v=b6j5hwZ7NW4
  Objetivo: Mesmo fluxo do 008, com variáveis no lugar de valores fixos
  Pré-requisito: 006 + 007 + 008 · 007-criar-tabela-stage.sql executado
  Roteiro: ../roteiros/009-variaveis-importacao-csv.md
  Próximo vídeo: 010-criar-proc-stg-vendas-roupas.sql
  Banco: dbBaseHistoricaVendasRoupas
*/

USE dbBaseHistoricaVendasRoupas;
GO

DECLARE
    @CaminhoArquivo  VARCHAR(500) = 'C:\Users\jealu\Documents\001 ArbaSolutions\Curso\ETL_Inicial_CSV_EXCEL\etl-sqlserver-vendas-roupas\dados\amostra\',
    @NomeArquivo     VARCHAR(260) = 'vendas_2022_01.csv',
    @InitialDateCtrl DATETIME = NULL,
    @FinalDateCtrl   DATETIME = NULL,
    @ProcessKeyCtrl  INT      = -1

    DECLARE @CaminhoCompleto  VARCHAR(800);
    DECLARE @Sql              NVARCHAR(MAX);
    DECLARE @InsertedDateCtrl DATETIME = GETDATE();
    DECLARE @Linhas           INT;

    SET @InitialDateCtrl = ISNULL(@InitialDateCtrl, DATEADD(DAY, -1, convert(date, GETDATE())));
    SET @FinalDateCtrl   = ISNULL(@FinalDateCtrl, convert(date, GETDATE()));

    -- Montar @CaminhoCompleto
    IF RIGHT(@CaminhoArquivo, 1) IN (N'\', N'/')
        SET @CaminhoCompleto = @CaminhoArquivo + @NomeArquivo;
    ELSE
        SET @CaminhoCompleto = @CaminhoArquivo + N'\' + @NomeArquivo;

    DROP TABLE IF EXISTS #TmpStgVendasRoupas
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

    SET @Sql = N'
    BULK INSERT #TmpStgVendasRoupas
    FROM ''' + REPLACE(@CaminhoCompleto, '''', '''''') + '''
    WITH
    (
        FIRSTROW = 2,
        FIELDTERMINATOR = '';'',
        ROWTERMINATOR = ''0x0a'',
        CODEPAGE = ''65001'',
        TABLOCK
    );';

    EXEC sys.sp_executesql @Sql;

    SELECT @Linhas = COUNT(*) FROM #TmpStgVendasRoupas;

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
        @NomeArquivo,
        @InsertedDateCtrl,
        @InitialDateCtrl,
        @FinalDateCtrl,
        @ProcessKeyCtrl
    FROM #TmpStgVendasRoupas AS t;

    DROP TABLE #TmpStgVendasRoupas;
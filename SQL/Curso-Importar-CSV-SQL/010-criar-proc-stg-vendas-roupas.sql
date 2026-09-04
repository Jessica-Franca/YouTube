/*
  Script: 010-criar-proc-stg-vendas-roupas.sql
  Vídeo: [010] Do script à procedure: macro de importação CSV no SQL Server
  YouTube: https://www.youtube.com/watch?v=wN--o_yIgsw
  Objetivo: Criar procedure de importação fixa (BULK INSERT na stage)
  Pré-requisito: 007-criar-tabela-stage.sql
  Banco: dbBaseHistoricaVendasRoupas
  Roteiro: ../roteiros/010-criar-proc-stg-vendas-roupas.md
  Procedure: Stage.PrcStgVendasRoupas
*/

USE dbBaseHistoricaVendasRoupas;
GO

CREATE or ALTER PROCEDURE Stage.PrcStgVendasRoupas
    @CaminhoArquivo  VARCHAR(500),
    @NomeArquivo     VARCHAR(260),
    @InitialDateCtrl DATETIME = NULL,
    @FinalDateCtrl   DATETIME = NULL,
    @ProcessKeyCtrl  INT      = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CaminhoCompleto  NVARCHAR(800);
    DECLARE @Sql              NVARCHAR(MAX);
    DECLARE @InsertedDateCtrl DATETIME = GETDATE();
    DECLARE @Linhas           INT;

    SET @InitialDateCtrl = CONVERT(DATE, ISNULL(@InitialDateCtrl, DATEADD(DAY, -1, GETDATE())));
    SET @FinalDateCtrl   = CONVERT(DATE, ISNULL(@FinalDateCtrl, GETDATE()));
    SET @ProcessKeyCtrl  = ISNULL(@ProcessKeyCtrl, -1);

    IF RIGHT(@CaminhoArquivo, 1) IN (N'\', N'/')
        SET @CaminhoCompleto = @CaminhoArquivo + @NomeArquivo;
    ELSE
        SET @CaminhoCompleto = @CaminhoArquivo + N'\' + @NomeArquivo;

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

    -- PASSO 2: BULK INSERT na tabela temporaria (12 cols = CSV)
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

    PRINT N'Importacao concluida: ' + @NomeArquivo;
    PRINT N'Linhas na stage: ' + CAST(@Linhas AS NVARCHAR(20));
END
GO

PRINT 'Procedure Stage.PrcStgVendasRoupas criada.';
GO

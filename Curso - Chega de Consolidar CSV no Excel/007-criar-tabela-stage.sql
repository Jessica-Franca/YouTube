/*
  Script: 007-criar-tabela-stage.sql
  Vídeo: [007] Criar tabela Stage no SQL Server (IF, OBJECT_ID e colunas de controle)
  Objetivo: Criar tabela Stage.StgVendasRoupas (dados + colunas de controle)
  Banco: dbBaseHistoricaVendasRoupas

  O BULK INSERT carrega #TmpStgVendasRoupas (12 colunas = CSV).
  A procedure Stage.PrcStgVendasRoupas grava na stage com colunas de controle.

  CSV (base_origem_transacional.csv)  →  Coluna na tabela
  1. Data da Venda                     →  DataDaVenda
  2. Nome do Produto                   →  NomeProduto
  3. Categoria Item                    →  CategoriaItem
  4. Preço Unit                        →  PrecoUnit
  5. Vendedor Responsavel              →  VendedorResponsavel
  6. Regiao Venda                      →  RegiaoVenda
  7. Estado UF                         →  EstadoUF
  8. Meio de Venda                     →  MeioVenda
  9. Quantidade                        →  Quantidade
  10. Valor Total Bruto                →  ValorTotalBruto
  11. Devolvidos                       →  Devolvidos
  12. Tempo Proc Seg                   →  TempoProcSeg
*/

USE dbBaseHistoricaVendasRoupas;
GO

IF OBJECT_ID(N'Stage.StgVendasRoupas', N'U') IS NOT NULL
    DROP TABLE Stage.StgVendasRoupas;
GO

CREATE TABLE Stage.StgVendasRoupas
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
    TempoProcSeg        VARCHAR(MAX) NULL,
    NomeArquivo         VARCHAR(MAX) NULL,
    InsertedDateCtrl    DATETIME     NULL,
    InitialDateCtrl     DATETIME     NULL,
    FinalDateCtrl       DATETIME     NULL,
    ProcessKeyCtrl      INT          NULL
);
GO

PRINT 'Tabela Stage.StgVendasRoupas criada (12 colunas do CSV + controle).';
GO
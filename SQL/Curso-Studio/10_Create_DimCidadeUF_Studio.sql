/*
  Script: 10_Create_DimCidadeUF_Studio.sql
  Mini curso: Base Studio (salão de beleza) — dimensão Cidade/UF
  Vídeo: SQL Server na prática: criando a Dimensão Cidade/UF e atualizando a Fato | Base Studio
  YouTube: https://youtu.be/hELJQuNW204
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Criar DataMart.DimCidadeUF, o registro -1 (Não Mapeado) e índice único em cidade + UF
  Como estudar: execute no SSMS depois de carregar o histórico da Base Studio
  Banco: dbTestes (ou outro banco de teste)
  Próximo: 11_Alimentar_DimCidadeUF_Studio.sql
*/

USE [dbTestes];
GO

IF SCHEMA_ID('DataMart') IS NULL
    EXEC('CREATE SCHEMA DataMart');
GO

--DROP TABLE IF EXISTS [DataMart].[DimCidadeUF];
CREATE TABLE [DataMart].[DimCidadeUF](
    [idCidadeUF] INT IDENTITY(1,1) PRIMARY KEY,
    [cidade] VARCHAR(31) NOT NULL,
    [uf] VARCHAR(11) NOT NULL,
    [InsertedDateCtrl] DATETIME NOT NULL,
    [InitialDateCtrl] DATETIME NOT NULL,
    [FinalDateCtrl] DATETIME NOT NULL,
    [ProcessKeyCtrl] INT NOT NULL
);
GO

-- Registro padrão: -1 representa valores não mapeados.
SET IDENTITY_INSERT [DataMart].[DimCidadeUF] ON;

INSERT INTO [DataMart].[DimCidadeUF]
(
    [idCidadeUF], [cidade], [uf],
    [InsertedDateCtrl], [InitialDateCtrl], [FinalDateCtrl], [ProcessKeyCtrl]
)
VALUES
(
    -1, 'Não Mapeado', 'Não Mapeado',
    GETDATE(), GETDATE(), GETDATE(), -4
);

SET IDENTITY_INSERT [DataMart].[DimCidadeUF] OFF;
GO

-- Índice único composto: o nome da cidade pode se repetir em UFs diferentes.
CREATE UNIQUE NONCLUSTERED INDEX UX_DimCidadeUF_CidadeUF
    ON [DataMart].[DimCidadeUF] ([cidade], [uf]);
GO
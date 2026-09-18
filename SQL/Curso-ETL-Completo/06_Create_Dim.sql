/*
  Script: 06_Create_Dim.sql
  Vídeo: [SQL] Criando DIMENSÕES (Canal, Produto e Motivo) + Procedure com MERGE
  YouTube: https://www.youtube.com/watch?v=4h6_TkjIKho
  Objetivo: Criar DimCanal, DimProduto e DimMotivoSatisfacao
  Próximo: a procedure com MERGE está no mesmo vídeo; o script 06_Proc_Dim.sql ainda não está nesta pasta
  Banco: dbCallCenter · Schema: ClienteX
*/

USE [dbCallCenter]
GO

CREATE TABLE [ClienteX].[DimCanal](
	[ID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Canal] [varchar](18) NOT NULL,
	[InsertedDateCtrl] [datetime] NOT NULL,
	[InitialDateCtrl] [datetime] NOT NULL,
	[FinalDateCtrl] [datetime] NOT NULL
);

CREATE NONCLUSTERED INDEX [IX_DimCanal] ON [dbCallCenter].[ClienteX].[DimCanal] ([Canal])


CREATE TABLE [ClienteX].[DimMotivoSatisfacao](
	[ID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Motivo_Satisfacao] [varchar](44) NOT NULL,
	[InsertedDateCtrl] [datetime] NOT NULL,
	[InitialDateCtrl] [datetime] NOT NULL,
	[FinalDateCtrl] [datetime] NOT NULL
	);
CREATE NONCLUSTERED INDEX [IX_MotivoSatisfacao] ON [dbCallCenter].[ClienteX].[DimMotivoSatisfacao] ([Motivo_Satisfacao])

CREATE TABLE [ClienteX].[DimProduto](
	[ID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Produto] [varchar](32) NOT NULL,
	[InsertedDateCtrl] [datetime] NOT NULL,
	[InitialDateCtrl] [datetime] NOT NULL,
	[FinalDateCtrl] [datetime] NOT NULL
);
CREATE NONCLUSTERED INDEX [IX_Produto] ON [dbCallCenter].[ClienteX].[DimProduto] ([Produto])


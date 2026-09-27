/*
  Script: 04_Create_DimCliente.sql
  Mini curso: Base Studio (salão de beleza) — aula 3 (dimensão de cliente)
  Vídeo: Como criar a Dimensão de Cliente no SQL Server (modelo estrela)
  YouTube: continuação de https://www.youtube.com/watch?v=oTvTQ4SgFqA (link deste vídeo entra quando publicar)
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Criar DataMart.DimCliente, o registro -1 (Não Mapeado) e o índice único em cliente
  Como estudar: execute no SSMS depois do Histórico (aulas 1 e 2)
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: 02_Create_HistStudio.sql + 03_Insert_HistStudio.sql
  Próximo: 05_Alimentar_DimCliente.sql (mesmo vídeo)
*/

USE [dbTestes]
GO

-- Schema DataMart
IF SCHEMA_ID('DataMart') IS NULL
	EXEC('CREATE SCHEMA DataMart');
GO

--DROP TABLE IF EXISTS [DataMart].[DimCliente]
CREATE TABLE [DataMart].[DimCliente](
	[idCliente] INT IDENTITY(1,1) PRIMARY KEY,
	[cliente] [varchar](28) not null,
	[InsertedDateCtrl] [datetime] NOT NULL,
	[InitialDateCtrl] [datetime] NOT NULL,
	[FinalDateCtrl] [datetime] NOT NULL,
	[ProcessKeyCtrl] [int] NOT NULL
);

	-- Insere registro padrão
	SET IDENTITY_INSERT [DataMart].[DimCliente] ON;

	INSERT INTO [DataMart].[DimCliente]
	(
		idCliente,
		cliente,
		InsertedDateCtrl,
		InitialDateCtrl,
		FinalDateCtrl,
		ProcessKeyCtrl
	)
	VALUES
	(
		-1,
		'Não Mapeado',
		GETDATE(),
		GETDATE(),
		GETDATE(),
		-1
	);

	SET IDENTITY_INSERT [DataMart].[DimCliente] OFF;
	GO

	-- Índice único no cliente
	CREATE UNIQUE NONCLUSTERED INDEX UX_DimCliente_Cliente
		ON [DataMart].[DimCliente] ([cliente]);
	GO

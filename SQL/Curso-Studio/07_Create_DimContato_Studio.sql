/*
  Script: 07_Create_DimContato.sql
  Mini curso: Base Studio (salão de beleza) — aula 4 (dimensão de contato)
  Vídeo: Dimensão de Contato + atualização da fato | Base Studio
  YouTube: [https://www.youtube.com/watch?v=jMhzQbc7vls]
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Criar DataMart.DimContato, o registro -1 (Não Mapeado) e o índice em telefone
  Como estudar: execute no SSMS depois da DimCliente (aulas anteriores)
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: 04_Create_DimCliente.sql + 05_Alimentar_DimCliente.sql
  Próximo: 08_Alimentar_DimContato.sql
*/

USE [dbTestes]
GO

-- Schema DataMart
IF SCHEMA_ID('DataMart') IS NULL
	EXEC('CREATE SCHEMA DataMart');
GO

--DROP TABLE IF EXISTS [DataMart].[DimContato]

CREATE TABLE [DataMart].[DimContato](
	[idContato] INT IDENTITY(1,1) PRIMARY KEY,
	[idCliente] INT,
	[telefone] [varchar](21) NULL,
	[de] DATE NULL,
	[ate] DATE NULL,
	[ContatoMaisRecente] BIT,
	[InsertedDateCtrl] [datetime] NOT NULL,
	[InitialDateCtrl] [datetime] NOT NULL,
	[FinalDateCtrl] [datetime] NOT NULL,
	[ProcessKeyCtrl] INT NOT NULL,
	[ChecksumId] INT NOT NULL
);

	-- Insere registro padr�o
	SET IDENTITY_INSERT [DataMart].[DimContato] ON;

	INSERT INTO [DataMart].[DimContato]
	(
		 [idContato]
		,[idCliente]
		,[telefone]
		,[de]
		,[ate]
		,[ContatoMaisRecente]
		,InsertedDateCtrl
		,InitialDateCtrl
		,FinalDateCtrl
		,ProcessKeyCtrl
		,ChecksumId
	)
	VALUES
	(
		-1,
		-1,
		'-1',
		NULL,
		NULL,
		1,
		GETDATE(),
		GETDATE(),
		GETDATE(),
		-3,
		-1
	);

	SET IDENTITY_INSERT [DataMart].[DimContato] OFF;
	GO

	-- �ndice �nico no cliente
	CREATE UNIQUE NONCLUSTERED INDEX UX_DimContato_telefone
		ON [DataMart].[DimContato] ([telefone]);
	GO
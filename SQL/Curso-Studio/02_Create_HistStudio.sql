/*
  Script: 02_Create_HistStudio.sql
  Mini curso: Estúdio (CSV → Stage → Histórico) — aula 2/3
  Vídeo: Criar a tabela Histórico do estúdio (HistStudio)
  YouTube: (cola o link do vídeo aqui quando publicar)
  Objetivo: Criar Historico.HistStudio com tipos corretos e colunas de controle
  Como estudar: execute no SSMS depois da aula 1 (Stage.StgStudio já existe)
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: 01_BULK_INSERT_CSV_Stage.sql
  Próximo: 03_Insert_HistStudio.sql
*/

USE [dbTestes]
GO

-- Schema Historico
IF SCHEMA_ID('Historico') IS NULL
	EXEC('CREATE SCHEMA Historico');
GO

--DROP TABLE IF EXISTS [Historico].[HistStudio]
CREATE TABLE [Historico].[HistStudio](
	[id_atendimento] INT,
	[data_atendimento] DATE,
	[hora_atendimento] TIME,
	[cliente] [varchar](28) NULL,
	[telefone] [varchar](21) NULL,
	[cidade] [varchar](31) NULL,
	[uf] [varchar](2) NULL,
	[profissional] [varchar](26) NULL,
	[servico] [varchar](25) NULL,
	[categoria] [varchar](22) NULL,
	[valor] decimal(10,1),
	[forma_pagamento] [varchar](27) NULL,
	[status] [varchar](24) NULL,
	[canal_agendamento] [varchar](20) NULL,
	[NomeArquivo] [varchar](30) NOT NULL,
	[InsertedDateCtrl] [datetime] NOT NULL,
	[InitialDateCtrl] [datetime] NOT NULL,
	[FinalDateCtrl] [datetime] NOT NULL,
	[ProcessKeyCtrl] [int] NOT NULL
)
GO

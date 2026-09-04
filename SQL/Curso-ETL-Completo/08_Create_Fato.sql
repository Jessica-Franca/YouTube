/*
  Script: 08_Create_Fato.sql
  V?deo: [SQL] Como Criar e Alimentar uma Tabela FATO com MERGE
  YouTube: https://www.youtube.com/watch?v=RzKSyF4YOII
  Objetivo: Criar tabela FatoAtendimentoCSAT
  Pr?ximo: 08_Proc_Fato.sql
  Banco: dbCallCenter � Schema: ClienteX
*/

USE [dbCallCenter]
GO
DROP TABLE IF EXISTS [dbCallCenter].[ClienteX].[FatoAtendimentoCSAT]
CREATE TABLE [dbCallCenter].[ClienteX].[FatoAtendimentoCSAT] (
    -- Chaves (Dimens�es)
    [Data_Contato]          DATE NOT NULL,
    [Matricula_Expert]      INT NOT NULL,
    [IdCanal]               INT NOT NULL,
    [IdProduto]             INT NOT NULL,
    [IdMotivoSatisfacao]    INT NOT NULL,
	[Nota_Satisfacao]       INT NOT NULL,
	
    
    -- M�tricas
	[Respondeu_Pesquisa]    INT NULL,
    [FCR]                   INT NULL,
    [TempAtendSeg]          INT NULL,
    [TempFilaSeg]           INT NULL,
    [TempOperSeg]           INT NULL,
    [QtdAtendimentos]       INT NULL,

	-- Colunas de controle
	[ChecksumId]			INT NOT NULL,
	[InsertedDateCtrl]		DATETIME NOT NULL,
	[InitialDateCtrl]		DATETIME NOT NULL,
	[FinalDateCtrl]			DATETIME NOT NULL

    -- Defini��o da Chave Prim�ria Composta
    CONSTRAINT [PK_FatoAtendimentoCSAT] PRIMARY KEY CLUSTERED (
        [Data_Contato],
        [Matricula_Expert],
        [IdCanal],
        [IdProduto],
        [IdMotivoSatisfacao],
		[Nota_Satisfacao]

    )
);
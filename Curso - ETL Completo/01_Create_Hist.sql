/*
  Script: 01_Create_Hist.sql
  Vídeo: [SQL] Como Criar uma Tabela Histórico no SQL Server (do jeito CERTO!) — Tipos, PK e Boas Práticas
  YouTube: https://www.youtube.com/watch?v=v9UfGpuI0Gc
  Objetivo: Criar HistAtendimentoCSAT com tipos corretos, colunas de controle e PK composta
  Como estudar: abra no SSMS, execute e compare com o vídeo
  Banco: dbCallCenter · Schema: ClienteX
*/

--DROP TABLE [dbCallCenter].[ClienteX].[HistAtendimentoCSAT]
CREATE TABLE [dbCallCenter].[ClienteX].[HistAtendimentoCSAT](
	 Data_Hora_Contato DATETIME NOT NULL
	,Data_Contato DATE NOT NULL
	,Canal	VARCHAR(18) NOT NULL
	,Produto VARCHAR(32) NOT NULL
	,Respondeu_Pesquisa	INT NULL
	,Nota_Satisfacao INT NULL
	,Motivo_Satisfacao VARCHAR(44) NOT NULL
	,Tempo_Atendimento_Segundos	FLOAT NULL
	,Tempo_Fila_Segundos FLOAT NULL
	,Tempo_Operacional_Segundos FLOAT NULL
	,FCR INT NULL
	,Matricula_Expert INT NOT NULL
	,[InsertedDateCtrl] DATETIME NOT NULL
	,[InitialDateCtrl] DATETIME NOT NULL
	,[FinalDateCtrl] DATETIME NOT NULL
	,CONSTRAINT PK_HistAtendimentoCSAT 
	PRIMARY KEY (
				 Data_Hora_Contato
				,[Matricula_Expert]
				,[Canal]
				,[Produto]
				,[Motivo_Satisfacao]
				)
);

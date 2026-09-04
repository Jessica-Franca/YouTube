/*
  Script: 00_Script_Inicial.sql
  Curso: ETL Completo � prepara??o (schema + Stage)
  Objetivo: Criar schema ClienteX e tabela Stage stgAtendimentoCSAT
  Como estudar: execute antes das aulas 1�8
  Banco: dbCallCenter
*/

-- Ordem de Execu??o

-- 01 - Cria??o de Schema para ser utilizado 
Create Schema ClienteX;

-- 02 - Cria??o da tabela Stage com os dados brutos iniciais
CREATE TABLE [dbCallCenter].[ClienteX].[stgAtendimentoCSAT](
	 Data_Contato					VARCHAR(MAX)
	,Canal							VARCHAR(MAX)
	,Produto						VARCHAR(MAX)
	,Respondeu_Pesquisa				VARCHAR(MAX)
	,Nota_Satisfacao				VARCHAR(MAX)
	,Motivo_Satisfacao				VARCHAR(MAX)
	,Tempo_Atendimento_Segundos		VARCHAR(MAX)
	,Tempo_Fila_Segundos			VARCHAR(MAX)
	,Tempo_Operacional_Segundos		VARCHAR(MAX)
	,FCR							VARCHAR(MAX)
	,Matricula_Expert				VARCHAR(MAX)
	,data_insercao					VARCHAR(MAX)
);

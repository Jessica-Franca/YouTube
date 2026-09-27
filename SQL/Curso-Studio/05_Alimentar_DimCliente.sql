/*
  Script: 05_Alimentar_DimCliente.sql
  Mini curso: Base Studio (salão de beleza) — aula 3 (dimensão de cliente)
  Vídeo: Como criar a Dimensão de Cliente no SQL Server (modelo estrela)
  YouTube: continuação de https://www.youtube.com/watch?v=oTvTQ4SgFqA (link deste vídeo entra quando publicar)
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Trazer clientes distintos do Histórico e inserir na DimCliente só o que ainda não existe
  Como estudar: execute por partes no SSMS (igual ao vídeo). A janela de data usa DATEADD +1 dia de propósito.
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: 04_Create_DimCliente.sql (HistStudio já carregada)
  Próximo: 06_Select_Fato.sql (mesmo vídeo)
*/

	DECLARE @DtFim DATE  = (SELECT dateadd(DAY, 1, MAX(FinalDateCtrl)) FROM [dbTestes].[Historico].[HistStudio] WITH(NOLOCK));
	DECLARE @DtIni DATE  = (dateadd(DAY, -2, @DtFim));

	DROP TABLE IF EXISTS #contatos
	SELECT DISTINCT
		A.cliente
	into #contatos
	FROM [dbTestes].[Historico].[HistStudio] A
	WHERE 1=1 
	AND A.cliente IS NOT NULL
	--AND A.FinalDateCtrl  between @DtIni and @DtFim
	AND A.FinalDateCtrl  >= @DtIni and A.FinalDateCtrl < @DtFim

	--dimCliente
	INSERT INTO [dbTestes].[DataMart].[DimCliente]
	SELECT
		 A.[cliente]
		,[InsertedDateCtrl] = GETDATE() -- @InsertedDateCtrl
		,[InitialDateCtrl]	= GETDATE() -- @InitialDateCtrl
		,[FinalDateCtrl]	= GETDATE() -- @FinalDateCtrl
		,[ProcessKeyCtrl]	= 2         -- @ProcessKeyCtrl
	FROM #contatos AS A
	WHERE 1=1
	AND NOT EXISTS (SELECT 1 FROM [dbTestes].[DataMart].[DimCliente] B  WHERE A.cliente = B.cliente)

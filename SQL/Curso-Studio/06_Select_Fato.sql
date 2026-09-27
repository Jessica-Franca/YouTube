/*
  Script: 06_Select_Fato.sql
  Mini curso: Base Studio (salão de beleza) — aula 3 (prévia da fato)
  Vídeo: Como criar a Dimensão de Cliente no SQL Server (modelo estrela)
  YouTube: continuação de https://www.youtube.com/watch?v=oTvTQ4SgFqA (link deste vídeo entra quando publicar)
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Prévia da fato — data do atendimento, idCliente e quantidade (LEFT JOIN na DimCliente)
  Como estudar: execute depois de alimentar a DimCliente. Cliente sem match vira -1 (Não Mapeado).
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: 05_Alimentar_DimCliente.sql
*/

/*V1 select Fato */

	SELECT
		 [data_atendimento]	= A.[data_atendimento]	
		,[idCliente]		= ISNULL(B.idCliente, -1)
		,[QtdAtendimento]	= COUNT(1)	 
	FROM [dbTestes].[Historico].[HistStudio] A
	LEFT JOIN [dbTestes].[DataMart].[DimCliente] B ON A.[cliente]  = B.[cliente]
	GROUP BY 
		 A.[data_atendimento]	
		,ISNULL(B.idCliente, -1)
	ORDER BY 1

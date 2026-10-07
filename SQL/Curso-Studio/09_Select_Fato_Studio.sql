/*
  Script: 09_Select_Fato.sql
  Mini curso: Base Studio (salão de beleza) — aula 4 (atualização da fato)
  Vídeo: Dimensão de Contato + atualização da fato | Base Studio
  YouTube: [https://www.youtube.com/watch?v=jMhzQbc7vls]
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Atualizar a prévia da fato com idCliente, quantidade de atendimentos e valor total
  Como estudar: execute depois de alimentar a DimContato
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: 08_Alimentar_DimContato.sql
*/

	SELECT
		 [data_atendimento]	= A.[data_atendimento]	
		,[idCliente]		= ISNULL(B.idCliente, -1)
		,[QtdRegistro]	= COUNT(1)
		,[Valor]			= SUM(A.Valor)
	FROM [dbTestes].[Historico].[HistStudio] A
	LEFT JOIN [dbTestes].[DataMart].[DimCliente] B ON A.[cliente]  = B.[cliente]
	GROUP BY 
		 A.[data_atendimento]	
		,ISNULL(B.idCliente, -1)
	ORDER BY 1
/*
  Script: 07_Select_Fato.sql
  Vídeo: [SQL] Como Montar uma Tabela Fato no SQL | SELECT, JOINs e Tratativas
  YouTube: https://www.youtube.com/watch?v=YtdZfOOYTgI
  Objetivo: SELECT base da Fato com JOINs, ISNULL e agregações
  Banco: dbCallCenter · Schema: ClienteX
*/

SELECT 
	 [Data_Contato]					= A.[Data_Contato]
	,[Matricula_Expert]				= ISNULL(A.[Matricula_Expert],-1)
	,[IdCanal]						= ISNULL(B.[ID],-1)
	,[IdProduto]					= ISNULL(C.[ID],-1)
	,[IdMotivoSatisfacao]			= ISNULL(D.[ID],-1)
	,[Respondeu_Pesquisa]			= ISNULL(A.[Respondeu_Pesquisa],-1)
	,[NotaSatisfacao]				= ISNULL(A.[Nota_Satisfacao],-1)
	,[FCR]							= ISNULL(A.[FCR],-1)
	,[Tempo_Atendimento_Segundos]	= SUM(A.[Tempo_Atendimento_Segundos])
	,[Tempo_Fila_Segundos]			= SUM(A.[Tempo_Fila_Segundos])
	,[Tempo_Operacional_Segundos]	= SUM(A.[Tempo_Operacional_Segundos])
	,[QtdAtendimentos]				= COUNT(A.[Data_Contato]) 
FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] AS A WITH(NOLOCK)
LEFT JOIN [dbCallCenter].[ClienteX].[DimCanal] AS B ON A.Canal = B.Canal
LEFT JOIN [dbCallCenter].[ClienteX].[DimProduto] AS C ON A.Produto = C.Produto
LEFT JOIN [dbCallCenter].[ClienteX].[DimMotivoSatisfacao] AS D ON A.Motivo_Satisfacao = D.Motivo_Satisfacao
GROUP BY 
	 A.[Data_Contato]
	,ISNULL(A.[Matricula_Expert],-1)
	,ISNULL(B.[ID],-1)
	,ISNULL(C.[ID],-1)
	,ISNULL(D.[ID],-1)
	,ISNULL(A.[Respondeu_Pesquisa],-1)
	,ISNULL(A.[Nota_Satisfacao],-1)
	,ISNULL(A.[FCR],-1)
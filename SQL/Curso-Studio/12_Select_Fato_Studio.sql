/*
  Script: 12_Select_Fato_Studio.sql
  Mini curso: Base Studio (salão de beleza) — atualização da prévia da fato
  Vídeo: SQL Server na prática: criando a Dimensão Cidade/UF e atualizando a Fato | Base Studio
  YouTube: https://youtu.be/hELJQuNW204
  Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U
  Objetivo: Incluir idCidadeUF na prévia da fato, mantendo idCliente, quantidade e valor
  Banco: dbTestes (ou outro banco de teste)
  Pré-requisito: dimensões DimCliente e DimCidadeUF carregadas
*/

SELECT
    [data_atendimento] = A.[data_atendimento],
    [idCliente] = ISNULL(B.[idCliente], -1),
    [idCidadeUF] = ISNULL(C.[idCidadeUF], -1),
    [QtdRegistro] = COUNT(1),
    [Valor] = SUM(A.[Valor])
FROM [dbTestes].[Historico].[HistStudio] AS A
LEFT JOIN [dbTestes].[DataMart].[DimCliente] AS B
    ON A.[cliente] = B.[cliente]
LEFT JOIN [dbTestes].[DataMart].[DimCidadeUF] AS C
    ON A.[cidade] = C.[cidade]
   AND A.[uf] = C.[uf]
GROUP BY
    A.[data_atendimento],
    ISNULL(B.[idCliente], -1),
    ISNULL(C.[idCidadeUF], -1)
ORDER BY A.[data_atendimento];
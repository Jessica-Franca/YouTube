/*
  Script: 08_Proc_Fato.sql
  V�deo: [SQL] Como Criar e Alimentar uma Tabela FATO com MERGE
  YouTube: https://www.youtube.com/watch?v=RzKSyF4YOII
  Objetivo: Carga da Fato com JOINs, #temp, CHECKSUM e MERGE
  Banco: dbCallCenter � Schema: ClienteX
*/

--SELECT DISTINCT  FinalDateCtrl FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] ORDER BY 1
--TRUNCATE TABLE [dbCallCenter].[ClienteX].[FatoAtendimentoCSAT]
DECLARE
 @InitialDateCtrl	DATETIME = '26/09/2025 00:00:00'
,@FinalDateCtrl		DATETIME = '27/09/2025 23:59:59'

DECLARE 
 @InsertedDateCtrl	DATETIME

SET @InsertedDateCtrl	= GETDATE()

DROP TABLE IF EXISTS #Base
SELECT 
	 [Data_Contato]			= A.[Data_Contato]
	,[Matricula_Expert]		= ISNULL(A.[Matricula_Expert]	,-1)
	,[IdCanal]				= ISNULL(B.ID 					,-1)
	,[IdProduto]			= ISNULL(D.[ID]					,-1)
	,[IdMotivoSatisfacao]	= ISNULL(C.ID					,-1)
	,[Nota_Satisfacao]		= ISNULL(A.[Nota_Satisfacao]	,-1)
	,[Respondeu_Pesquisa]	= SUM(A.[Respondeu_Pesquisa])
	,[FCR]					= SUM(A.[FCR])
	,[TempAtendSeg]			= SUM(A.[Tempo_Atendimento_Segundos])
	,[TempFilaSeg]			= SUM(A.[Tempo_Fila_Segundos]		)
	,[TempOperSeg]			= SUM(A.[Tempo_Operacional_Segundos])
	,[QtdAtendimentos]		= COUNT(A.[Matricula_Expert])
INTO #Base
FROM [dbCallCenter].[ClienteX].[HistAtendimentoCSAT] AS A WITH(NOLOCK)
LEFT JOIN [dbCallCenter].[ClienteX].[DimCanal]				B WITH(NOLOCK) ON B.Canal = A.Canal
LEFT JOIN [dbCallCenter].[ClienteX].[DimMotivoSatisfacao]	C WITH(NOLOCK) ON C.Motivo_Satisfacao = A.Motivo_Satisfacao
LEFT JOIN [dbCallCenter].[ClienteX].[DimProduto]			D WITH(NOLOCK) ON D.Produto = A.Produto
WHERE A.[FinalDateCtrl] = @FinalDateCtrl
GROUP BY 
 A.[Data_Contato]
,ISNULL(A.[Matricula_Expert]	,-1)
,ISNULL(B.ID 					,-1)
,ISNULL(D.[ID]					,-1)
,ISNULL(C.ID					,-1)
,ISNULL(A.[Nota_Satisfacao]	,-1)

DROP TABLE IF EXISTS #BaseFim
SELECT * 
	,[ChecksumId]		= CHECKSUM(*)
	,[InsertedDateCtrl] = @InsertedDateCtrl
	,[InitialDateCtrl]	= @InitialDateCtrl	
	,[FinalDateCtrl]	= @FinalDateCtrl		
INTO #BaseFim
FROM #Base 

--SELECT  * FROM #BaseFim
--WHERE 
--	Data_Contato = '2025-09-24' 	
--AND [Matricula_Expert] = 25179
--AND [IdCanal]  = 2	
--AND [IdProduto] = 5
--AND [IdMotivoSatisfacao] =5
--AND [Nota_Satisfacao] = 1


MERGE [dbCallCenter].[ClienteX].[FatoAtendimentoCSAT] AS DESTINO
USING #BaseFim AS ORIGEM
		ON (
				DESTINO.[Data_Contato]				= ORIGEM.[Data_Contato]		
			AND DESTINO.[Matricula_Expert]			= ORIGEM.[Matricula_Expert]	
			AND DESTINO.[IdCanal]					= ORIGEM.[IdCanal]			
			AND DESTINO.[IdProduto]					= ORIGEM.[IdProduto]			
			AND DESTINO.[IdMotivoSatisfacao]		= ORIGEM.[IdMotivoSatisfacao]	
			AND DESTINO.[Nota_Satisfacao]			= ORIGEM.[Nota_Satisfacao]	
			)
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (
					 [Data_Contato]			
					,[Matricula_Expert]		
					,[IdCanal]				
					,[IdProduto]			
					,[IdMotivoSatisfacao]	
					,[Nota_Satisfacao]
					,[Respondeu_Pesquisa]		
					,[FCR]					
					,[TempAtendSeg]			
					,[TempFilaSeg]			
					,[TempOperSeg]			
					,[QtdAtendimentos]		
					,[ChecksumId]
					,[InsertedDateCtrl]
					,[InitialDateCtrl]
					,[FinalDateCtrl]	
					)
			VALUES (
					 ORIGEM.[Data_Contato]			
					,ORIGEM.[Matricula_Expert]		
					,ORIGEM.[IdCanal]				
					,ORIGEM.[IdProduto]			
					,ORIGEM.[IdMotivoSatisfacao]	
					,ORIGEM.[Nota_Satisfacao]	
					,ORIGEM.[Respondeu_Pesquisa]
					,ORIGEM.[FCR]					
					,ORIGEM.[TempAtendSeg]			
					,ORIGEM.[TempFilaSeg]			
					,ORIGEM.[TempOperSeg]			
					,ORIGEM.[QtdAtendimentos]		
					,ORIGEM.[ChecksumId]
					,ORIGEM.[InsertedDateCtrl]
					,ORIGEM.[InitialDateCtrl]
					,ORIGEM.[FinalDateCtrl]	
					
					)
		WHEN MATCHED AND ( -- Se n�o tiver dados iguais
					DESTINO.[ChecksumId] != ORIGEM.[ChecksumId]
				)
		-- Quando ChecksumId for diferente do outro o update acontece
		THEN
					UPDATE SET
					 DESTINO.[Respondeu_Pesquisa]	 = ORIGEM.[Respondeu_Pesquisa]		
					,DESTINO.[FCR]					 = ORIGEM.[FCR]
					,DESTINO.[TempAtendSeg]			 = ORIGEM.[TempAtendSeg]		
					,DESTINO.[TempFilaSeg]			 = ORIGEM.[TempFilaSeg]		
					,DESTINO.[TempOperSeg]			 = ORIGEM.[TempOperSeg]		
					,DESTINO.[QtdAtendimentos]		 = ORIGEM.[QtdAtendimentos]	
					,DESTINO.[ChecksumId]			 = ORIGEM.[ChecksumId]
					,DESTINO.[InsertedDateCtrl]		 = ORIGEM.[InsertedDateCtrl]
					,DESTINO.[InitialDateCtrl]		 = ORIGEM.[InitialDateCtrl]
					,DESTINO.[FinalDateCtrl]		 = ORIGEM.[FinalDateCtrl];	


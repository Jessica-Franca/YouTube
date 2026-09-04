/*
  Script: SQL_LOOP_Data.sql
  Vídeo: [SQL] Como criar um LOOP com data no SQL Server para processos de ETL
  YouTube: https://youtu.be/Z4tMiRvUgJY
  Objetivo: WHILE por data, MIN/MAX, pular datas vazias (performance) e INSERT em temp
  Como estudar: abra no SSMS, execute por partes e compare com o vídeo
  Banco: dbFilmesPixel
*/

DECLARE @DtIni DATE
--DECLARE @DtFim DATE

SET @DtIni = (SELECT MIN([release_date]) FROM [dbFilmesPixel].[DataMart].[factFilmesPixel])
--SET @DtFim = (SELECT MAX([release_date]) FROM [dbFilmesPixel].[DataMart].[factFilmesPixel])

IF OBJECT_ID('tempdb..#LogProcessamento') IS NOT NULL DROP TABLE #LogProcessamento
CREATE TABLE #LogProcessamento (
    DataProcessada DATE,
    QtdRegistros INT
)

-- Loop: processa dia a dia enquanto @DtIni tiver valor
WHILE @DtIni IS NOT NULL
BEGIN
    PRINT 'Processando data: ' + CONVERT(VARCHAR, @DtIni, 120)
	
	INSERT INTO #LogProcessamento (DataProcessada, QtdRegistros)
	SELECT 
		  [release_date]
		 ,[qtdRegistros] = count([release_date])
	FROM [dbFilmesPixel].[DataMart].[factFilmesPixel]
	WHERE [release_date] = @DtIni
	GROUP BY [release_date]
    
	-- Forma lenta (dia a dia, inclusive datas sem registro):
	--SET @DtIni = DATEADD(DAY, 1,@DtIni)
    ---------------------------------------------------
    -- PULO DO GATO: próxima data que EXISTE na base
    ---------------------------------------------------
    SET @DtIni = (SELECT MIN([release_date]) FROM [dbFilmesPixel].[DataMart].[factFilmesPixel] WHERE [release_date] > @DtIni)
END

--TRUNCATE TABLE #LogProcessamento
--SELECT  * FROM #LogProcessamento

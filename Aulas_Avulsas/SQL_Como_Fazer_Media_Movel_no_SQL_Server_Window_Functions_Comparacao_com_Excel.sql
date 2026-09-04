/*
  Script: SQL_Como_Fazer_Media_Movel_no_SQL_Server_Window_Functions_Comparacao_com_Excel.sql
  Vídeo: [SQL] Como fazer média móvel no SQL Server (Window Functions) — comparação com Excel
  YouTube: https://www.youtube.com/watch?v=Vee5fI2On-Y
  Objetivo: Média móvel 6 e 12 meses com AVG() OVER (ROWS BETWEEN ... PRECEDING)
  Como estudar: abra no SSMS, execute e compare com o vídeo
  Banco: dbBaseHistoricaVendasRoupas
*/

;WITH VendasPorMes AS
(
    SELECT
        DataDaVenda,
        SUM(Quantidade) AS QuantidadeVendas
    FROM dbBaseHistoricaVendasRoupas.Historico.HistVendasRoupas
    GROUP BY DataDaVenda
)
SELECT
    DataDaVenda,
    QuantidadeVendas,
	REPLACE(	
	AVG(CAST(QuantidadeVendas AS DECIMAL(10,2)))
	OVER (
			ORDER BY DataDaVenda
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
		)
		,'.',',') AS MediaMovel12Meses,

	REPLACE(    AVG(CAST(QuantidadeVendas AS DECIMAL(10,2))) OVER (
        ORDER BY DataDaVenda
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ),'.',',')  AS MediaMovel6Meses
FROM VendasPorMes
ORDER BY DataDaVenda;
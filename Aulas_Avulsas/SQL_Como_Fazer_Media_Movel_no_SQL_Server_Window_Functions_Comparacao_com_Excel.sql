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
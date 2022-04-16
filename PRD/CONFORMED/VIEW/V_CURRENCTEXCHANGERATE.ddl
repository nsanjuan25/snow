create or replace view V_CURRENCTEXCHANGERATE(
	CURRENCYCODE,
	DATASOURCEKEY,
	EXCHANGERATE
) as
SELECT 
      ER.CurrencyCode
    , ER.DataSourceKey
    , MAX(ER.ExchangeRate) as ExchangeRate
FROM
    SAP.DimExchangeRates ER
    INNER JOIN (
        SELECT 
              E.CurrencyCode
			, E.DataSourceKey
            , MAX(E.EffectiveFromDateKey) AS MaxEffectiveFromDateKey
        FROM 
            SAP.DIMExchangeRates E
        WHERE 
            E.ToCurrencyCode ='USD'
        GROUP BY 
              E.CurrencyCode
			, E.DataSourceKey    
    ) LE ON ER.CurrencyCode = LE.CurrencyCode
    AND ER.EffectiveFromDateKey = LE.MaxEffectiveFromDateKey
    AND ER.DataSourceKey = LE.DataSourceKey
GROUP BY 
      ER.CurrencyCode
    , ER.DataSourceKey;
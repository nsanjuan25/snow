create or replace view V_CURRENTEXCHANGERATE(
	EXCHANGERATEKEY,
	CURRENCYCODE,
	TOCURRENCYCODE,
	DATASOURCEKEY,
	EFFECTIVEFROMDATEKEY,
	EXCHANGERATE
) as
/* 
Description		: This view is to provide a list of CurrentExchangeRateS
Created date	: 2017-??-??
Created By		: 

Start Revision History            
-----------------------------------------------------------------------------------------------
Date		Developer		Revision Description
----------	--------------	-------------------------------------------------------------
2017-??-??	?				Initial Version

-----------------------------------------------------------------------------------------------
End   Revision   History
*/

SELECT 
      DER.ExchangeRateKey
    , DER.CurrencyCode
    , DER.ToCurrencyCode
    , DER.DataSourceKey
    , DER.EffectiveFromDateKey
    , DER.ExchangeRate
FROM
     SAP.DimExchangeRates DER
     INNER JOIN 
     ( 
        SELECT 
              DER1.CurrencyCode   
            , DER1.DataSourceKey 
            , MAX( DER1.EffectiveFromDateKey ) AS EffectiveFromDateKey
        FROM
            SAP.DimExchangeRates AS DER1
        WHERE 
            DER1.ToCurrencyCode ='USD'
        GROUP BY
              DER1.CurrencyCode
            , DER1.DataSourceKey
    )LC ON 
        DER.CurrencyCode = LC.CurrencyCode
        AND DER.DataSourceKey = LC.DataSourceKey 
        AND DER.EffectiveFromDateKey = LC.EffectiveFromDateKey
WHERE 
    DER.ToCurrencyCode ='USD';
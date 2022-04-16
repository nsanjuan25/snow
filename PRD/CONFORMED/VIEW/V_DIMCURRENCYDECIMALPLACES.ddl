create or replace view V_DIMCURRENCYDECIMALPLACES(
	DATASOURCEKEY,
	CURRENCYCODE,
	NUMBERDECIMALPLACES,
	EXPONENT,
	EXPONENTFACTOR,
	RN
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimCurrencyDecimalPlaces
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-19      Juan Cedeno             Initial Revision
2021-08-26      Jagan                   Add JPS
2021-09-22      Jagan                   Add PLA
*/                          
SELECT 
    * 
FROM                         
    (
        SELECT 
              2 AS DataSourceKey                        
            , CurrencyCode
            , NumberDecimalPlaces
            , Exponent                        
            , ExponentFactor                        
            , row_number() over(partition by CurrencyCode order by CurrencyCode) rn
        FROM 
            conformed.v_hcc_ha_DimCurrencyDecimalPlaces   

        UNION ALL                         

        SELECT
              1 AS DataSourceKey
            , CurrencyCode
            , NumberDecimalPlaces
            , Exponent                        
            , ExponentFactor                  
            , row_number() over(partition by CurrencyCode order by CurrencyCode) rn
        FROM 
            conformed.v_ecc_ha_DimCurrencyDecimalPlaces
		
        UNION ALL                         

        SELECT
              5 AS DataSourceKey
            , CurrencyCode
            , NumberDecimalPlaces
            , Exponent                        
            , ExponentFactor                  
            , row_number() over(partition by CurrencyCode order by CurrencyCode) rn
        FROM 
            conformed.v_jps_ha_DimCurrencyDecimalPlaces
		
        UNION ALL                         

        SELECT
              4 AS DataSourceKey
            , CurrencyCode
            , NumberDecimalPlaces
            , Exponent                        
            , ExponentFactor                  
            , row_number() over(partition by CurrencyCode order by CurrencyCode) rn
        FROM 
            conformed.v_pla_ha_DimCurrencyDecimalPlaces
			
    )Q
WHERE 
    Q.rn = 1;
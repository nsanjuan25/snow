create or replace view V_DIMEXCHANGERATES(
	DATASOURCEKEY,
	DELETEFLAG,
	SRCLASTMODIFIEDDATE,
	ROW_ID,
	HASH_VALUE,
	FROMCURRENCYCODE,
	TOCURRENCYCODE,
	EFFECTIVEFROMDATE,
	EXCHANGERATE,
	UPDATED_ON
) as
/*-------------------------------------------------------------------------------

This view is used to do the ADD data to DIMEXCHANGERATES
---------------------------------------------------------------------------------
Revision History
---------------------------------------------------------------------------------
Date            Developer               Comments
---------------------------------------------------------------------------------
2021-02-04      Carlos Carrillo         Initial Revision
2021-07-26      Jagan                   Add JPS
2021-09-22      Jagan                   Add PLA
*/

  SELECT 
         4 AS DATASOURCEKEY
       , 0 AS DELETEFLAG
       , UPDATED_ON AS SrcLastModifiedDate
       , ROW_NUMBER() OVER (PARTITION BY FromCurrencyCode,
                                         ToCurrencyCode,
                                         EffectiveFromDate
                            ORDER BY Updated_On DESC
                           ) AS Row_ID
       , HASH(FromCurrencyCode,ToCurrencyCode,EffectiveFromDate)  AS HASH_VALUE                           
       , *
  FROM 
         CONFORMED.v_pla_HA_DimCurrencyExchangeRates
  
  UNION ALL

  SELECT 
         5 AS DATASOURCEKEY
       , 0 AS DELETEFLAG
       , UPDATED_ON AS SrcLastModifiedDate
       , ROW_NUMBER() OVER (PARTITION BY FromCurrencyCode,
                                         ToCurrencyCode,
                                         EffectiveFromDate
                            ORDER BY Updated_On DESC
                           ) AS Row_ID
       , HASH(FromCurrencyCode,ToCurrencyCode,EffectiveFromDate)  AS HASH_VALUE                           
       , *
  FROM 
         CONFORMED.v_jps_HA_DimCurrencyExchangeRates
  
  UNION ALL
  
  SELECT 
         2 AS DATASOURCEKEY
       , 0 AS DELETEFLAG
       , UPDATED_ON AS SrcLastModifiedDate
       , ROW_NUMBER() OVER (PARTITION BY FromCurrencyCode,
                                         ToCurrencyCode,
                                         EffectiveFromDate
                            ORDER BY Updated_On DESC
                           ) AS Row_ID
       , HASH(FromCurrencyCode,ToCurrencyCode,EffectiveFromDate)  AS HASH_VALUE
       , *
  FROM 
         CONFORMED.v_HCC_HA_DimCurrencyExchangeRates
  
  UNION ALL
  
  SELECT 
         1 AS DATASOURCEKEY
       , 0 AS DELETEFLAG
       , UPDATED_ON AS SrcLastModifiedDate
       , ROW_NUMBER() OVER (PARTITION BY FromCurrencyCode,
                                         ToCurrencyCode,
                                         EffectiveFromDate
                            ORDER BY Updated_On DESC
                           ) AS Row_ID
       , HASH(FromCurrencyCode,ToCurrencyCode,EffectiveFromDate)  AS HASH_VALUE
       , *
  FROM 
         CONFORMED.v_ECC_HA_DimCurrencyExchangeRates;
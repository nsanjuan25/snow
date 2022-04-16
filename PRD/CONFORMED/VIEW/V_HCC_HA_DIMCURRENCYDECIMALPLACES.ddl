create or replace view V_HCC_HA_DIMCURRENCYDECIMALPLACES(
	CURRENCYCODE,
	NUMBERDECIMALPLACES,
	EXPONENT,
	EXPONENTFACTOR
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimCurrencyDecimalPlaces
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-19      Juan Cedeno             Initial Revision
*/                        
SELECT
      IFNULL(CurrKey,'') as CurrencyCode
    , CurrDec as NumberDecimalPlaces
    , (2 - currdec) as Exponent                        
    , power(10, (2 - currdec))  as ExponentFactor
FROM
    conformed.hcc_ha_tcurx;
create or replace view V_DIMSAPFUNCTIONS(
	FUNCTION_ID,
	FUNCTION_TEXT
) as 
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into DimSAPFunctions
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-04-12      Venkata             Initial Revision

*/
 SELECT DISTINCT  
          GR.function_id
        , GR.function_text
    FROM
        BW_HA_GRC_RISK_DATA GR;
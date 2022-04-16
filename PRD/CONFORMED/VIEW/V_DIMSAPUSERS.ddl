create or replace view V_DIMSAPUSERS(
	ZUSER,
	ZFSTNAME,
	ZLSTNAME
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimSAPUsers
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-04-12      Venkata             Initial Revision

*/
SELECT DISTINCT  
          D.zuser
        , D.zfstname
        , D.zlstname
    FROM
        BW_HA_USER_USAGE_ECC D;
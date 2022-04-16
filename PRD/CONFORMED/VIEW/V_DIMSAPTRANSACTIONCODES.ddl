create or replace view V_DIMSAPTRANSACTIONCODES(
	TCODE,
	TCODEDESCRIPTION
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into DimSAPTransactionCodes
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-04-12      Venkata             Initial Revision

*/
  SELECT DISTINCT
          GR.zaction AS TCode
        , GR.zactxt  AS TCodeDescription
    FROM
        BW_HA_GRC_RISK_DATA GR

    UNION ALL

    SELECT DISTINCT
          UU.zentry AS TCode
        , ''  AS TCodeDescription
    FROM
       BW_HA_USER_USAGE_ECC UU
    WHERE NOT EXISTS
    (
        SELECT NULL FROM BW_HA_GRC_RISK_DATA GR WHERE GR.zaction = UU.zentry
    );
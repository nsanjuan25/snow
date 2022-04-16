create or replace view V_ECC_DIMPURCHASINGGROUPS(
	DATASOURCEKEY,
	PURCHASINGGROUP,
	BUYERNAME,
	PURCHASINGGROUPTELNUMBER,
	EMAILADDRESS,
	SPOOL,
	PURCHASINGGROUPFAXNUMBER,
	PURCHASINGGROUPTELEXT,
	PURCHASINGGROUPTELCODENUMBER,
	SRCLASTMODIFIEDDATE
) as
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into DimPurchasingGroups
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-01      SRIDHAR                 Initial Revision
*/
SELECT 
	 1 as DATASOURCEKEY
    ,nvl(T.ekgrp, '')		AS PurchasingGroup
    ,nvl(T.eknam, '')		AS BuyerName
    ,nvl(T.ektel, '')		AS PurchasingGroupTelNumber
	,nvl(T.SMTP_ADDR, '')	AS EmailAddress
    ,nvl(T.ldest, '')		AS Spool
    ,nvl(T.telfx, '')		AS PurchasingGroupFaxNumber
    ,nvl(T.tel_extens, '') AS PurchasingGroupTelExt
    ,nvl(T.tel_number, '') AS PurchasingGroupTelCodeNumber
	 
    ,T.SNFLK_UPDATEDON AS SrcLastModifiedDate
FROM 
	CONFORMED.ECC_HA_T024 T;
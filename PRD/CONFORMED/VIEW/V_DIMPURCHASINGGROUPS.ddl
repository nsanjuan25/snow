create or replace view V_DIMPURCHASINGGROUPS(
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

This view is used to insert data into v_DimCustomers
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-01      SRIDHAR                 Initial Revision
*/
SELECT 
	  DataSourceKey
    , PurchasingGroup
    , BuyerName
    , PurchasingGroupTelNumber
	, EmailAddress
    , Spool
    , PurchasingGroupFaxNumber
    , PurchasingGroupTelExt
    , PurchasingGroupTelCodeNumber
	 
    , SrcLastModifiedDate
FROM 
	CONFORMED.V_ECC_DimPurchasingGroups
UNION ALL	
SELECT 
	  DataSourceKey
    , PurchasingGroup
    , BuyerName
    , PurchasingGroupTelNumber
	, EmailAddress
    , Spool
    , PurchasingGroupFaxNumber
    , PurchasingGroupTelExt
    , PurchasingGroupTelCodeNumber
	 
    , SrcLastModifiedDate
FROM 
	CONFORMED.V_HCC_DimPurchasingGroups;
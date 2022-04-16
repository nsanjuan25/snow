create or replace view V_HCC_DIMCOMPANYORGANIZATIONS(
	COMPANYORGANIZATIONCODE,
	DATASOURCEKEY,
	GLOBALCOMPANYORGANIZATIONCODE,
	COMPANYORGANIZATIONNAME,
	COMPANYCODEVARIANT,
	ADDRESS,
	CREDITCONTROLAREA,
	CHAROFACCOUNTS,
	COUNTRY,
	CURRENCY,
	LANGUAGE,
	CITY,
	FISCALYEARVARIANT,
	SRCLASTMODIFIEDDATE
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into v_ECC_DimCompanyOrganizations
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-02     SRIDHAR                 Initial Revision            
*/         
SELECT     
      UPPER(RTRIM(NVL( bukrs      , '' )))  as  CompanyOrganizationCode
	, 2 as DATASOURCEKEY
    , UPPER(RTRIM(NVL( bukrs_glob , '' )))  as  GlobalCompanyOrganizationCode  
    , UPPER(RTRIM(NVL( butxt      , '' )))  as  CompanyOrganizationName 
    , UPPER(RTRIM(NVL( buvar      , '' )))  as  CompanyCodeVariant 
    , UPPER(RTRIM(NVL( adrnr      , '' )))  as  Address 
    , UPPER(RTRIM(NVL( kkber      , '' )))  as  CreditControlArea 
    , UPPER(RTRIM(NVL( ktopl      , '' )))  as  CharOfAccounts 
    , UPPER(RTRIM(NVL( land1      , '' )))  as  Country 
    , UPPER(RTRIM(NVL( waers      , '' )))  as  Currency 
    , UPPER(RTRIM(NVL( spras      , '' )))  as  Language 
    , UPPER(RTRIM(NVL( ort01      , '' )))  as  City 
    , UPPER(RTRIM(NVL( periv      , '' )))  as  FiscalYearVariant 
    
    , SNFLK_UpdatedOn    as  SrcLastModifiedDate 
FROM
    CONFORMED.HCC_HA_T001 AS T;
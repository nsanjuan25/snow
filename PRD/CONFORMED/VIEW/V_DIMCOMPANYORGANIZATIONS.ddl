create or replace view V_DIMCOMPANYORGANIZATIONS(
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

This view is used to insert data into v_DimCompanyOrganizations
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-02     SRIDHAR                 Initial Revision            
*/         
SELECT     
     COMPANYORGANIZATIONCODE 
	 ,DATASOURCEKEY
    ,GlobalCompanyOrganizationCode  
    ,CompanyOrganizationName 
    ,CompanyCodeVariant 
    ,Address 
    ,CreditControlArea 
    ,CharOfAccounts 
    ,Country 
    ,Currency 
    ,Language 
    ,City 
    ,FiscalYearVariant 
	,SrcLastModifiedDate 
FROM
    CONFORMED.v_HCC_DimCompanyOrganizations
UNION ALL
SELECT     
     COMPANYORGANIZATIONCODE 
	 ,DATASOURCEKEY
    ,GlobalCompanyOrganizationCode  
    ,CompanyOrganizationName 
    ,CompanyCodeVariant 
    ,Address 
    ,CreditControlArea 
    ,CharOfAccounts 
    ,Country 
    ,Currency 
    ,Language 
    ,City 
    ,FiscalYearVariant 
	,SrcLastModifiedDate 
FROM
    CONFORMED.v_ECC_DimCompanyOrganizations;
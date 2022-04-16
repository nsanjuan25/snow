create or replace view V_DIMSUPPLIERCOMPANIES(
	SUPPLIERCODE,
	CORPORATIONID,
	COMPANYORGANIZATIONCODE,
	SUPPLIERTYPECODE,
	SUPPLIERTYPE,
	SUPPLIERCONTRACT,
	VIAFLAG,
	DATASOURCEKEY,
	GLOBALSUPPLIERNAME,
	LOCALSUPPLIERNAME,
	LOCALSUPPLIERNAME2,
	LOCALSUPPLIERNAME3,
	LOCALSUPPLIERNAME4,
	ADDRESS1,
	CITY,
	STATEPROVINCE,
	COUNTRY,
	POSTALCODE,
	PAYMENTTERMS,
	ORGANIZATIONCODE,
	ORGANIZATIONTYPECODE,
	ACCOUNTINGSUPPLIERCODE,
	DELETEFLAG,
	MINORITYINDICATOR,
	MINORITYTEXT,
	CERTIFICATIONDATE,
	VENDORMASTERPAYMENTTERMS,
	VENDORCLASSIFICATION,
	SRCLASTMODIFIEDDATE,
	DUNSNUMBER
) as 
/* 
Description         : View used to populate No Consigned Historical Spend

Start Revision History            
-----------------------------------------------------------------------------------------------
Date         Developer           Revision Description
----------    --------------      -------------------------------------------------------------

2021-03-11	  Sridhar K	 InitialVersion
2021-09-16    Jagan P    Add JPS
2021-09-22    Jagan P    Add PLA
-----------------------------------------------------------------------------------------------
End   Revision   History
*/
select distinct * from  (

                        select * from CONFORMED.v_HCC_DimSupplierCompanies
                        union
                        select * from CONFORMED.v_ECC_DimSupplierCompanies
                        union
                        select * from CONFORMED.v_JPS_DimSupplierCompanies
                        union
                        select * from CONFORMED.v_PLA_DimSupplierCompanies
                        );
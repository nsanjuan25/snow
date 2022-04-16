create or replace view V_DIMMANUFACTURERS(
	DATASOURCEKEY,
	MANUFACTURERCODE,
	CORPORATIONID,
	MANUFACTURERTYPECODE,
	GLOBALMANUFACTURERNAME,
	LOCALMANUFACTURERNAME,
	LOCALMANUFACTURERNAME2,
	LOCALMANUFACTURERNAME3,
	LOCALMANUFACTURERNAME4,
	ADDRESS1,
	CITY,
	STATEPROVINCE,
	COUNTRY,
	POSTALCODE,
	PAYMENTTERMS,
	ORGANIZATIONCODE,
	ORGANIZATIONTYPECODE,
	ACCOUNTINGMANUFACTURERCODE,
	DELETEFLAG,
	MINORITYINDICATOR,
	MINORITYTEXT,
	CERTIFICATIONDATE,
	VENDORMASTERPAYMENTTERMS,
	VENDORCLASSIFICATION,
	DUNSNUMBER,
	RN
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimManufacturers
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-19      Juan Cedeno             Initial Revision
2021-07-14      Jagan                   Add JPS
2021-09-22      Jagan                   Add PLA
*/          
SELECT 
    *
FROM
    (
      SELECT 
	         1 as DATASOURCEKEY                    
           , ManufacturerCode
           , CorporationID
           , ManufacturerTypeCode
           , GlobalManufacturerName
           , LocalManufacturerName
           , LocalManufacturerName2  
           , LocalManufacturerName3  
           , LocalManufacturerName4    
           , Address1 
           , City
           , StateProvince
           , Country
           , PostalCode
           , PaymentTerms
           , OrganizationCode
           , OrganizationTypeCode
           , AccountingManufacturerCode                        
           , DeleteFlag
           , MinorityIndicator
           , MinorityText
           , CertificationDate
           , VendorMasterPaymentTerms
           , VendorClassification  
           , DUNSNumber         
           , row_number() over(partition by  ManufacturerCode order by ManufacturerCode) rn
      FROM   
	         conformed.v_ecc_ha_DimManufacturers

      UNION ALL 

      SELECT 
	         2 as DATASOURCEKEY
           , ManufacturerCode
           , CorporationID
           , ManufacturerTypeCode
           , GlobalManufacturerName
           , LocalManufacturerName
           , LocalManufacturerName2  
           , LocalManufacturerName3  
           , LocalManufacturerName4    
           , Address1 
           , City
           , StateProvince
           , Country
           , PostalCode
           , PaymentTerms
           , OrganizationCode
           , OrganizationTypeCode
           , AccountingManufacturerCode                        
           , DeleteFlag
           , MinorityIndicator
           , MinorityText
           , CertificationDate
           , VendorMasterPaymentTerms
           , VendorClassification  
           , DUNSNumber                                  
           , row_number() over(partition by  ManufacturerCode order by ManufacturerCode) rn
      FROM   conformed.v_hcc_ha_DimManufacturers 
	  
	  UNION ALL
	  
      SELECT 
	         5 as DATASOURCEKEY                    
           , ManufacturerCode
           , CorporationID
           , ManufacturerTypeCode
           , GlobalManufacturerName
           , LocalManufacturerName
           , LocalManufacturerName2  
           , LocalManufacturerName3  
           , LocalManufacturerName4    
           , Address1 
           , City
           , StateProvince
           , Country
           , PostalCode
           , PaymentTerms
           , OrganizationCode
           , OrganizationTypeCode
           , AccountingManufacturerCode                        
           , DeleteFlag
           , MinorityIndicator
           , MinorityText
           , CertificationDate
           , VendorMasterPaymentTerms
           , VendorClassification  
           , DUNSNumber         
           , row_number() over(partition by  ManufacturerCode order by ManufacturerCode) rn
      FROM   
	         conformed.v_jps_ha_DimManufacturers

	  UNION ALL
	  
      SELECT 
	         4 as DATASOURCEKEY                    
           , ManufacturerCode
           , CorporationID
           , ManufacturerTypeCode
           , GlobalManufacturerName
           , LocalManufacturerName
           , LocalManufacturerName2  
           , LocalManufacturerName3  
           , LocalManufacturerName4    
           , Address1 
           , City
           , StateProvince
           , Country
           , PostalCode
           , PaymentTerms
           , OrganizationCode
           , OrganizationTypeCode
           , AccountingManufacturerCode                        
           , DeleteFlag
           , MinorityIndicator
           , MinorityText
           , CertificationDate
           , VendorMasterPaymentTerms
           , VendorClassification  
           , DUNSNumber         
           , row_number() over(partition by  ManufacturerCode order by ManufacturerCode) rn
      FROM   
	         conformed.v_pla_ha_DimManufacturers

)Q
WHERE 
      Q.rn = 1;
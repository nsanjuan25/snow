create or replace view V_DIMBUYERS(
	DATASOURCEKEY,
	BUYERCODE,
	PHONE1,
	FAX,
	EMAILADDRESS,
	LASTNAME,
	FIRSTNAME,
	TITLE,
	PHONE2,
	PAGER,
	URL,
	ADDRESS1,
	ADDRESS2,
	ADDRESS3,
	CITY,
	STATE,
	ZIP,
	COUNTRY,
	REGION,
	IMACIPO,
	FRMW_EXTRACTED_ON,
	RN
) as
/*----------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimBuyers
------------------------------------------------------------------------------------------
Revision History
------------------------------------------------------------------------------------------
Date            Developer               Comments
------------------------------------------------------------------------------------------
2021-02-10      Venkata             Initial Revision
2021-07-13      Jagan               Add JPS
2021-09-22      Jagan               Add PLA
*/
SELECT 
    *
FROM
    (
      SELECT 
	       1 as DataSourceKey
           , BuyerCode
           , phone1
           , fax
           , emailaddress
           , LastName
           , FirstName        
           , Title
           , Phone2
           , Pager
           , URL
           , Address1
           , Address2
           , Address3
           , City
           , State
           , Zip
           , Country
           , Region
           , ImacIPO  
           , frmw_extracted_on
           , row_number() over(partition by buyercode order by buyercode ) as rn
      FROM   
	         conformed.V_ecc_ha_DIMBUYERS a 
      
      union all

      SELECT 
	       2 as DataSourceKey
           , BuyerCode
           , phone1
           , fax
           , emailaddress
           , LastName
           , FirstName        
           , Title
           , Phone2
           , Pager
           , URL
           , Address1
           , Address2
           , Address3
           , City
           , State
           , Zip
           , Country
           , Region
           , ImacIPO  
           , frmw_extracted_on 
           , row_number() over(partition by buyercode order by buyercode ) as rn
      FROM   
	         conformed.V_hcc_ha_DIMBUYERS a  

	  union all

      SELECT 
	       5 as DataSourceKey
           , BuyerCode
           , phone1
           , fax
           , emailaddress
           , LastName
           , FirstName        
           , Title
           , Phone2
           , Pager
           , URL
           , Address1
           , Address2
           , Address3
           , City
           , State
           , Zip
           , Country
           , Region
           , ImacIPO  
           , frmw_extracted_on
           , row_number() over(partition by buyercode order by buyercode ) as rn
      FROM   
	         conformed.V_jps_ha_DIMBUYERS a 
	  union all

      SELECT 
	       4 as DataSourceKey
           , BuyerCode
           , phone1
           , fax
           , emailaddress
           , LastName
           , FirstName        
           , Title
           , Phone2
           , Pager
           , URL
           , Address1
           , Address2
           , Address3
           , City
           , State
           , Zip
           , Country
           , Region
           , ImacIPO  
           , frmw_extracted_on
           , row_number() over(partition by buyercode order by buyercode ) as rn
      FROM   
	         conformed.V_pla_ha_DIMBUYERS a 			 
) q
      WHERE  
	        q.rn = 1;
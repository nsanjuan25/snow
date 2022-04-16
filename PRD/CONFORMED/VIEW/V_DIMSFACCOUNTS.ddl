create or replace view V_DIMSFACCOUNTS(
	SYSTEMMODSTAMP,
	RECORDTYPE_NAME,
	OWNER_NAME,
	ACCOUNTNAME,
	LASTMODIFIEDDATE,
	LASTMODIFIEDBY_NAME,
	ACCOUNTSRCID,
	CREATEDDATE,
	CREATEDBY_NAME,
	VISIBILITY_WITH_OPPORTUNITIES,
	VISIBILITY,
	TARGET,
	SUB_SEGMENT,
	SUB_SECTOR,
	ACCOUNTSTATUS,
	SEGMENT,
	SECTORSHORTNAME,
	SECTORNAME,
	SALES_LEAD_NAME,
	SALESGROUP,
	RECENT_OPPORTUNITIES,
	PRIORITY,
	PARENTID,
	PARENT_NAME,
	PARENT_ACCOUNT_NAME,
	OWNERID,
	LASTACTIVITYDATE,
	LAST_OPPY,
	HEADQUARTERS_LOCATION,
	DIVISIONNAME,
	DESCRIPTION,
	BUSINESS_LEAD_CONTACT_LOOKUP_NAME,
	BUSINESS_GROUP,
	ANNUALREVENUE,
	ACCOUNT_TYPE,
	ACCOUNT_RELATIONSHIP,
	FRMW_EXTRACTED_ON,
	SNFLK_UPDATEDON
) as
SELECT
    SystemModStamp                 
   ,RecordType_Name                
   ,Owner_Name                     
   ,UPPER( IFNULL( LTRIM(RTRIM( A.name )) , '' ))          AS  AccountName
   ,LastModifiedDate               
   ,LastModifiedBy_Name            
   ,RTRIM(A.id)                                            AS  AccountSrcID
   ,CreatedDate                    
   ,CreatedBy_Name                 
   ,Visibility_With_Opportunities  
   ,Visibility                     
   ,Target                         
   ,Sub_Segment                    
   ,Sub_Sector                     
   ,UPPER( IFNULL( RTRIM( A.status ), '' ))                AS  AccountStatus
   ,Segment                        
   ,UPPER( IFNULL( RTRIM( A.sector_short ), '' ))          AS  SectorShortName
   ,UPPER( IFNULL( RTRIM( A.sector ), '' ))                AS  SectorName
   ,Sales_Lead_Name                
   ,UPPER( IFNULL( RTRIM( A.sales_group ), '' ))           AS  SalesGroup
   ,Recent_Opportunities           
   ,Priority                       
   ,ParentId                       
   ,Parent_Name                    
   ,Parent_Account_Name            
   ,OwnerId                        
   ,LastActivityDate               
   ,Last_Oppy                      
   ,Headquarters_Location          
   ,UPPER( IFNULL( RTRIM( A.division ), '' ))               AS  DivisionName
   ,Description                    
   ,Business_Lead_Contact_Lookup_Name  
   ,Business_Group                     
   ,AnnualRevenue                      
   ,Account_Type                       
   ,Account_Relationship               
   ,frmw_extracted_on                  
   ,SNFLK_UPDATEDON                    
from   conformed.SF_Account AS A;
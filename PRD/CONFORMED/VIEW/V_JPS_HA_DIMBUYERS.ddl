create or replace view V_JPS_HA_DIMBUYERS(
	BUYERCODE,
	PHONE1,
	FAX,
	EMAILADDRESS,
	CONTACTID,
	CONTACTNAME,
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
	FRMW_EXTRACTED_ON
) as
/*-------------------------------------------------------------------------------------------
This view is used to insert data into SAP.DIMAML
---------------------------------------------------------------------------------------------
Revision History
---------------------------------------------------------------------------------------------
Date            Developer               Comments
---------------------------------------------------------------------------------------------
2021-07-12      Jagan                   Initial Revision
*/
SELECT 
       COALESCE(a.ekgrp,'')                                                    as BuyerCode
     , COALESCE(case 
	                when a.ektel = '' then a.tel_number                       
	                                  else a.ektel                            
	  	        end , c.phone1,'')                                             as phone1
     , COALESCE(a.telfx, c.Fax ,'')                                            as fax
     , COALESCE( a.smtp_addr , c.EmailAddress  ,'')                            as emailaddress 
     , COALESCE(Buyer.ContactID,0)						                       as ContactID 
     , COALESCE(a.eknam,'')                                                    as contactname        
     , COALESCE(substring( a.eknam , charindex( ' ' , a.eknam, 1)+1 ) , '' )   as LastName
     , COALESCE(substring( a.eknam , 1 , charindex( ' ' , a.eknam )   ) , '' ) as FirstName
     , COALESCE(c.Title,'')							                           as Title
	 , COALESCE(c.Phone2,'')							                       as Phone2
	 , COALESCE(c.Pager,'')							                           as Pager
	 , COALESCE(c.Url,'')								                       as URL
	 , COALESCE(c.Address1,'')							                       as Address1
	 , COALESCE(c.Address2,'')							                       as Address2
	 , COALESCE(c.Address3,'')							                       as Address3
	 , COALESCE(c.City,'')								                       as City
	 , COALESCE(c.State,'')							                           as State
	 , COALESCE(c.Zip,'')								                       as Zip
	 , COALESCE(c.Country,'')							                       as Country
	 , COALESCE(c.Region,'')							                       as Region
--   , IFF(pg.ekgrp IS NOT NULL ,'TRUE', 'FALSE')                              as ImacIPO
     , 'FALSE'                                                                 as ImacIPO
     , a.frmw_extracted_on                                                     as frmw_extracted_on
FROM   
       conformed.JPS_HA_T024 a
LEFT OUTER JOIN 
       conformed.scmdb_buyercode Buyer 
          ON  TRIM(a.ekgrp) = Buyer.BuyerCode
          AND Buyer.DataSourceId = 6
LEFT OUTER JOIN 
       conformed.scmdb_contact c 
          ON Buyer.ContactID = c.ContactID        
/*
LEFT OUTER JOIN 
       conformed.jps_ha_ZMM_PU_GROUP PG  
          ON pg.ekgrp = Buyer.BuyerCode
*/
;
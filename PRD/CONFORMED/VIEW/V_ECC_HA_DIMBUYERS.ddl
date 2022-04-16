create or replace view V_ECC_HA_DIMBUYERS(
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
/*-------------------------------------------------------------------------------------------------
This view is used to insert data into SAP.DIMAML
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-10      Venkata             Initial Revision
  */
SELECT 
          ifnull(a.ekgrp,'')                  as BuyerCode
        , ifnull(case when a.ektel = '' then a.tel_number else a.ektel end , ifnull(c.phone1,'') )  as phone1
        , ifnull( ifnull(a.telfx, c.Fax) ,'')             as fax
        , ifnull( ifnull(a.smtp_addr , c.EmailAddress ) ,'')         as emailaddress 
        , IFNULL(Buyer.ContactID,0)						 ContactID 
        , ifnull(a.eknam,'')             as contactname        
        
        , CASE 
            WHEN ifNULL(c.LastName,'') ='' THEN LEFT(rtrim(substring(a.eknam,charindex(' ',trim(a.eknam),1)+1,40)),20) 
            ELSE IfNULL(c.LastName,'')
          END AS LastName
        , CASE 
            WHEN IfNULL(c.FirstName,'') = '' THEN RTRIM(substring(a.eknam,1,charindex(' ',trim(a.eknam),1))) 
            ELSE IfNULL(c.FirstName,'') 
            END  AS FirstName
        --, ifnull(substring( a.eknam , charindex( ' ' , a.eknam, 1)+1 ) , '' ) as LastName
        --, ifnull(substring( a.eknam , 1 , charindex( ' ' , a.eknam )   ) , '' ) as FirstName        
        , IFNULL(c.Title,'')								 Title
		, IFNULL(c.Phone2,'')								 Phone2
		, IFNULL(c.Pager,'')								 Pager
		, IFNULL(c.Url,'')									 URL
		, IFNULL(c.Address1,'')								 Address1
		, IFNULL(c.Address2,'')								 Address2
		, IFNULL(c.Address3,'')								 Address3
		, IFNULL(c.City,'')									 City
		, IFNULL(c.State,'')								 State
		, IFNULL(c.Zip,'')									 Zip
		, IFNULL(c.Country,'')								 Country
		, IFNULL(c.Region,'')								 Region
        , IFF(pg.ekgrp IS NOT NULL ,'TRUE', 'FALSE')     AS    ImacIPO
        , a.frmw_extracted_on 
FROM
    conformed.ecc_ha_t024 a
    left outer join conformed.scmdb_buyercode Buyer 
        on LTRIM(RTRIM(a.ekgrp)) = Buyer.BuyerCode
        AND Buyer.DataSourceId = 6
    LEFT OUTER JOIN conformed.scmdb_contact c 
        ON Buyer.ContactID = c.ContactID        
    LEFT OUTER JOIN conformed.ecc_ha_ZMM_PU_GROUP PG  
        ON pg.ekgrp = Buyer.BuyerCode;
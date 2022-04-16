create or replace view V_HCC_HA_DIMBUYERS(
	BUYERCODE,
	PHONE1,
	FAX,
	EMAILADDRESS,
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
        ifnull(a.ekgrp,'')                  as BuyerCode,
        ifnull(case when a.ektel = '' then a.tel_number else a.ektel end , '')  as phone1,
        ifnull( a.telfx ,'')             as fax,        
        ifnull(a.smtp_addr ,'')         as emailaddress ,
        ifnull(a.eknam,'')             as contactname        
        , ifnull(substring( a.eknam , charindex( ' ' , trim(a.eknam), 1)+1 ) , '' ) as LastName
        , ifnull(substring( a.eknam , 1 , charindex( ' ' , trim(a.eknam) )   ) , '' ) as FirstName
        
        , '' Title
		, '' Phone2
		, '' Pager
		, '' URL
		, '' Address1
		, '' Address2
		, '' Address3
		, '' City
		, '' State
		, '' Zip
		, '' Country
		, ''			Region
        , 'FALSE'     AS    ImacIPO
        , frmw_extracted_on
FROM
    conformed.hcc_ha_t024 a;
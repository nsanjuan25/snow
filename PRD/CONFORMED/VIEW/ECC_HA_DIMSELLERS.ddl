create or replace view ECC_HA_DIMSELLERS(
	SELLERNAME,
	LASTNAME,
	FIRSTNAME,
	TITLE,
	PHONE1,
	PHONE2,
	PAGER,
	EMAILADDRESS,
	FAX,
	UNIVERSALRESOURCELOCATOR,
	ADDRESS1,
	ADDRESS2,
	ADDRESS3,
	CITY,
	STATE,
	ZIP,
	COUNTRY,
	REGION,
	DELETEFLAG,
	SRCLASTMODIFIEDDATE,
	DUNSNUMBER
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to do the ADD data to DIMEXCHANGERATES
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-24      Venkata         Initial Revision
  */
SELECT
    trim(ifnull(C.ContactName,'')) AS	SellerName  
  , IfNULL(C.LastName,'') LastName
  , IfNULL(C.FirstName,'') FirstName
  , IfNULL(C.Title,'') Title
  , trim(IfNULL(LTRIM(RTRIM(C.Phone1)),'')) Phone1
  , IfNULL(LTRIM(RTRIM(C.Phone2)),'') Phone2
  , IfNULL(C.Pager,'') Pager
  , IfNULL(C.EmailAddress,'') EmailAddress
  , IfNULL(C.Fax,'') Fax
  , IfNULL(C.Url,'') UniversalResourceLocator
  , IfNULL(C.Address1,'') Address1
  , IfNULL(C.Address2,'') Address2
  , IfNULL(C.Address3,'') Address3
  , IfNULL(C.City,'') City
  , IfNULL(C.State,'') State
  , IfNULL(C.Zip,'') Zip
  , IfNULL(C.Country,'') Country
  , IfNULL(C.Region,'') Region
  , C.DeleteFlag
  , C.CreateDTS SrcLastModifiedDate
  , IfNULL(DS.DUNSNumber, '') AS DUNSNumber
FROM
    conformed.ecc_ha_ekko h
    inner join conformed.scmdb_contact c 
        ON upper(LTRIM(RTRIM(H.verkf))) = upper(LTRIM(RTRIM(C.ContactName)) )
        AND (
                upper(LTRIM(RTRIM(H.telf1))) = upper(LTRIM(RTRIM(C.Phone1)) )
             OR upper(LTRIM(RTRIM(H.telf1))) = upper(LTRIM(RTRIM(C.Phone2)))
            )
    INNER JOIN conformed.scmdb_corporationds ds
    	ON H.lifnr = DS.CorporationDSCode
    INNER JOIN conformed.scmdb_CorporationDSToOrganizationContact CO
        ON DS.CorporationDSId = CO.CorporationDSId 
        AND C.ContactID = CO.ContactId
	WHERE 
		CO.ContactTypeId = 4;
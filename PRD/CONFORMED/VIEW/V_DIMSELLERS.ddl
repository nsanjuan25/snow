create or replace view V_DIMSELLERS(
	DATASOURCEKEY,
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
	DUNSNUMBER,
	RN
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to do the ADD data to DIMEXCHANGERATES
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-24      Venkata         Initial Revision
                                This view only gets data for datasource 1 since it is from SCMDB
  */
SELECT 
    *
FROM
    (
        SELECT 
            1 AS DataSourceKey
          , SELLERNAME
          , LASTNAME
          , FIRSTNAME
          , TITLE
          , PHONE1
          , PHONE2
          , PAGER
          , EMAILADDRESS
          , FAX
          , UNIVERSALRESOURCELOCATOR
          , ADDRESS1
          , ADDRESS2
          , ADDRESS3
          , CITY
          , STATE
          , ZIP
          , COUNTRY
          , REGION
          , DELETEFLAG
          , SRCLASTMODIFIEDDATE
          , DUNSNUMBER
          , row_number() over(partition by SELLERNAME, PHONE1 order by SELLERNAME ) rn 
        FROM 
            conformed.ecc_ha_DimSellers
    ) q
WHERE
    q.rn = 1;
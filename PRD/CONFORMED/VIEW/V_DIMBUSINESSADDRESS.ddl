create or replace view V_DIMBUSINESSADDRESS(
	DATASOURCEKEY,
	ADDRESSCODE,
	BUSINESSNAME,
	STREET,
	CITY,
	COUNTRY,
	FAXNUMBER,
	POSTALCODE,
	TELEPHONENUMBER,
	TIMEZONE,
	COUNTRYDESCRIPTION,
	BUSINESSID,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.DIMBUSINESSADDRESS table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision
*/
SELECT
    1										AS DataSourceKey,
	LTRIM(RTRIM(IFNULL(a.addrnumber,'')))	AS AddressCode,
    LTRIM(RTRIM(IFNULL(a.name1,'')))		AS BusinessName,
    LTRIM(RTRIM(IFNULL(a.street,'')))		AS Street,
    LTRIM(RTRIM(IFNULL(a.city1,'')))		AS City,
    LTRIM(RTRIM(IFNULL(a.country,'')))		AS Country,
    LTRIM(RTRIM(IFNULL(a.fax_number,'')))	AS FaxNumber,
    LTRIM(RTRIM(IFNULL(a.post_code1,'')))	AS PostalCode,
    LTRIM(RTRIM(IFNULL(a.tel_number,'')))	AS TelephoneNumber,
    LTRIM(RTRIM(IFNULL(a.time_zone,'')))	AS TimeZone,
    LTRIM(RTRIM(IFNULL(a.CountryDescription,''))) AS CountryDescription,
	LTRIM(RTRIM(IFNULL(a.name_co,'')))		AS BusinessID,
    HASH
    ( 
        LTRIM(RTRIM(IFNULL(a.addrnumber,''))),
		LTRIM(RTRIM(IFNULL(a.name1,''))),
		LTRIM(RTRIM(IFNULL(a.street,''))),
		LTRIM(RTRIM(IFNULL(a.city1,''))),
		LTRIM(RTRIM(IFNULL(a.country,''))),
		LTRIM(RTRIM(IFNULL(a.fax_number,''))),
		LTRIM(RTRIM(IFNULL(a.post_code1,''))),
		LTRIM(RTRIM(IFNULL(a.tel_number,''))),
		LTRIM(RTRIM(IFNULL(a.time_zone,''))),
		LTRIM(RTRIM(IFNULL(a.CountryDescription,''))),
		LTRIM(RTRIM(IFNULL(a.name_co, '')))
    ) AS HASH_VALUE
FROM 
(
	SELECT 
		ADRC.client,
		ADRC.ADDRNUMBER,
		ADRC.name1,
		ADRC.street,
		ADRC.City1,
		ADRC.Country,
		T005T.landx AS CountryDescription,
		ADRC.fax_number,
		ADRC.post_code1,
		ADRC.tel_number,
		ADRC.time_zone,
		ADRC.name_co,
		ROW_NUMBER() OVER
		(
			PARTITION BY 
				ADRC.ADDRNUMBER
			ORDER BY 
				ADRC.SEQGEN DESC 
		) as rownum
	FROM 
		CONFORMED.ECC_HA_ADRC as ADRC
		INNER JOIN CONFORMED.ECC_HA_VBPA as VBAP ON ADRC.ADDRNUMBER = VBAP.ADRNR
			AND  VBAP.PARVW IN ('WE' , 'ZB', 'SP')
		LEFT OUTER JOIN CONFORMED.ECC_HA_T005T AS T005T ON VBAP.Land1 = T005T.Land1
			AND T005T.SPRAS = 'E'
) a
WHERE 
    a.rownum = 1;
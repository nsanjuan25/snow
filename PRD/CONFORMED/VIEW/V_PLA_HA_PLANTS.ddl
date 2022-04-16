create or replace view V_PLA_HA_PLANTS(
	PLANTCODE,
	PLANTNAMESHORT,
	PLANTNAMELONG,
	PLANTTYPECODE,
	CITY,
	STATEPROVINCE,
	COUNTRY,
	SALESORGANIZATIONCODE,
	PURCHASINGORGANIZATIONCODE,
	COMPANYORGANIZATIONCODE,
	LOCALCURRENCYCODE,
	MATERIALLEDGERACTIVEFLAG,
	BOMRTGEXPLOSIONDATE,
	CRCYTYPE1,
	EXCHANGERATE1,
	SOURCECURRENCY1,
	TRANSLTNDATE1,
	CRCYTYPE2,
	EXCHANGERATE2,
	SOURCECURRENCY2,
	TRANSLTNDATE2,
	JDB_STATUS,
	EXCHANGERATE,
	REGIONCODE,
	REGIONDESCRIPTION,
	CAMPUSCODE,
	CAMPUSDESCRIPTION,
	CAMPUSKEY,
	UPDATED_ON
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimPlants
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-09-22      Jagan                  Initial Revision
*/
SELECT 
       t001w.werks  as PlantCode
     , t001w.werks  as PlantNameShort
     , t001w.name1  as PlantNameLong
     , 'JABIL MFG'  as PlantTypeCode
     , t001w.ort01  as City
     , t001w.regio  as StateProvince
     , t001w.land1  as Country
     , t001w.vkorg  as SalesOrganizationCode
     , t001w.ekorg  as PurchasingOrganizationCode
     , t001k.bukrs  as CompanyOrganizationCode
     , t001.waers   as LocalCurrencyCode
     , case when t001k.mlbwa = 'X' then 'TRUE' ELSE 'FALSE' END  as MaterialLedgerActiveFlag
     , t399d.besal  as BOMRtgExplosionDate
     , t001a.curtp  as CrcyType1
     , t001a.kurst  as ExchangeRate1
     , t001a.cursr  as SourceCurrency1
     , t001a.curdt  as TransltnDate1
     , t001a.curtp2 as CrcyType2
     , t001a.kurst2 as ExchangeRate2
     , t001a.cursr2 as SourceCurrency2
     , t001a.curdt2 as TransltnDate2
     , CASE Site.sitestatus
            WHEN 0 THEN 'DISABLED'
            WHEN 1 THEN 'ACTIVE'
            WHEN 2 THEN 'HISTORICAL'
            ELSE ''
       END AS JDB_Status
     , ce.ExchangeRate
     , IFNULL(cr.regioncode, 'UNDF') AS regioncode
     , IFNULL(cr.regionname, 'UNDF') AS regionDescription
     , IFNULL(cr.campuscode, 'UNDF') AS campuscode
     , IFNULL(cr.campusname, 'UNDF') AS campusDescription 
     , DC.CampusKey
     , current_timestamp as updated_on
from 
     conformed.PLA_ha_t001w t001w
LEFT OUTER JOIN  
     conformed.PLA_ha_t001k t001k
         on  t001w.werks = t001k.bwkey
LEFT OUTER JOIN  
     conformed.PLA_ha_t001 t001
         on  t001k.bukrs = t001.bukrs
LEFT OUTER JOIN 
     conformed.PLA_ha_t399d t399d
         on t001w.werks = t399d.werks
LEFT OUTER JOIN 
     conformed.PLA_ha_t001a t001a
         on t001K.bukrs = t001a.bukrs
LEFT OUTER JOIN 
     conformed.scmdb_site site 
         on t001w.werks = site.sitecode  
LEFT OUTER JOIN 
     SAP.v_CurrenctExchangeRate ce
         on  t001.waers = ce.CurrencyCode   
         and ce.datasourcekey = 4
LEFT OUTER JOIN 
     conformed.v_scmdb_CampusRegion  cr
         ON site.siteid = cr.siteid
LEFT OUTER JOIN 
     sap.DimCampus DC 
         ON IFNULL(cr.campuscode, 'UNDF') = DC.CampusCode;
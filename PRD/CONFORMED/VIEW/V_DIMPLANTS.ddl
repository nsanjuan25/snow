create or replace view V_DIMPLANTS(
	DATASOURCEKEY,
	RN,
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
2021-02-15      Juan Cedeno             Initial Revision
2021-07-14      Jagan                   Add JPS
2021-09-22      Jagan                   Add PLA
*/
SELECT 
    * 
FROM
(
    SELECT 
	       1 as DataSourceKey
         , row_number() over ( partition by PlantCode order by PlantCode ) rn
         , PlantCode
         , PlantNameShort
         , PlantNameLong
         , PlantTypeCode
         , City
         , StateProvince
         , Country
         , SalesOrganizationCode
         , PurchasingOrganizationCode
         , CompanyOrganizationCode
         , LocalCurrencyCode
         , MaterialLedgerActiveFlag
         , BOMRtgExplosionDate
         , CrcyType1
         , ExchangeRate1
         , SourceCurrency1
         , TransltnDate1
         , CrcyType2
         , ExchangeRate2
         , SourceCurrency2
         , TransltnDate2  
         , JDB_Status
         , ExchangeRate
         , regioncode
         , regiondescription
         , campuscode
         , campusdescription   
         , CampusKey
         , updated_on
    FROM   
	       conformed.v_ecc_ha_Plants

    UNION ALL 

    SELECT 
	       2 as DataSourceKey  
         , row_number() over ( partition by PlantCode order by PlantCode ) rn
         , PlantCode
         , PlantNameShort
         , PlantNameLong
         , PlantTypeCode
         , City
         , StateProvince
         , Country
         , SalesOrganizationCode
         , PurchasingOrganizationCode
         , CompanyOrganizationCode
         , LocalCurrencyCode
         , MaterialLedgerActiveFlag
         , BOMRtgExplosionDate
         , CrcyType1
         , ExchangeRate1
         , SourceCurrency1
         , TransltnDate1
         , CrcyType2
         , ExchangeRate2
         , SourceCurrency2
         , TransltnDate2
         , JDB_Status
         , ExchangeRate
         , regioncode
         , regiondescription
         , campuscode
         , campusdescription     
         , CampusKey
         , updated_on  
    FROM   
	       conformed.v_hcc_ha_Plants
		
	UNION ALL
	
    SELECT 
	       5 as DataSourceKey
         , row_number() over ( partition by PlantCode order by PlantCode ) rn
         , PlantCode
         , PlantNameShort
         , PlantNameLong
         , PlantTypeCode
         , City
         , StateProvince
         , Country
         , SalesOrganizationCode
         , PurchasingOrganizationCode
         , CompanyOrganizationCode
         , LocalCurrencyCode
         , MaterialLedgerActiveFlag
         , BOMRtgExplosionDate
         , CrcyType1
         , ExchangeRate1
         , SourceCurrency1
         , TransltnDate1
         , CrcyType2
         , ExchangeRate2
         , SourceCurrency2
         , TransltnDate2  
         , JDB_Status
         , ExchangeRate
         , regioncode
         , regiondescription
         , campuscode
         , campusdescription   
         , CampusKey
         , updated_on
    FROM   
	       conformed.v_jps_ha_Plants
		
	UNION ALL
	
    SELECT 
	       4 as DataSourceKey
         , row_number() over ( partition by PlantCode order by PlantCode ) rn
         , PlantCode
         , PlantNameShort
         , PlantNameLong
         , PlantTypeCode
         , City
         , StateProvince
         , Country
         , SalesOrganizationCode
         , PurchasingOrganizationCode
         , CompanyOrganizationCode
         , LocalCurrencyCode
         , MaterialLedgerActiveFlag
         , BOMRtgExplosionDate
         , CrcyType1
         , ExchangeRate1
         , SourceCurrency1
         , TransltnDate1
         , CrcyType2
         , ExchangeRate2
         , SourceCurrency2
         , TransltnDate2  
         , JDB_Status
         , ExchangeRate
         , regioncode
         , regiondescription
         , campuscode
         , campusdescription   
         , CampusKey
         , updated_on
    FROM   
	       conformed.v_pla_ha_Plants

) a
WHERE 
       rn = 1;
create or replace view V_DIMAML(
	DATASOURCEKEY,
	PLANTKEY,
	MANUFACTURERKEY,
	MANUFACTURERPARTKEY,
	MATERIALKEY,
	MATERIALCODE,
	AMLREFERENCE,
	LOCALMANUFACTURERNAME,
	MANUFACTURERPARTCODE,
	PLANTCODE,
	EFFECTIVEFROMDATEKEY,
	EFFECTIVETODATEKEY,
	REVISIONLEVEL,
	AMLSTATUSCODE,
	DELETEFLAG,
	DSCREATEDON,
	DSCREATEDBY,
	MEDIACODE,
	MANUFACTURERPARTCODEMASKED,
	AMLSTATUSDESCRIPTION,
	AMLSTATUSSTANDARDCODE,
	AMLSEQUENCE,
	SRCLASTMODIFIEDDATE,
	PLSAMLSTATUSSTANDARDCODE,
	RN
) as
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMAML
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-01-28      Venkata             Initial Revision
2021-07-12      Jagan               Add JPS
*/
SELECT 
   *
FROM
(

    SELECT  
          1 as DataSourceKey
        , PlantKey
        , ManufacturerKey
        , ManufacturerPartKey
        , MaterialKey		
        , MaterialCode
		, AMLReference
        , LocalManufacturerName
        , MANUFACTURERPARTCODE
        , PlantCode
        , EffectiveFromDateKey  
        , EffectiveToDateKey
        , RevisionLevel
        , AMLStatusCode
        , DeleteFlag
        , DSCREATEDON
        , DSCREATEDBY
        , MediaCode
        , MANUFACTURERPARTCODEMASKED
        , AMLStatusDescription 
		, AMLStatusStandardCode
        , AMLSequence
        , SrcLastModifiedDate
        , PLSAMLStatusStandardCode  
        , row_number() over ( partition by amlreference, PlantKey order by deleteflag desc, DSCREATEDON desc, AMLSequence desc) rn
    FROM 
        conformed.v_ecc_ha_DimAml
  
    UNION ALL 

    SELECT
          2 as DataSourceKey
        , PlantKey
        , ManufacturerKey
        , ManufacturerPartKey
        , MaterialKey		
        , MaterialCode
		, AMLReference
        , LocalManufacturerName
        , MANUFACTURERPARTCODE
        , PlantCode
        , EffectiveFromDateKey  
        , EffectiveToDateKey
        , RevisionLevel
        , AMLStatusCode
        , DeleteFlag
        , DSCREATEDON
        , DSCREATEDBY
        , MediaCode
        , MANUFACTURERPARTCODEMASKED
        , AMLStatusDescription 
		, AMLStatusStandardCode
        , AMLSequence
        , SrcLastModifiedDate
        , PLSAMLStatusStandardCode  
        , row_number() over ( partition by amlreference, PlantKey order by deleteflag desc, DSCREATEDON desc, AMLSequence desc) rn
    FROM
        conformed.v_hcc_ha_DimAml  

	UNION ALL
	
	SELECT  
          5 as DataSourceKey
        , PlantKey
        , ManufacturerKey
        , ManufacturerPartKey
        , MaterialKey		
        , MaterialCode
		, AMLReference
        , LocalManufacturerName
        , MANUFACTURERPARTCODE
        , PlantCode
        , EffectiveFromDateKey  
        , EffectiveToDateKey
        , RevisionLevel
        , AMLStatusCode
        , DeleteFlag
        , DSCREATEDON
        , DSCREATEDBY
        , MediaCode
        , MANUFACTURERPARTCODEMASKED
        , AMLStatusDescription 
		, AMLStatusStandardCode
        , AMLSequence
        , SrcLastModifiedDate
        , PLSAMLStatusStandardCode  
        , row_number() over ( partition by amlreference, PlantKey order by deleteflag desc, DSCREATEDON desc, AMLSequence desc) rn
    FROM 
        conformed.v_jps_ha_Dimaml
) q
WHERE
    q.rn = 1;
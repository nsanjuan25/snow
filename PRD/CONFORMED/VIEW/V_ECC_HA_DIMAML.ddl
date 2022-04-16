create or replace view V_ECC_HA_DIMAML(
	PLANTKEY,
	MANUFACTURERKEY,
	MATERIALKEY,
	MANUFACTURERPARTKEY,
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
	PLSAMLSTATUSSTANDARDCODE
) as
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMAML
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-01-28      Venkata             Initial Revision
*/  
SELECT 
          IFNULL( P.PlantKey        , 0 )   AS PlantKey
        , IFNULL( M.ManufacturerKey , 0 )   AS ManufacturerKey
        , IFNULL( PP.MaterialKey    , 0 )   AS MaterialKey		
        , ifnull( mp.ManufacturerPartKey, 0 ) as ManufacturerPartKey
        , LTRIM( ifnull( a.bmatn, '') )     as MaterialCode
		, ifnull(a.ematn,'')                AS AMLReference
        , ifnull(a.mfrnr, '')               as LocalManufacturerName
        --, ifnull(a.zzmfrpn, '')             as MANUFACTURERPARTCODE
        , ifnull(ltrim( rtrim( REPLACE(REPLACE(REPLACE(a.zzmfrpn , ' ', '*^'), '^*', ''), '*^', ' ') )), '')             as MANUFACTURERPARTCODE
        , ifnull(a.werks , '')  as PlantCode
        , ifnull(TRY_TO_DATE( a.datuv , 'YYYYMMDD') , '1900-01-01' ) as EffectiveFromDateKey
  
        , ifnull(TRY_TO_DATE( a.datub , 'YYYYMMDD') , '1900-01-01' ) as EffectiveToDateKey
        , ifnull(a.revlv, '') as RevisionLevel
        , ifnull( a.ampsp ,'' ) AS AMLStatusCode
        , iff( a.reoam = 'X','TRUE','FALSE') as DeleteFlag
        , ifnull( try_to_date( a.Erdat, 'YYYYMMDD'), '1900-01-01') as DSCREATEDON
  
  
        , ifnull ( a.Ernam , '' ) as DSCREATEDBY
        , ifnull( a.Zzmediacode, '' ) as MediaCode
        , ifnull( a.Zzcmfrpn , '' ) as MANUFACTURERPARTCODEMASKED
        , IfNULL( b.AMLStatusDescription , '' )  AS AMLStatusDescription 
		, IfNULL( b.AMLStatusStandardCode , '' ) AS AMLStatusStandardCode
        , ifnull( try_to_number( a.ampnr ) , 0) as AMLSequence
        , a.SNFLK_UpdatedOn AS SrcLastModifiedDate
        , IFNULL(PLS.PLSAMLStatusStandardCode,'') AS  PLSAMLStatusStandardCode
  FROM 
        conformed.ecc_ha_ampl a
        INNER JOIN SAP.DimPlants p ON p.PlantCode = a.werks        --inner   -- p.PlantCode=EJS.Sitecode
            AND p.DataSourceKey = 1
            AND P.PlantKey      > 0
  	    INNER JOIN SAP.DimMaterials pp ON pp.MaterialCode = a.bmatn  -- inner            
            AND p.PlantKey = pp.PlantKey
            AND pp.DataSourceKey = 1
            AND pp.MaterialKey   > 0        
		 LEFT OUTER JOIN 
		 (	
			SELECT 
				  astatus.AMLStatusCode 
				, astatus.Description AS AMLStatusDescription 
				, IFNULL(astd.AMLStatusStdCode, 'Undefined') AS AMLStatusStandardCode
			FROM 
				conformed.scmdb_AMLstatus astatus
				LEFT OUTER JOIN conformed.scmdb_AMLstatusstd astd
					ON astatus.AMLStatusStdID = astd.AMLStatusStdID
			WHERE 
				astatus.DataSourceId = 6
		) b ON LTRIM(RTRIM(ifnull(a.ampsp,''))) = LTRIM(RTRIM(ifnull(b.AMLStatusCode,'')))  
  
		LEFT OUTER JOIN SAP.DimManufacturers m		
            ON TRIM(UPPER(a.mfrnr)) = TRIM(UPPER(m.ManufacturerCode ))
            AND m.DataSourceKey = 1  

       LEFT OUTER JOIN conformed.scmdb_Site AS EJS ON p.PlantCode = EJS.SiteCode	

       LEFT OUTER JOIN conformed.scmdb_AML AS EJA ON trim(ifnull(a.ematn,'')) = trim( EJA.amlreference )
          AND EJA.siteid  = EJS.SiteID
          AND EJA.DATASOURCEID = 6
                
        LEFT OUTER JOIN sap.DimManufacturerParts mp on mp.srcMfrPartID = EJA.mfrpartid
            
		LEFT OUTER JOIN  CONFORMED.V_AML_PLSStatus PLS ON a.werks = PLS.SiteCode
             AND a.ematn = PLS.AMLReference ;
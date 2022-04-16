create or replace view V_JPS_HA_DIMAML(
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
/*---------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMAML
-----------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------------------------
2021-07-12      Jagan                   Initial Revision
*/  
SELECT 
          COALESCE( P.PlantKey        , 0 )                              AS PlantKey
        , COALESCE( M.ManufacturerKey , 0 )                              AS ManufacturerKey
        , COALESCE( PP.MaterialKey    , 0 )                              AS MaterialKey		
     -- , COALESCE( mp.ManufacturerPartKey, 0 )                          AS ManufacturerPartKey 
	    , 0                                                              AS ManufacturerPartKey
        , LTRIM( COALESCE( a.bmatn, '') )                                AS MaterialCode
		, COALESCE(a.ematn,'')                                           AS AMLReference
        , COALESCE(a.mfrnr, '')                                          AS LocalManufacturerName
		, ''                                                             AS MANUFACTURERPARTCODE
      --, COALESCE(a.zzmfrpn, '')             as MANUFACTURERPARTCODE  --not avialable in JPS
        , COALESCE(a.werks , '')                                         AS PlantCode
        , COALESCE(TRY_TO_DATE( a.datuv , 'YYYYMMDD') , '1900-01-01' )   AS EffectiveFromDateKey
        , COALESCE(TRY_TO_DATE( a.datub , 'YYYYMMDD') , '1900-01-01' )   AS EffectiveToDateKey
        , COALESCE(a.revlv, '')                                          AS RevisionLevel
        , COALESCE( a.ampsp ,'' )                                        AS AMLStatusCode
        , iff( a.reoam = 'X','TRUE','FALSE')                             AS DeleteFlag
        , COALESCE( try_to_date( a.Erdat, 'YYYYMMDD'), '1900-01-01')     AS DSCREATEDON
        , COALESCE ( a.Ernam , '' )                                      AS DSCREATEDBY
        --, COALESCE( a.Zzmediacode, '' ) AS MediaCode   --not avialable in JPS
		, ''                                                             AS MediaCode
		, ''                                                             AS MANUFACTURERPARTCODEMASKED
        --, COALESCE( a.Zzcmfrpn , '' ) AS MANUFACTURERPARTCODEMASKED --not avialable in JPS
        , COALESCE( b.AMLStatusDescription , '' )                        AS AMLStatusDescription 
		, COALESCE( b.AMLStatusStandardCode , '' )                       AS AMLStatusStandardCode
        , COALESCE( try_to_number( a.ampnr ) , 0)                        AS AMLSequence
        , a.SNFLK_UpdatedOn                                              AS SrcLastModifiedDate
        , COALESCE(PLS.PLSAMLStatusStandardCode,'')                      AS PLSAMLStatusStandardCode
FROM       
        conformed.JPS_HA_AMPL a
INNER JOIN 
        SAP.DimPlants p 
           ON  p.PlantCode = a.werks        --inner   -- p.PlantCode=EJS.Sitecode
           AND p.DataSourceKey = 5
           AND P.PlantKey      > 0
INNER JOIN 
        SAP.DimMaterials pp 
           ON  pp.MaterialCode = a.bmatn  -- inner            
           AND p.PlantKey = pp.PlantKey
           AND pp.DataSourceKey = 5
           AND pp.MaterialKey   > 0        	 
LEFT OUTER JOIN 
		 (	
			SELECT 
				  astatus.AMLStatusCode 
				, astatus.Description AS AMLStatusDescription 
				, COALESCE(astd.AMLStatusStdCode, 'Undefined') AS AMLStatusStandardCode
			FROM 
				conformed.scmdb_AMLstatus astatus
				LEFT OUTER JOIN conformed.scmdb_AMLstatusstd astd
					ON astatus.AMLStatusStdID = astd.AMLStatusStdID
			WHERE 
				astatus.DataSourceId = 6
		) b ON TRIM(COALESCE(a.ampsp,'')) = TRIM(COALESCE(b.AMLStatusCode,''))  
  
LEFT OUTER JOIN 
       SAP.DimManufacturers m		
          ON a.mfrnr = m.ManufacturerCode            
         AND m.DataSourceKey = 5  
      /*      
        LEFT OUTER JOIN sap.DimManufacturerParts mp 
            on trim(a.mfrnr )   = trim(mp.localmanufacturername) 
            --and trim(a.zzmfrpn) = trim(mp.ManufacturerPartCode )  --ZZmfrpn not available in JPS
            and mp.DataSourceKey = 5 
        */    
LEFT OUTER JOIN  
       CONFORMED.V_AML_PLSStatus PLS 
          ON a.werks = PLS.SiteCode
         AND a.ematn = PLS.AMLReference;
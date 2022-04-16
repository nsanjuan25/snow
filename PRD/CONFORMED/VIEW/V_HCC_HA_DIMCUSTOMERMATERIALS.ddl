create or replace view V_HCC_HA_DIMCUSTOMERMATERIALS(
	CUSTOMERMATERIALCODE,
	MATERIALCODE,
	PLANTCODE,
	PRIORITY
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimCustomerMaterials
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-19      Juan Cedeno             Initial Revision
*/                            
SELECT 
    customermaterialcode, 
    materialcode, 
    plantcode, 
    MIN(priority) as priority 
FROM 
  (
    SELECT        
          CAST(1 AS INT) priority, 
          a.atwrt customermaterialcode, 
          regexp_replace( collate( a.objek , '' ) , '^0+', '') materialcode, 
          a.werks plantcode     
   FROM 
        conformed.hcc_ha_matn a 
        INNER JOIN 
        (
            SELECT 
                regexp_replace( collate(M.objek , '') , '^0+', '') objek, 
                M.werks, 
                max(seqgen) seqgen 
            FROM 
                conformed.hcc_ha_matn m 
            WHERE 
                atnam IN
                (
                    'CUSTOMER_PN', 
                    'GP_CUSTOMER_PN'
                 ) 
            GROUP BY 
                m.objek, 
                m.werks
        ) b ON regexp_replace( collate(a.objek , '' ) , '^0+', '') = b.objek 
        AND a.seqgen = b.seqgen 
        AND a.werks = b.werks 
   WHERE 
        atnam IN
        (
            'CUSTOMER_PN', 
            'GP_CUSTOMER_PN'
        ) 
   UNION ALL 
   
   SELECT DISTINCT 
        CAST(2 AS INT) priority, 
        K.KDMAT customermaterialcode, 
        regexp_replace( collate(K.MATNR, '') , '^0+', '') materialcode, 
        T.WERKS plantcode 
   FROM 
        conformed.hcc_ha_knmt k 
        INNER JOIN conformed.hcc_ha_tvkwz t ON K.VKORG = T.VKORG 
            AND K.VTWEG = T.VTWEG 
        INNER JOIN conformed.hcc_ha_kna1 kn ON kn.kunnr = k.kunnr 
            AND kn.ktokd = 'Z001'
    ) cust 
GROUP BY 
    customermaterialcode, 
    materialcode, 
    plantcode;
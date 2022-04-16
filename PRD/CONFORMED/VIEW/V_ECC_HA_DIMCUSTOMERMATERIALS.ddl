create or replace view V_ECC_HA_DIMCUSTOMERMATERIALS(
	CUSTOMERMATERIALCODE,
	MATERIALCODE,
	PLANTCODE,
	PRIORITY
) as
SELECT 
      CustomerMaterialCode
    , MaterialCode
    , PlantCode
    , MIN(Priority) as Priority 
FROM 
(                        
    SELECT 
          1                  as Priority
        , ifnull(a.atwrt,'') as CustomerMaterialCode
        , ifnull(a.objek,'') as MaterialCode
        , ifnull(a.werks,'') as PlantCode 
    FROM 
        conformed.ecc_ha_matn a 
        INNER JOIN 
        (
            SELECT 
                  IFNULL(M.objek,'') as objek
                , IFNULL(M.werks,'') as werks
                , MAX(seqgen) seqgen 
            FROM 
                conformed.ecc_ha_matn m 
            WHERE 
                atnam IN 
                (
                      'CUSTOMER_PN'
                    , 'GP_CUSTOMER_PN'
                ) 
            GROUP BY 
                  m.objek
                , m.werks
        ) b ON a.objek = b.objek 
        AND a.seqgen = b.seqgen 
        AND a.werks = b.werks 
    WHERE 
        atnam IN
          (
               'CUSTOMER_PN'
             , 'GP_CUSTOMER_PN'
          ) 

  UNION ALL 

  SELECT DISTINCT 
        2                  as Priority
      , IFNULL(K.KDMAT,'') as CustomerMaterialCode
      , IFNULL(K.MATNR,'') as MaterialCode
      , IFNULL(T.WERKS,'') as PlantCode 
  FROM 
      conformed.ecc_ha_knmt k 
      INNER JOIN conformed.ecc_ha_tvkwz t ON K.VKORG = T.VKORG 
          AND K.VTWEG = T.VTWEG 
      INNER JOIN conformed.ecc_ha_kna1 kn ON kn.kunnr = k.kunnr 
          AND kn.ktokd = 'Z003'   

    UNION ALL

    SELECT 
          3                     as priority
        , IFNULL(gof.gofmat,'') as customermaterialcode
        , IFNULL(gof.sapmat,'') as materialcode
        , IFNULL(t.werks,'')    as plantcode 
    FROM 
        conformed.ecc_ha_zmm_gof_mara gof 
        INNER JOIN conformed.ecc_ha_kna1 kn ON kn.kunnr = gof.kunnr 
        INNER JOIN conformed.ecc_ha_tvkwz t ON gof.VKORG = T.VKORG 
            AND gof.VTWEG = T.VTWEG    

    ) cust 
GROUP BY 
      customermaterialcode
    , materialcode
    , plantcode;
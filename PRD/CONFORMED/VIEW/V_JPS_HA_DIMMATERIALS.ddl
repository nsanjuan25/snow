create or replace view V_JPS_HA_DIMMATERIALS(
	PLANTCODE,
	MATERIALCODE,
	PLANTKEY,
	BUYERKEY,
	PLANNERKEY,
	MATERIALGROUPKEY,
	MATERIALTYPECODE,
	ABCCODE,
	MATERIALGROUPCODE,
	MATGROUPISNUMERIC,
	PRODUCTGROUPCODE,
	PLANNINGCALENDARCODE,
	ORDERPOLICYCODE,
	MATERIALDESCRIPTION,
	PLANNERCODE,
	BUYERCODE,
	UNITOFMEASURECODE,
	YIELD,
	MINIMUMLOTSIZE,
	MAXIMUMLOTSIZE,
	MULTIPLEQTY,
	SAFETYSTOCKQTY,
	REORDERPOINTQTY,
	MAXIMUMSTOCKQTY,
	LOTSIZECODE,
	PLANNINGTIMEFENCE,
	DOCKTOSTOCKLEADTIME,
	SAFETYLEADTIME,
	FIXEDLEADTIME,
	BATCHMANAGED,
	BEFOREFORECASTINTERVAL,
	AFTERFORECASTINTERVAL,
	PRICEUNIT,
	STANDARDUNITCOSTP0,
	STANDARDUNITCOSTP1,
	SELLUNITPRICEP0,
	SELLUNITPRICEP1,
	STANDARDUNITCOSTINUSD,
	SELLUNITPRICEUSD,
	P1EFFECTIVEFROMDATEKEY,
	ASSEMBLYSCRAPPCT,
	COMPONENTSCRAPPCT,
	PLANNINGSTRATEGYGROUP,
	PROFITCENTERCODE,
	DELETEFLAG,
	DSCREATEDTS,
	DSUPDATEDTS,
	RECORDEXIST,
	LOCALCURRENCYTOUSDEXCHANGERATE,
	P2EFFECTIVEFROMDATEKEY,
	P3EFFECTIVEFROMDATEKEY,
	P0EFFECTIVEFROMDATEKEY,
	MATERIALLEDGERACTIVEFLAG,
	RANGEOFCOVERAGEPROFILE,
	SAFETYTIMEINDICATOR,
	MRPPROFILE,
	MRPGROUP,
	DISCONTINUATIONINDICATOR,
	EFFECTIVEOUTDATEKEY,
	FOLLOWUPMATERIAL,
	COMMODITYIMPORTCODE,
	INDUSTRYSTDDESC,
	SAFETYINSTOCK,
	FIXEDLOTSIZE,
	PRICECONTROLINDICATOR,
	STANDARDUNITCOSTPLANNEDCURRENT,
	MOVINGAVGUNITCOST,
	STKVALUEDQTY,
	STOCKVALUECURRENT,
	STKVALUEMOVINGAVGWHENSTDPRICECONTROL,
	STANDARDUNITCOSTPLANNEDNEXT,
	MLPRICECONTROLINDICATOR,
	MLMOVINGAVGUNITCOSTUSD,
	MLCURRENCYCODE,
	MLSTKVALUECURRENTUSD,
	MLSTKVALUEMOVINGAVGWHENSTDPRICECONTROLUSD,
	MLSTDUNITCOSTUSD,
	MLPRICEUNIT,
	STOCKVALUEATSTANDARDUNITCOST,
	STOCKVALUEATMOVINGAVERAGECOST,
	MLSTKVALUEATSTDUNITCOSTUSD,
	MLSTKVALUEATMOVINGAVGCOSTUSD,
	MLPERIODCURRENTSTDCOSTESTIMATE,
	MLFISCALYEARCURRENTSTDCOSTESTIMATE,
	AUTOPORESCHEDULESTRATEGY,
	GENERALITEMCATEGORY,
	QAUSAGE,
	FRMW_EXTRACTED_ON,
	SNFLK_UPDATEDON,
	CUSTOMERMATERIALCODE,
	DOCUMENTNUMBER,
	MATERIALTYPE,
	MATERIALGROUPCODE5,
	MATERIALTYPEDESCRIPTION,
	MAKEBUY,
	MATERIALTYPESTANDARDCODE,
	STRATEGICPURCHASINGFLAG,
	INDUSTRYSTANDARDDESCRIPTION,
	DAYSOFSUPPLY,
	SOURCINGOWNERTYPECODE,
	SOURCINGOWNERTYPESTANDARDCODE,
	SOURCINGOWNERTYPEDESCRIPTION,
	CONTROLLEDBY,
	SALESORGANIZATIONCODE,
	SALESMATERIALGROUP2,
	SALESMATERIALGROUP2DESCRIPTION,
	SALESMATERIALGROUP4,
	SALESMATERIALGROUP4DESCRIPTION,
	SALESMATERIALGROUP5,
	SALESMATERIALGROUP5DESCRIPTION,
	VALUATIONCLASS,
	CURRENCYCODE,
	GLACCOUNTNUMBER,
	GLDESCRIPTION
) as 
/*------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimMaterials
--------------------------------------------------------------------------------------------
Revision History
--------------------------------------------------------------------------------------------
Date            Developer               Comments
--------------------------------------------------------------------------------------------
2021-07-27      Jagan                   Initial Revision
*/                            
SELECT 
       sp.SITECODE                             as PlantCode
     , sp.SITEPARTCODE                         as MaterialCode   
     , ifnull(P.PlantKey, 0 )                  as PlantKey
     , ifnull(B.BuyerKey, 0)                   as BuyerKey
     , ifnull(pl.PlannerKey, 0)                as PlannerKey      
     , ifnull(mg.MaterialGroupKey , 0)         as MaterialGroupKey                        
     , ifnull(sp.SITEPARTTYPECODE ,'')         as MaterialTypeCode
     , IFNULL(sp.ABCCODE, '')                  as ABCCODE
     , ifnull(sp.MATERIALGROUPCODE,'')         as MATERIALGROUPCODE
     , case 
	       when try_to_number(sp.MATERIALGROUPCODE) is null then 'string' 
		                                                    ELSE 'numeric' 
		   END                                 as matgroupisnumeric                        
     , ifnull(sp.PRODUCTGROUPCODE,'')          as PRODUCTGROUPCODE
     , ifnull(sp.PLANNINGCALENDARCODE,'')      as PLANNINGCALENDARCODE
     , ifnull(sp.ORDERPOLICYCODE, '')          as ORDERPOLICYCODE
     , ifnull(sp.SITEPARTDESCRIPTION,'')       as MaterialDescription
     , ifnull(sp.PLANNERCODE ,'')              as PLANNERCODE
     , ifnull(sp.BUYERCODE ,'')                as BUYERCODE
     , ifnull(sp.UNITOFMEASUREDSCODE ,'')      as UNITOFMEASURECODE
     , ifnull(sp.YIELD ,0)                     as YIELD
     , ifnull(CASE
                  WHEN sp.lotsizecode = 'FX' THEN sp.fixedlotsize
                                             ELSE sp.minimumlotsize
              END ,0) as minimumlotsize 
     , ifnull( sp.MAXIMUMLOTSIZE ,0) as MAXIMUMLOTSIZE
     , ifnull( sp.MULTIPLEQTY ,0) as MULTIPLEQTY
     , ifnull( sp.SAFETYSTOCKQTY ,0) as SAFETYSTOCKQTY
     , ifnull( sp.REORDERPOINTQTY ,0)as REORDERPOINTQTY
     , ifnull( sp.MAXIMUMSTOCKQTY ,0) as MAXIMUMSTOCKQTY
     , ifnull( sp.LOTSIZECODE ,'') as LOTSIZECODE
     , ifnull(sp.PLANNINGTIMEFENCE, 0 ) as PLANNINGTIMEFENCE
     , ifnull(sp.DOCKTOSTOCKLEADTIME, 0 ) as DOCKTOSTOCKLEADTIME
     , ifnull(sp.SAFETYLEADTIME, 0 ) as SAFETYLEADTIME
     , ifnull(sp.FIXEDLEADTIME, 0 ) as FIXEDLEADTIME
     , iff(sp.BATCHMANAGEDFLAG=1,'TRUE', 'FALSE' ) as BATCHMANAGED
     , ifnull(sp.BEFOREFORECASTINTERVAL, 0 ) as BEFOREFORECASTINTERVAL
     , ifnull(sp.AFTERFORECASTINTERVAL, 0 ) as AFTERFORECASTINTERVAL
     , ifnull( iff(sp.PRICEUNIT=0,1,sp.PRICEUNIT ), 1 ) as PRICEUNIT--
     , ifnull(sp.STDUNITCOSTP0, 0 ) as StandardUnitCostP0
     , ifnull(sp.STDUNITCOSTP1, 0 ) as StandardUnitCostP1
     , ifnull(sp.SELLUNITPRICEP0, 0 ) as SELLUNITPRICEP0
     , ifnull(sp.SELLUNITPRICEP1, 0 ) as SELLUNITPRICEP1
     , ifnull(CASE
             WHEN SP.MaterialLedgerActiveFlag = 'X' THEN CAST(SP.MLStdUnitCostUSD / case when SP.MLPriceUnit = 0 then 1 else SP.MLPriceUnit end AS DECIMAL(30,6))
             ELSE CAST((SP.stdunitcostp0 / case when SP.PriceUnit = 0 then 1 else SP.PriceUnit end ) * SP.LocalCurrencyToUSDExchangeRate AS DECIMAL(30,6))
         END,0) standardunitcostinusd    
     , ifnull(CASE
             --WHEN price_info.sellunitpriceusd > 0 THEN price_info.sellunitpriceusd
             WHEN ifnull(sp.deleteflag,'') = '' AND CAST((SP.sellunitpricep0 / case when SP.PriceUnit = 0 then 1 else SP.PriceUnit end ) * SP.LocalCurrencyToUSDExchangeRate AS DECIMAL(30,6)) = 0 
                      THEN
                          --CASE WHEN price_info2.sellunitpriceusd <> 0 THEN price_info2.sellunitpriceusd
                          --ELSE 
                          --	 SoPrice.sellunitpriceusd
                          --END 		
                          1
             ELSE CAST((SP.sellunitpricep0 / SP.PriceUnit) * SP.LocalCurrencyToUSDExchangeRate AS DECIMAL(30,6))
         END,0) sellunitpriceusd 
     , IFNULL ( TRY_TO_DATE( sp.P1EFFECTIVEFROMDATE, 'YYYYMMDD' ), '1900-01-01')  as P1EFFECTIVEFROMDATEKEY
     , ifnull(sp.ASSEMBLYSCRAPPCT , 0  )as ASSEMBLYSCRAPPCT
     , ifnull(sp.COMPONENTSCRAPPCT , 0  )as COMPONENTSCRAPPCT
     , ifnull(sp.PLANNINGSTRATEGYGROUP , '' ) as PLANNINGSTRATEGYGROUP
     , ifnull(sp.PROFITCENTER, '') as PROFITCENTERCODE
     , CASE WHEN sp.DELETEFLAG = 'X' then 'TRUE' ELSE 'FALSE' END as DELETEFLAG
     , IFNULL ( TRY_TO_DATE( sp.DSCREATEDTS, 'YYYYMMDD' ), '1900-01-01') as DSCREATEDTS
     , IFNULL ( TRY_TO_DATE( sp.DSUPDATEDTS, 'YYYYMMDD' ), '1900-01-01') as DSUPDATEDTS
     , ifnull(sp.RECORDEXIST, 0 ) as RECORDEXIST
     , ifnull( sp.LOCALCURRENCYTOUSDEXCHANGERATE ,1) as LOCALCURRENCYTOUSDEXCHANGERATE
     , IFNULL ( TRY_TO_DATE( sp.P2EFFECTIVEFROMDATE, 'YYYYMMDD' ), '1900-01-01') as P2EFFECTIVEFROMDATEKEY
     , IFNULL ( TRY_TO_DATE( sp.P3EFFECTIVEFROMDATE, 'YYYYMMDD' ), '1900-01-01') as P3EFFECTIVEFROMDATEKEY
     , IFNULL ( TRY_TO_DATE( sp.P0EFFECTIVEFROMDATE, 'YYYYMMDD' ), '1900-01-01') as P0EFFECTIVEFROMDATEKEY
     , iff(sp.MATERIALLEDGERACTIVEFLAG ='X','TRUE' , 'FALSE') As MATERIALLEDGERACTIVEFLAG     
     , ifnull(sp.RANGEOFCOVERAGEPROFILE , '') As RANGEOFCOVERAGEPROFILE
     , ifnull(sp.SAFETYTIMEINDICATOR, '') As SAFETYTIMEINDICATOR
     , ifnull(sp.MRPPROFILE, '') As MRPPROFILE
     , ifnull(sp.MRPGROUP, '') As MRPGROUP
     , ifnull(sp.DISCONTINUATIONINDICATOR, '') As DISCONTINUATIONINDICATOR
     , IFNULL ( TRY_TO_DATE( sp.EFFECTIVEOUTDATE, 'YYYYMMDD' ), '1900-01-01') as EFFECTIVEOUTDATEKEY
     , ifnull(sp.FOLLOWUPMATERIAL, '') As FOLLOWUPMATERIAL
     , ifnull(sp.COMMODITYIMPORTCODE, '') As COMMODITYIMPORTCODE
     , ifnull(sp.INDUSTRYSTDDESC, '') As INDUSTRYSTDDESC
     , 0  as SAFETYINSTOCK
     , ifnull(sp.FIXEDLOTSIZE, 0) as FIXEDLOTSIZE
     , ifnull(sp.PRICECONTROLINDICATOR , '') as PRICECONTROLINDICATOR
     , ifnull(sp.STDUNITCOSTPLANNEDCURRENT , 0) as STANDARDUNITCOSTPLANNEDCURRENT
     , ifnull(sp.MOVINGAVGUNITCOST , 0) as MOVINGAVGUNITCOST
     , ifnull(sp.STKVALUEDQTY , 0) as STKVALUEDQTY
     , ifnull(sp.STKVALUECURRENT , 0) as STOCKVALUECURRENT
     , ifnull(sp.STKVALUEMOVINGAVGWHENSTDPRICECONTROL , 0) as STKVALUEMOVINGAVGWHENSTDPRICECONTROL
     , ifnull(sp.STDUNITCOSTPLANNEDNEXT , 0) as STANDARDUNITCOSTPLANNEDNEXT
     , ifnull(sp.MLPRICECONTROLINDICATOR , '') as MLPRICECONTROLINDICATOR
     , ifnull(sp.MLMOVINGAVGUNITCOSTUSD , 0) as MLMOVINGAVGUNITCOSTUSD
     , ifnull(sp.MLCURRENCYCODE ,'') as MLCURRENCYCODE
     , ifnull(sp.MLSTKVALUECURRENTUSD ,0) as MLSTKVALUECURRENTUSD
     , ifnull(sp.MLSTKVALUEMOVINGAVGWHENSTDPRICECONTROLUSD ,0) as MLSTKVALUEMOVINGAVGWHENSTDPRICECONTROLUSD
     , ifnull(sp.MLSTDUNITCOSTUSD ,0) as MLSTDUNITCOSTUSD
     , ifnull(sp.MLPRICEUNIT ,0) as MLPRICEUNIT
     , ifnull(sp.STKVALUEATSTDUNITCOST ,0) as STOCKVALUEATSTANDARDUNITCOST
     , ifnull(sp.STKVALUEATMOVINGAVGCOST ,0) as STOCKVALUEATMOVINGAVERAGECOST
     , ifnull(sp.MLSTKVALUEATSTDUNITCOSTUSD ,0) as MLSTKVALUEATSTDUNITCOSTUSD
     , ifnull(sp.MLSTKVALUEATMOVINGAVGCOSTUSD ,0) as MLSTKVALUEATMOVINGAVGCOSTUSD
     , ifnull(sp.MLPERIODCURRENTSTDCOSTESTIMATE ,0) as MLPERIODCURRENTSTDCOSTESTIMATE
     , ifnull(sp.MLFISCALYEARCURRENTSTDCOSTESTIMATE ,0) as MLFISCALYEARCURRENTSTDCOSTESTIMATE
     , ''  as AUTOPORESCHEDULESTRATEGY
     , IFNULL( sp.GENITEMCAT,'' ) as GENERALITEMCATEGORY
     , IFNULL( sp.QAUSAGE,'' ) as QAUSAGE
     , sp.FRMW_EXTRACTED_ON
     , sp.SNFLK_UPDATEDON                        
  -- , IFNULL( cm.customermaterialcode, '' ) as customermaterialcode   --commented by Jagan
     , ''  as customermaterialcode
     , ifnull( m.zeinr,'' ) as documentnumber
     , ifnull( m.mtart,'' ) as materialtype
     , ifnull(sp5.matgroup5,'') materialgroupcode5
     , ifnull(sptstd.Description,'') as MaterialTypeDescription
     , ifnull(sptstd.MakeBuy,'') as MakeBuy
     , ifnull(sptstd.SiteParttypeStdCode,'') as MaterialTypeStandardCode
--     , CASE WHEN dsp.PlantCode IS NULL THEN 'FALSE' ELSE 'TRUE' END as strategicpurchasingflag
     , 'FALSE'      as strategicpurchasingflag
     , ifnull(sp.IndustryStdDesc,'') as INDUSTRYSTANDARDDESCRIPTION
--   , IfNULL(dls.ForceNumberOfDaysSupply,1)	AS DaysOfSupply
     , 1   As DaysOfSupply
     , IfNULL(sow.sourcingownertypecode ,'') as sourcingownertypecode
     , IfNULL(sow.SourcingOwnerTypeStandardCode,'')  as SourcingOwnerTypeStandardCode
     , IfNULL(sow.SourcingOwnerTypeDescription, '') as  SourcingOwnerTypeDescription
     , IfNULL(sow.controlledby ,'UNDF') as controlledby 
     , IFNULL(sa.salesorganizationcode,'')  as salesorganizationcode
     , IFNULL(sa.SalesMaterialGroup2,'')  as SalesMaterialGroup2
     , IFNULL(sa.SalesMaterialGroup2Description,'') as SalesMaterialGroup2Description
     , IFNULL(sa.SalesMaterialGroup4,'')  as SalesMaterialGroup4
     , IFNULL(sa.SalesMaterialGroup4Description,'') as SalesMaterialGroup4Description
     , IFNULL(sa.SalesMaterialGroup5,'')  as SalesMaterialGroup5
     , IFNULL(sa.SalesMaterialGroup5Description,'') as SalesMaterialGroup5Description      
     , IFNULL(mb.bklas,'')  as ValuationClass
     , IFNULL(P.LocalCurrencyCode,'') AS CURRENCYCODE     
/*   , IFNULL(GL.GLAccountNo,'') as GLAccountnumber
     , IFNULL(GL.GLLong,'') as GLDescription     */
	 , '' as GLAccountnumber
	 , '' as GLDescription
FROM   
       conformed.jps_ha_site_Part sp    
LEFT OUTER JOIN 
       sap.DimPlants P 
	       on sp.SiteCode = P.PlantCode
           AND P.DataSourceKey = 5
LEFT OUTER JOIN 
       sap.DimBuyers B 
	       on  sp.buyercode = B.BuyerCode
           and b.datasourcekey = 5
LEFT OUTER JOIN 
       sap.DimPlanners Pl 
	       on  sp.plannercode = Pl.plannercode
           and pl.DataSourceKey = 5
LEFT OUTER JOIN 
       sap.dimMaterialGroups MG 
	       on  sp.materialgroupcode = MG.materialgroupcode
           and MG.DataSourcekey = 5   
/*
LEFT OUTER JOIN 
       sap.DimLotSizes dls 
	       on sp.LotSizeCode = dls.LotSizeCode */
LEFT OUTER JOIN 
       conformed.jps_ha_mara m 
	       on sp.sitepartcode = m.matnr
LEFT OUTER JOIN 
          (
              SELECT 
                  sitepartcode,
                  sitecode,
                  matgroup5
              FROM
                  (
                    SELECT 
                      sp.sitepartcode ,
                      sp.sitecode  ,                   
                      CASE
                          WHEN mv.vtweg = '01'
                          AND CAST( ifnull(mv.mvgr5,'') AS STRING) != '' THEN mv.mvgr5
                          WHEN mv.vtweg = '02'
                              AND CAST( ifnull(mv.mvgr5,'') AS STRING) != '' THEN mv.mvgr5
                          ELSE NULL
                      END matgroup5,
                     row_number() over ( Partition by sp.sitepartcode , sitecode order by case when ifnull( mv.mvgr5 , '') <> '' then mv.mvgr5  else NULL end  , mv.vtweg ASC, mv.mvgr5 ASC) rn
              FROM
                  conformed.jps_ha_site_Part sp
                  LEFT OUTER JOIN conformed.jps_ha_tvkwz t ON t.werks = sp.sitecode
                  LEFT OUTER JOIN conformed.jps_ha_mvke mv ON t.vkorg = mv.vkorg
                      AND t.vtweg = mv.vtweg
                      AND sp.sitepartcode = mv.matnr
                      AND mv.dwerk = t.werks
              ) s
            WHERE
              rn = 1
          ) sp5 ON sp.sitepartcode = sp5.sitepartcode
      AND sp.sitecode = sp5.sitecode
/*      LEFT OUTER JOIN
            (
              SELECT 
                  materialcode,
                  plantcode,
                  customermaterialcode,
                  row_number() over(partition by plantcode, materialcode order by plantcode )   rn
              FROM 
                  conformed.V_JPS_HA_DIMCUSTOMERMATERIALS
              ) CM 
              ON SP.Sitecode = CM.PlantCode
              AND SP.SitePartCode = CM.MaterialCode
              AND CM.rn > 1      */  --commented by Jagan
      LEFT OUTER JOIN
          (                        
              select 
                    SitePartTypeCode
                  , Description
                  , MakeBuy
                  , SiteParttypeStdCode
              from 
                  conformed.scmdb_SitePartType spt
                  INNER JOIN conformed.scmdb_SitePartTypestd std on spt.sitePartTypeSTDID = std.sitePartTypeSTDID
              WHERE 
                  spt.datasourceid = 6
          ) sptstd  
          ON sp.SitePartTypeCode = sptstd.SitePartTypeCode
/*      LEFT OUTER JOiN Sap.dimStrategicPurchasing dsp
          on dsp.plantcode = sp.sitecode
          and dsp.profitcentercode = Sp.profitcenter
          and dsp.datasourcekey = 5  */
      LEFT OUTER JOIN 
      (
          select 
                S.SiteCode
              , SP.SitepartCode
              , sow.sourcingownertypecode
              , sow.sourcingownertypecode  as SourcingOwnerTypeStandardCode
              , sow.description as  SourcingOwnerTypeDescription
              , sow.controlledby
          from 
              scmdb_SitePartSourcingSettings sss
              inner join scmdb_sourcingownertype sow on sss.sourcingownertypeid = sow.sourcingownertypeid
              inner join scmdb_SitePart sp on sss.sitepartid = sp.sitepartid
                  and sp.datasourceid = 6
              inner join scmdb_Site s on sp.siteid = s.siteid       
      )sow on sp.SiteCode = sow.sitecode
      and sp.sitepartcode = sow.sitepartcode
    -- missing tables MARC and sales      
    LEFT OUTER JOIN  conformed.jps_ha_mbew mb 
        ON mb.matnr = sp.sitepartcode
        AND mb.bwkey = sp.sitecode
    LEFT OUTER JOIN 
    (
        select 
              mvke.Matnr  as MaterialCode
            , P.plantcode                        
            , mvke.Vkorg  as salesorganizationcode
            , mvke.Mvgr2  as SalesMaterialGroup2
          --, tvm2t.bezei as SalesMaterialGroup2Description
		    , 'UNDF'      as SalesMaterialGroup2Description
            , mvke.Mvgr4  as SalesMaterialGroup4
          --, tvm4t.BEZEI as SalesMaterialGroup4Description
		    , 'UNDF'      as SalesMaterialGroup4Description
            , mvke.Mvgr5  as SalesMaterialGroup5
         -- , tvm5t.BEZEI as SalesMaterialGroup5Description 
            , 'UNDF'      as SalesMaterialGroup5Description			
        from
            conformed.jps_ha_mvke mvke
            INNER JOIN sap.DimPlants P on mvke.Vkorg = P.salesorganizationcode
/*            LEFT OUTER JOIN conformed.jps_ha_tvm2t tvm2t 
                ON mvke.Mvgr2  = tvm2t.mvgr2
                AND tvm2t.spras = 'E'
            LEFT OUTER JOIN conformed.jps_ha_tvm4t as tvm4t
                ON mvke.Mvgr4 = tvm4t.MVGR4
                AND tvm4t.SPRAS = 'E'
            LEFT OUTER JOIN conformed.jps_ha_tvm5t as tvm5t                        
                on mvke.Mvgr5 = tvm5t.MVGR5
                AND tvm5t.SPRAS = 'E' */
        WHERE 
            mvke.vtweg='01' 
            and (
                    NULLIF(mvke.Mvgr2, '') IS NOT NULL 
                    OR NULLIF(mvke.Mvgr4, '') IS NOT NULL 
                    OR NULLIF(mvke.Mvgr5, '') IS NOT NULL
                )                        
    )sa on sp.sitecode = sa.plantcode 
        and sp.sitepartcode = sa.materialcode        
 /*   
    LEFT OUTER JOIN
    (
        SELECT 
              t030.bklas as ValuationClass    
            , t030.konts as GLAccountNo
            , skat.txt50 as GLLong
        FROM
            conformed.jps_ha_t030 t030
            LEFT OUTER JOIN conformed.jps_ha_skat skat on t030.konts = skat.saknr
        WHERE 
            skat.ktopl     = '0010'
            and skat.spras = 'E'
            and t030.ktopl = '0010'
            and t030.ktosl = 'GBB'
            and t030.komok = 'ZBR'    
    )GL ON GL.ValuationClass = mb.bklas*/
;
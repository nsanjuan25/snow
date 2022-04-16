create or replace view V_ECC_HA_MRPDETAIL(
	MRPNUMBER,
	MRPITEM,
	MRPAREA,
	MRPPLANNINGSEGMENT,
	RECEIPTREQUIREMENTDTS,
	DELIVERYFINISHDTS,
	STARTRELEASEDTS,
	OPENINGDTS,
	MRPCALCDATE,
	MRPELEMENTINDICATOR,
	QUANTITY,
	DOCUMENTNUMBER,
	DOCUMENTITEM,
	DOCUMENTSCHEDULELINE,
	PARENTSITEPARTCODE,
	RECEIPTISSUEINDICATOR,
	SITECODE,
	SITEPARTCODE,
	MRPSCENARIO,
	FIXEDVENDOR,
	MPNMATERIAL,
	FIRMEDORDERFLAG,
	FIRMEDCOMPONENTFLAG,
	AVAILABILITY,
	DOCUMENTNUMBER2,
	MRPRECOMMENDATIONCODE,
	MRPRECOMMENDATIONCODE2,
	POORDERTYPE,
	PLANNINGPRODUCTIONPLANT,
	PRODUCTIONVERSION,
	REQDATE,
	MRPTYPECODE,
	MRPCURRENTASOFDTS,
	BASEUNITOFMEASUREDSCODE,
	UPDATED_ON,
	MDTB_SNAPSHOTDATE,
	CANCELLATIONLEADTIME
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.FactMRP
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-03      Carlos Carrillo             Initial Revision
                                        
*/  

SELECT mdtb.dtnum AS MRPNumber,
       mdtb.dtpos AS MRPItem,
       mrpheader.SiteCode AS MRPArea,
       IFNULL(mdtb.Planr,'') AS MRPPlanningSegment,
       mdtb.dat00 AS ReceiptRequirementDTS,
       mdtb.dat01 AS DeliveryFinishDTS,
       mdtb.dat02 AS StartReleaseDTS,
       mdtb.dat03 AS OpeningDTS,
       mdtb.umdat AS MRPCalcDate,
       mdtb.delkz AS MRPElementIndicator,
       mdtb.mng01 AS Quantity,
       CASE
           WHEN mdtb.delkz = 'SB' THEN
               mdtb.aufvr
           ELSE
               mdtb.delnr
       END AS DocumentNumber,
       mdtb.delps AS DocumentItem,
       mdtb.delet AS DocumentScheduleLine,
       IFNULL(mdtb.baugr,'') AS ParentSitePartCode,
       mdtb.plumi AS ReceiptIssueIndicator,
       mrpheader.SiteCode AS SiteCode,
       mrpheader.SitePartCode AS SitePartCode,
       mrpheader.MRPScenario AS MRPScenario,
       CASE
           WHEN mdtb.delkz = 'BA' THEN
               eban.flief
           WHEN mdtb.delkz = 'BE'
                OR mdtb.delkz = 'LA'
                OR mdtb.delkz = 'SA' THEN
               sub.lifnr
           WHEN mdtb.delkz = 'PA' THEN
               plaf.Flief
           ELSE
               ''
       END AS FixedVendor,
       CASE
           WHEN mdtb.delkz = 'BA' THEN
               eban.ematn
           WHEN mdtb.delkz = 'BE'
                OR mdtb.delkz = 'LA'
                OR mdtb.delkz = 'SA' THEN
               sub.ematn
           WHEN mdtb.delkz = 'PA' THEN
               plaf.ematn
           ELSE
               ''
       END AS MPNMaterial,
       FirmedOrderFlag,
       FirmedComponentFlag,
       mdtb.vrfkz AS Availability,
       IFNULL(mdtb.del12,'') AS DocumentNumber2,
       mdtb.aussl AS MRPRecommendationCode,
       mdtb.oldsl AS MRPRecommendationCode2,
       mdtb.baart AS POOrderType,
       IFNULL(mdtb.wrk02,'') AS PlanningProductionPlant,
       IFNULL(mdtb.verid,'') AS ProductionVersion,
       CASE
           WHEN mdtb.delkz = 'BA' THEN
               eban.badat
           ELSE
               '00000000'
       END AS ReqDate,
       CONCAT(   mdtb.delkz,
                 (CASE
                      WHEN COALESCE(FirmedOrderFlag, '0') = 'X'
                           AND COALESCE(FirmedComponentFlag, '0') = 'X'
                           AND trim(mdtb.delkz) <> 'VJ' THEN
                          '-XX'
                      WHEN COALESCE(FirmedOrderFlag, '0') = 'X'
                           AND FirmedComponentFlag IS NULL
                           AND TRIM(mdtb.delkz) <> 'VJ' THEN
                          '-X'
                      WHEN TRIM(mdtb.delkz) = 'PP'
                           AND TRIM(mdtb.baart) = 'SAFT' THEN
                          CONCAT('-', 'SAFT')
                      ELSE
                          CASE
                              WHEN LENGTH(COALESCE(siteparts.PlanningStrategyGroup, '')) > 0 THEN
                                  CONCAT('-', COALESCE(siteparts.PlanningStrategyGroup, ''))
                              ELSE
                                  ''
                          END
                  END
                 ),
                 (CASE
                      WHEN COALESCE(mdtb.vrfkz, '0') = 'X'
                           AND mdtb.plumi = '-' THEN
                          CONCAT('-', 'N')
                      ELSE
                          ''
                  END
                 )
             ) AS MRPTypeCode,
       mrpheader.MRPCurrentAsOFDTS AS MRPCurrentAsOFDTS,
       mrpheader.BaseUnitOfMeasureDSCode AS BaseUnitOfMeasureDSCode,
       CURRENT_TIMESTAMP AS updated_on,
       mdtb.MDTB_SNAPSHOTDATE,
       IFNULL(sub.mahn3,0) as cancellationleadtime
FROM
(
    SELECT dtnum,
           dtpos,
           planr,
           dat00,
           dat01,
           dat02,
           dat03,
           umdat,
           delkz AS delkz_actual,
           mng01,
           delet,
           baugr,
           plumi,
           aufvr,
           CASE
               WHEN
               (
                   delkz IN ( 'SB', 'SM' )
                   AND trim(IFNULL(aufvr, '' )) = ''
               ) THEN
                   CONCAT(delkz, '/NP')
               WHEN
               (
                   delkz = 'BA'
                   AND fix01 = 'X'
               ) THEN
                   CONCAT(delkz, '/FX')
               WHEN
               (
                   delkz IN ( 'SA', 'PA' )
                   AND fix01 = 'X'
               ) THEN
                   CONCAT(delkz, '/FX')
               WHEN
               (
                   delkz = 'VC'
                   AND plart = '1'
               ) THEN
                   CONCAT(delkz, '/DL')
               ELSE
                   delkz
           END AS delkz,
           fix01,
           fix02,
           vrfkz,
           del12,
           aussl,
           oldsl,
           baart,
           wrk02,
           verid,
           delnr,
           delps,
           CASE
               WHEN delkz = 'FE' THEN
                   'X'
               ELSE
                   fix01
           END AS FirmedOrderFlag,
           CASE
               WHEN delkz = 'FE' THEN
                   'X'
               ELSE
                   fix02
           END AS FirmedComponentFlag,
           cast(FRMW_EXTRACTED_ON as date) as MDTB_SNAPSHOTDATE
    FROM CONFORMED.BW_HA_MDTB
) mdtb
    INNER JOIN CONFORMED.V_ECC_HA_MRPHEADER AS mrpheader
        ON mrpheader.MRPNumber = mdtb.dtnum
        and mdtb.MDTB_SNAPSHOTDATE = mrpheader.mdkp_SNAPSHOTDATE
        and mdtb.MDTB_SNAPSHOTDATE >= DATEADD(day,0,current_date)
    LEFT JOIN CONFORMED.ECC_HA_EBAN eban
        ON eban.banfn = mdtb.delnr
           AND CAST(eban.bnfpo AS int) = CAST(mdtb.delps AS int)
    LEFT JOIN
    (
        SELECT ekpo.ebeln,
               ekpo.ebelp,
               ekko.lifnr,
               ekpo.ematn,
               ekpo.mahn3
        FROM CONFORMED.ECC_HA_EKKO ekko
            INNER JOIN CONFORMED.ECC_HA_EKPO ekpo
                ON ekpo.ebeln = ekko.ebeln
    ) sub
        ON sub.ebeln = mdtb.delnr
           AND CAST(sub.ebelp AS INT) = CAST(mdtb.delps AS INT)
    LEFT JOIN CONFORMED.BW_HA_PLAF plaf
        ON plaf.plnum = mdtb.delnr
    LEFT JOIN conformed.V_BW_HA_SITE_PARTS AS siteparts
        ON MrpHeader.SiteCode = siteparts.SiteCode
           AND MrpHeader.SitePartCode = siteparts.SitePartCode;
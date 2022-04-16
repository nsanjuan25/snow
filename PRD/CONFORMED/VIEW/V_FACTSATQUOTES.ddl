create or replace view V_FACTSATQUOTES(
	MATERIALKEY,
	PLANTKEY,
	MARKETSECTORKEY,
	MANUFACTURERPARTKEY,
	MANUFACTURERKEY,
	MATERIALGROUPCODE,
	LOCALMATERIALGROUPNAME,
	ONHANDQTY,
	ONORDERQTY,
	DEMANDQTY,
	DEMANDQTY90DAYS,
	WORKCELL,
	PP2,
	NETDEMAND,
	QUOTEID,
	UPLOADTYPE,
	QUOTENAME,
	QUOTEOWNER,
	QUOTEOWNERLONG,
	LOADDATE,
	QUOTETYPE,
	DESCRIPTION,
	QUOTEITEMNBR,
	PRICE,
	CURRENCY,
	EXCHANGERATEKEY,
	CURRENCYSTDID,
	EXCHANGERATE,
	QUOTEITEMSTATUSCODE,
	STARTDATE,
	ENDDATE,
	EFFECTIVITYRULE,
	PT,
	IT,
	COO,
	NCNR,
	PAYMENTTERMS,
	COMMENTS,
	CP,
	SUPPLIERCODE,
	SUPPLIERNAME,
	CUSTOMERCORPORATIONID,
	SUPPLIERCORPORATIONID,
	LASTPOSUPPLIERCORPORATIONDSNAME,
	LASTPOPRICEPERUNIT,
	LASTPOPOTYPE,
	LASTPOCREATEDATE,
	LASTPOCONSIGNMENT,
	LASTPOMPN,
	LASTPOMFR,
	LASTPOGLOBALCORPORATIONNAME,
	ALLOTTEDPCT,
	SOURCEDATE,
	INTERNALSTATUS,
	MFRPARTID,
	LT,
	RW,
	CW,
	MOQ,
	OI,
	DSCREATEUSER,
	DSCREATEDTS,
	DSUPDATEUSER,
	DSUPDATEDTS,
	CREATEUSER,
	CREATEDTS,
	UPDATEUSER,
	UPDATEDTS,
	SUPPLIERCONTACT,
	CONTACTPHONE,
	CONTACTEMAIL,
	CWP,
	ACTIVEFLAG,
	DELETEFLAG,
	VALIDFLAG,
	SOURCEDFLAG,
	CORRECTEDMPN,
	NOBIDCODE,
	NOBIDREASON,
	JPN,
	RETURNPRIVILEGES,
	RETURNPRIVILEGECONDITIONS,
	IPOSOURCEQUOTEITEMNBR,
	JCP,
	PRICESTATUS,
	SNFLK_UPDATEDON,
	HEADER_DSCREATEDTS,
	HEADER_DSUPDATEUSER,
	HEADER_DSUPDATEDTS,
	HEADER_CREATEUSER,
	HEADER_CREATEDTS,
	HEADER_UPDATEUSER,
	HEADER_UPDATEDTS,
	USESITEINGRID,
	HEADER_UPLOADBYSUPPLIER,
	HEADER_UPDATED_ON,
	SITEPARTCODE,
	EFFECTIVEREGION
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into FactSATQuotes
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-10      Venkata             Initial Revision

  */
SELECT  
     IFNULL(m.MaterialKey,0)                                                               AS MaterialKey
    ,IFNULL(p.PlantKey,0)                                                                  AS PlantKey
    ,IFNULL(dms.MarketSectorKey,0)                                                         AS MarketSectorKey
    ,IFNULL(mp.ManufacturerPartKey,0)                                                      AS ManufacturerPartKey
    ,IFNULL(man.ManufacturerKey,0)                                                         AS ManufacturerKey
    ,CAST(IFNULL(matgrp.MatGrpID,'') AS VARCHAR(50))                                       AS MaterialGroupCode
    ,CAST(IFNULL(matgrp.MatGrpDesc,'') AS VARCHAR(50))                                     AS LocalMaterialGroupName
    ,IFNULL(r.onhandqty,0)                                                                 AS OnHandQty 
    ,IFNULL(r.onorderqty,0)                                                                AS OnOrderQty 
    ,IFNULL(r.demandqty,0)                                                                 AS DemandQty
    ,0                                                                                     AS DemandQty90days --TODO Rene, this column needs to be added to md.v_Materialsummary
    ,CAST(IFNULL(satsp.workcell,'') AS VARCHAR(50))                                        AS workcell
    ,IFNULL(satsp.PP2,0)                                                                   AS PP2
    ,IFNULL(satsp.NetDemand,0)                                                             AS NetDemand
    ,IFNULL(qh.Quoteid,0)                                                                  AS Quoteid
    ,IFNULL(qh.uploadtype,0)                                                               AS uploadtype
    ,IFNULL(qh.Quotename,'')                                                               AS Quotename
    ,IFNULL(qh.dscreateuser,'')                                                            AS QuoteOwner    
    , case 
        when scu.firstname is null then CONCAT(IFNULL(scu1.firstname,''),IFNULL(scu1.lastname,''))
        else CONCAT(IFNULL(scu.firstname,''),IFNULL(scu.lastname,''))
      end                                                                                   AS QuoteOwnerLong
    ,IFNULL(qi.CreateDTS,CURRENT_TIMESTAMP())                                              AS LoadDate
    ,CASE 
        WHEN qh.UploadType IS NULL THEN 5
        WHEN qh.UploadType = 0 THEN CASE WHEN qi.JCP = 'TRUE' THEN 4 ELSE 1 END
        WHEN qh.UploadType = 3 THEN CASE WHEN qi.JCP = 'TRUE' THEN 4 ELSE qh.UploadType END
        ELSE qh.UploadType 
     END                                                                AS QuoteType
    ,IFNULL(qh.description,'')                                                             AS description
    ,IFNULL(qi.quoteitemnbr,0)                                                             AS quoteitemnbr
    ,IFNULL(qi.unitprice,0)                                                                AS Price
    ,IFNULL(cs.CurrencyStdCode,'')                                                         AS Currency
    ,IFNULL(cer.ExchangeRate,0)                                                            AS ExchangeRateKey  -- cer.ExchangeRateKey
    ,IFNULL(qi.currencystdid,0)                                                            AS currencystdid
    ,IFNULL(qi.exchangerate,0)                                                             AS exchangerate
    ,IFNULL(qi.quoteitemstatuscode,'')                                                     AS quoteitemstatuscode
    ,IFNULL(qi.validfromdate,'')                                                           AS StartDate
    ,IFNULL(qi.validtodate,'')                                                             AS EndDate
    ,IFNULL(qi.effectivityrule,'')                                                          AS effectivityrule
    ,IFNULL(qi.packagetypecode,'')                                                         AS PT
    ,IFNULL(qi.incoterms1,'')                                                              AS IT
    ,IFNULL(qi.incoterms2,'')                                                              AS COO
    ,IFNULL(qi.ncnr,0)                                                                     AS NCNR
    ,IFNULL(qi.paymentterms,'')                                                            AS paymentterms
    ,IFNULL(qi.comments,'')                                                                AS comments
    ,IFNULL(qi.contractpricing,0)                                                          AS CP
    ,IFNULL(c1.CorporationID,0)                                                            AS SupplierCode
    ,IFNULL(c1.CorporationName,'')                                                         AS suppliername
    ,IFNULL(qi.Customercorporationid,0)                                                    AS Customercorporationid
    ,IFNULL(qi.Suppliercorporationid,0)                                                    AS Suppliercorporationid
    , ''                                                                                   AS LastPOSupplierCorporationDSName
    , ''                                                                                   AS LastPOPricePerUnit
    , ''                                                                                   AS LastPOPOType
    , ''                                                                                   AS LastPOCreateDate
    , ''                                                                                   AS LastPOConsignment
    , ''                                                                                   AS LastPOMPN
    , ''                                                                                   AS LastPOMfr
    , ''                                                                                   AS LastPOGlobalCorporationName
    ,IFNULL(qspss.AllottedPct,0)                                                           AS AllottedPct
    ,IFNULL(qspss.SourceDate,CURRENT_TIMESTAMP())                                          AS SourceDate
    ,IFNULL(mp.InternalStatus,'')                                                          AS InternalStatus
    ,IFNULL(qi.mfrpartid,0)                                                                AS mfrpartid
    ,IFNULL(qi.planneddeliverytime,0)                                                      AS LT
    ,IFNULL(qi.reschedulewindow,0)                                                         AS RW
    ,IFNULL(qi.cancelationleadtime,0)                                                      AS CW
    ,IFNULL(qi.minimumqty,0)                                                               AS MOQ
    ,IFNULL(qi.multipleqty,0)                                                              AS OI
    ,IFNULL(qi.dscreateuser,'')                                                            AS dscreateuser
    ,IFNULL(qi.dscreatedts,CURRENT_TIMESTAMP())                                            AS dscreatedts
    ,IFNULL(qi.dsupdateuser,'')                                                            AS dsupdateuser
    ,IFNULL(qi.dsupdatedts,CURRENT_TIMESTAMP())                                            AS dsupdatedts
    ,IFNULL(qi.createuser,'')                                                              AS createuser
    ,IFNULL(qi.createdts,CURRENT_TIMESTAMP())                                              AS createdts
    ,IFNULL(qi.updateuser,'')                                                              AS updateuser
    ,IFNULL(qi.updatedts,CURRENT_TIMESTAMP())                                              AS Updatedts
    ,IFNULL(qi.contactname,'')                                                             AS SupplierContact
    ,IFNULL(qi.phone1,'')                                                                  AS ContactPhone
    ,IFNULL(qi.emailaddress,'')                                                            AS ContactEmail
    ,IFNULL(qi.corporateworkcellpricing,0)                                                 AS CWP
    ,IFNULL(qi.lastquoteflag,0)                                                            AS  ActiveFlag
    ,0                                                                                     AS DeleteFlag
    ,0                                                                                     AS ValidFlag
    ,CASE WHEN qspss.QuoteItemNbr IS NOT NULL THEN 1 ELSE 0 END                            AS SourcedFlag
    ,IFNULL(qi.correctedmpn,'')                                                            AS correctedmpn
    ,IFNULL(qi.nobid,0)                                                                    AS NoBidCode
    ,IFNULL(qi.nobidreason,'')                                                             AS NoBidReason
    ,IFNULL(qi.jpn,'')                                                                     AS jpn
    ,IFNULL(qi.returnprivileges,0)                                                         AS ReturnPrivileges
    ,IFNULL(qi.returnprivilegeconditions,'')                                               AS returnprivilegeconditions
    ,IFNULL(qi.iposourcequoteitemnbr,0)                                                    AS iposourcequoteitemnbr
    ,IFNULL(qi.jcp,0)                                                                      AS jcp
    ,IFNULL(qi.pricestatus,'')                                                             AS pricestatus
    ,IFNULL(qi.SNFLK_updatedon,'')                                                         AS SNFLK_updatedon
    ,IFNULL(qh.dscreatedts,CURRENT_TIMESTAMP())                                            AS header_dscreatedts
    ,IFNULL(qh.dsupdateuser,'')                                                            AS header_dsupdateuser
    ,IFNULL(qh.dsupdatedts,CURRENT_TIMESTAMP())                                            AS header_dsupdatedts
    ,IFNULL(qh.createuser,'')                                                              AS header_createuser
    ,IFNULL(qh.createdts,CURRENT_TIMESTAMP())                                              AS header_createdts
    ,IFNULL(qh.updateuser,'')                                                              AS header_updateuser
    ,IFNULL(qh.updatedts,CURRENT_TIMESTAMP())                                              AS header_updatedts
    ,IFNULL(qh.usesiteingrid,0)                                                            AS usesiteingrid
    ,IFNULL(qh.uploadbysupplier,'')                                                        AS header_uploadbysupplier
    ,IFNULL(qh.SNFLK_updatedon,'')                                                         AS header_updated_on
    --,IFNULL(fg.numberofquoteitems,0)                                                       AS numberofquoteitems
    ,IFNULL(satsp.SitePartCode,'')                                                         AS SitePartCode
    ,IFNULL(sg.sitegroupcode,'')                                                           AS effectiveregion
	
FROM
    conformed.V_SAT_SITEPARTQUOTELIST AS spql
    INNER JOIN SCMDB_SAT_SITEPART AS satsp ON  spql.SitePartID = satsp.sitepartid
    INNER JOIN SAP.DIMPLANTS AS p ON p.PlantCode = satsp.SiteCode
        AND p.DataSourceKey = 1
    INNER JOIN SAP.DIMMATERIALS AS m ON m.MaterialCode = satsp.SitePartCode
        AND m.PlantKey = p.PlantKey
    INNER JOIN SCMDB_SAT_QUOTEITEMTOSITEPART AS qitsp ON  satsp.SitePartID = qitsp.SitePartID
        AND spql.QuoteItemNbr = qitsp.QuoteItemNbr
    INNER JOIN SCMDB_QUOTEITEM AS qi ON qi.QuoteItemNbr = spql.QuoteItemNbr
    INNER JOIN SCMDB_QUOTEHEADER AS  qh ON qi.QuoteID = qh.QuoteID
	--INNER JOIN SCMDB.V_FACTSATQUOTES AS fg ON qh.QuoteID = fg.QuoteID
    INNER JOIN SCMDB_CORPORATION AS c1 ON qi.SupplierCorporationID = c1.CorporationID
    INNER JOIN SCMDB_CorporationDStoMarketSector AS cms ON satsp.MaterialGroupCorporationDSID = cms.corporationdsid
        AND satsp.siteid = cms.siteid
    INNER JOIN SAP.DimManufacturerParts AS  mp ON qi.MfrPartID = mp.srcMfrPartID
    INNER JOIN
    ( 
        SELECT
            DA.AMLKey
          , DA.ManufacturerPartKey
          , DA.ManufacturerKey
          , Row_Number() OVER ( PARTITION BY DA.ManufacturerPartKey ORDER BY da.DeleteFlag ASC, DA.CreatedOn ASC ) RN
       FROM
         SAP.DimAML AS DA
       WHERE
         DA.DataSourceKey = 1
    ) a ON a.ManufacturerPartKey = mp.ManufacturerPartKey        
       AND a.rn = 1
    INNER JOIN SAP.DimManufacturers AS  man ON man.ManufacturerKey = a.ManufacturerKey
    INNER JOIN SCMDB_MarketSector  AS msc ON cms.MarketSectorID = msc.MarketSectorID
    INNER JOIN SCMDB_MarketSectorToSegment AS msts ON msc.MarketSectorID = msts.MarketSectorID
    INNER JOIN SCMDB_MarketSegment AS msg ON msts.MarketSegmentID = msg.MarketSegmentID
    INNER JOIN SAP.DimMarketSectorS AS  dms ON TRIM(dms.MarketSector ) = LTRIM(RTRIM(msc.MarketSector))
        AND TRIM(dms.MarketSegment ) = LTRIM(RTRIM(msg.MarketSegment))
    INNER JOIN SCMDB_CURRENCYSTD AS  cs ON qi.CurrencyStdID = cs.CurrencyStdID
        AND qi.IPOSourceQuoteItemNbr IS NULL
    INNER JOIN sap.v_CurrentExchangeRate AS CER ON CER.DataSourceKey = 1
        AND CER.CurrencyCode = CurrencyStdCode
    LEFT OUTER JOIN SCMDB_SC_USERS_SAT AS scu ON qh.CreateUser = scu.UserID
    LEFT OUTER JOIN SCMDB_SC_USERS_SAT AS scu1 ON qh.CreateUser = scu1.WindowsUserID
    LEFT OUTER JOIN SCMDB_QUOTESITEPARTSOURCE AS qsps ON satsp.SitePartID = qsps.SitePartID
    LEFT OUTER JOIN SCMDB_QUOTESITEPARTSOURCESPLIT AS qspss ON qsps.SitePartID = qspss.SitePartID
        AND spql.QuoteItemNbr = qspss.QuoteItemNbr
    LEFT OUTER JOIN
    (
        SELECT DISTINCT
             cds.CorporationDSCode MatGrpID
            ,cds.CorporationDSName MatGrpDesc
            ,c.corporationid corporationid
        FROM
            SCMDB_CORPORATION c
            INNER JOIN SCMDB_CorporationDs cds ON c.CorporationID = cds.CorporationID
            INNER JOIN SCMDB_CorporationDSType cdst ON cds.CorporationDSTypeID = cdst.CorporationDSTypeID
            INNER JOIN SCMDB_CorporationDSTypeStd cdsts ON cdst.CorporationDSTypeStdID = cdsts.CorporationDSTypeStdID
                AND cdsts.CorporationDSTypeStdCode = 'MaterialGroup'
    ) matgrp ON matgrp.CorporationID = qi.SupplierCorporationID
    LEFT OUTER JOIN SAP.V_MATERIALSUMMARY AS r ON m.MaterialKey = r.MaterialKey  
    LEFT OUTER JOIN SCMDB_SITEGROUP SG ON qi.sitegroupid = SG.sitegroupid
WHERE
    qi.ValidToDate IS NOT NULL;
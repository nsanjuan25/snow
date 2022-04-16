create or replace view V_CANCELS(
	CURRENTQUARTER,
	NEXTQUARTER,
	CURRENTFYQUARTER,
	PLANTKEY,
	MATERIALCODE,
	PROFITCENTER,
	BUYERCODE,
	BUYERNAME,
	ABCCODE,
	DOCUMENTNUMBER,
	DOCUMENTITEM,
	DOCUMENTSCHEDULELINE,
	POQUANTITY,
	STANDARDUNITCOSTUSD,
	POVALUE,
	DELIVERYFINISHDTS,
	DELIVERYMONTHDATE,
	DELIVERYDATEQUARTERDATE,
	DELIVERYFYQUARTER,
	DELIVERYNEXTQUARTERDATE,
	DELIVERYQUARTERPLUS2MONTHSDATE,
	MRPCALCDATE,
	RESCHEDULINGDATE,
	RESCHEDULEMONTHDATE,
	RESCHEDULEQUARTERDATE,
	RESCHEDULEFYQUARTER,
	MRPRECOMMENDATIONCODE,
	MRPRECOMMENDATIONCODE2,
	FIXEDVENDOR,
	GLOBALSUPPLIERNAME,
	LOCALSUPPLIERNAME,
	MPNMATERIAL,
	MANUFACTURERPARTCODE,
	CANCELLATIONLEADTIME,
	RESCHEDULELEADTIME,
	INTRANSITLEADTIME,
	FIXEDLEADTIME,
	DOCKTOSTOCKLEADTIME,
	PURCHASEDOCUMENTTYPECODE,
	PAYMENTTERMS,
	NCNRFLAG,
	MRPELEMENTINDICATOR,
	MRPTYPESTDCODE,
	MRPTYPECODE,
	FIRMEDCOMPONENTFLAG,
	FIRMEDORDERFLAG,
	PLANNINGPRODUCTIONPLANT,
	PROCESSINGRULE,
	SPECIALSTOCKSCODE,
	DSCREATEDTS,
	POTYPE,
	EOQFLAG,
	RESCHEDULEEOQFLAG,
	MONTHFLAG,
	RESCHEDULABLE,
	CANCELLABLE,
	CANCELLABLE_EXEC,
	DOCUMENTNUMBER_EXEC,
	DOCUMENTITEM_EXEC,
	DOCUMENTSCHEDULELINE_EXEC,
	POQUANTITY_EXEC,
	POVALUE_EXEC,
	DELIVERYDATE_EXEC,
	RESCHEDULINGDATE_EXEC,
	MRPRECOMMENDATIONCODE_EXEC,
	MRPRECOMMENDATIONCODE2_EXEC,
	DOCUMENTNUMBER_EXECL,
	DOCUMENTITEM_EXECL,
	POQUANTITY_EXECL,
	POVALUE_EXECL,
	DELIVERYDATE_EXECL,
	RESCHEDULINGDATE_EXECL,
	MRPRECOMMENDATIONCODE_EXECL,
	MRPRECOMMENDATIONCODE2_EXECL,
	RECEIPTQUANTITY_EXEC,
	RECEIPTVALUE_EXEC,
	POFLAG_EXEC,
	POFLAG_EXECL,
	RECEIPTFLAG_EXEC,
	QUANTITYFLAG_EXEC,
	QUANTITYFLAG_EXECL,
	DELIVERYDATEFLAG_EXEC,
	DELIVERYDATEFLAG_EXECL,
	PUSHOUTWEEK1PRIORITY,
	PUSHOUTWEEK2PRIORITY,
	PUSHOUTWEEK3PRIORITY,
	PUSHOUTWEEK4PRIORITY,
	CANCELWEEK1PRIORITY,
	CANCELWEEK2PRIORITY,
	CANCELWEEK3PRIORITY,
	CANCELWEEK4PRIORITY,
	PUSHOUTEOQRESCHEXEC,
	PUSHOUTEOQNONRESCHEXEC,
	TOTALPUSHOUTEOQEXEC,
	PUSHOUTWK1P1_EXEC,
	POEXECUTION,
	CANCELLABLEEXEC,
	NONCANCELLABLEEXEC,
	TOTALCANCELEXEC,
	CANCELWK1P1_EXEC,
	CANCELEXECUTION,
	EXECUTIONFLAG,
	EXECUTIONVALUE,
	EXECUTIONVALUEFINAL,
	RECEIPTISSUEINDICATOR,
	SHIPPINGINSTRUCTIONS,
	SNAPSHOTDATE,
	METRICTYPE,
	DATASOURCEKEY,
	FISCALQUARTERSTARTDATEKEY
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.FactPOPushOutCancelsSummary
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-29      Carlos Carrillo             Initial Revision
                                        
*/

SELECT 

       TO_CHAR(TO_DATE(MON.MRPfiscalquarter), 'yyyyMMdd')                                                    AS currentquarter
     , TO_CHAR(ADD_MONTHS(TO_DATE(MON.MRPfiscalquarter), 3) , 'yyyyMMdd')                                    AS NextQuarter
     , concat('FY', substr(CAST(MON.MRPfiscalyear AS STRING), 3, 2), '-Q', CAST(MON.MRPFiscalquarternumber AS STRING)) AS CurrentFYQuarter
     , plantkey
     , materialcode
     , profitcenter
     , buyercode
     , buyername
     , abccode
     , documentnumber
     , documentitem
     , documentscheduleline
     , POQuantity
     , standardunitcostusd
     , POValue
     , deliveryfinishdts
     , TO_CHAR(TO_DATE(MON.startmonthdatekey), 'yyyyMMdd')                                                 AS DeliveryMonthDate
     , TO_CHAR(TO_DATE(MON.fiscalquarterstartdatekey ), 'yyyyMMdd')                                         AS DeliveryDateQuarterDate
     , concat('FY', substr(CAST(MON.fiscalyear AS STRING), 3, 2), '-Q', CAST(MON.Fiscalquarternumber AS STRING))       AS DeliveryFYQuarter
     , TO_CHAR(ADD_MONTHS(TO_DATE(MON.fiscalquarterstartdatekey), 3) , 'yyyyMMdd')                         AS DeliveryNextQuarterDate
     , TO_CHAR(ADD_MONTHS(TO_DATE(MON.fiscalquarterstartdatekey), 2)  , 'yyyyMMdd')                        AS DeliveryQuarterplus2monthsDate
     , mrpcalcdate
     , Reschedulingdate
     , ''                                                                                                              AS RescheduleMonthDate
     , RescheduleQuarterDate
     , RescheduleFYQuarter
     , mrprecommendationcode
     , mrprecommendationcode2
     , fixedvendor
     , globalsuppliername
     , localsuppliername
     , mpnmaterial
     , manufacturerpartcode
     , cancellationleadtime
     , Rescheduleleadtime
     , Intransitleadtime
     , fixedleadtime
     , docktostockleadtime
     , purchasedocumenttypecode
     , paymentterms
     , ncnrflag
     , mrpelementindicator
     , mrptypestdcode
     , mrptypecode
     , firmedcomponentflag
     , firmedorderflag
     , planningproductionplant
     , processingrule
     , specialstockscode
     , dscreatedts
     , CASE
           WHEN mrpelementindicator = 'LA' then
               'confirmedPO'
           else
               mrptypestdcode
       END                                                                                                   AS POTYPE
    ,CASE WHEN CAST(DATEADD(day, CAST(MON.docktostockleadtime AS INTEGER) * -1,MON.mrpcalcdate) AS DATE ) >=  ADD_MONTHS(CAST(MON.fiscalquarterstartdatekey AS date), 3)
		 THEN 'YES'
			ELSE 'NO'
		END AS EOQFlag
	,CASE 
		WHEN     CAST(DATEADD(day, CAST(MON.docktostockleadtime AS INTEGER) * -1,MON.mrpcalcdate) AS DATE ) >= ADD_MONTHS(CAST(MON.fiscalquarterstartdatekey AS date), 3)
			 AND CAST(DATEADD(day, CAST(MON.docktostockleadtime AS INTEGER) * -1,MON.mrpcalcdate) AS DATE ) >= ADD_MONTHS(CAST(MON.MRPFiscalQuarter AS date), 3)
			THEN 'YES'
		ELSE 'NO'
		END RescheduleEOQFlag
	,CASE 
		WHEN CAST(DATEADD(day, CAST(MON.docktostockleadtime AS INTEGER) * -1,MON.mrpcalcdate) AS DATE ) >=      ADD_MONTHS(CAST(MON.fiscalquarterstartdatekey AS date), 3)
			AND CAST(DATEADD(day, CAST(MON.docktostockleadtime AS INTEGER) * -1,MON.mrpcalcdate) AS DATE ) <    ADD_MONTHS(CAST(MON.fiscalquarterstartdatekey AS date), 3)
			AND MON.deliveryfinishdts <                                                                         ADD_MONTHS(CAST(MON.fiscalquarterstartdatekey AS date), 3)
			THEN 'YES'
		ELSE 'NO'
		END MonthFlag
	,CASE 
		WHEN cast(MON.deliveryfinishdts as date) > CAST(DATEADD(day, CAST(MON.Rescheduleleadtime AS INTEGER) ,(SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 ))) AS DATE )
			AND MON.Rescheduleleadtime NOT IN (911,998)
			AND MON.cancellationleadtime <> 998
			THEN 'YES'
		ELSE 'NO'
		END  Reschedulable
	,CASE 
		WHEN cast(MON.deliveryfinishdatekey as date) > CAST(DATEADD(day, CAST(MON.cancellationleadtime AS INTEGER) ,(SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 ))) AS DATE )
			AND MON.cancellationleadtime NOT IN (
				999
				,998
				)
			THEN 'YES'
		ELSE 'NO'
		END AS Cancellable
     , ''                                                                                                              AS Cancellable_exec
     , ''                                                                                                              AS documentnumber_exec
     , ''                                                                                                              AS documentitem_exec
     , ''                                                                                                              AS documentscheduleline_exec
     , 0                                                                                                               AS POQuantity_exec
     , 0                                                                                                               AS POValue_exec
     , ''                                                                                                              AS Deliverydate_exec
     , ''                                                                                                              AS Reschedulingdate_exec
     , ''                                                                                                              AS mrprecommendationcode_exec
     , ''                                                                                                              AS mrprecommendationcode2_exec
     , ''                                                                                                              AS documentnumber_execl
     , ''                                                                                                              AS documentitem_execl
     , 0                                                                                                               AS POQuantity_execl
     , 0                                                                                                               AS POValue_execl
     , ''                                                                                                              AS Deliverydate_execl
     , ''                                                                                                              AS Reschedulingdate_execl
     , ''                                                                                                              AS mrprecommendationcode_execl
     , ''                                                                                                              AS mrprecommendationcode2_execl
     , 0                                                                                                               AS ReceiptQuantity_exec
     , 0                                                                                                               AS ReceiptValue_exec
     , ''                                                                                                              AS POFlag_exec
     , ''                                                                                                              AS POFlag_execl
     , ''                                                                                                              AS ReceiptFlag_exec
     , ''                                                                                                              AS QuantityFlag_exec
     , ''                                                                                                              AS QuantityFlag_execl
     , ''                                                                                                              AS DeliveryDateFlag_exec
     , ''                                                                                                              AS DeliveryDateFlag_execl
     ,CASE 
		WHEN MON.deliveryfinishdts > DATEADD(day,7 +  CAST(MON.Rescheduleleadtime AS INT),TRUNC(CAST((SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 )) AS DATE), 'DAY'))
			THEN 'NO'
		ELSE 'YES'
		END AS PushoutWeek1Priority
	,CASE 
		WHEN MON.deliveryfinishdts > DATEADD(day,14 +  CAST(MON.Rescheduleleadtime AS INT),TRUNC(CAST((SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 )) AS DATE), 'DAY'))
			THEN 'NO'
		ELSE 'YES'
		END AS PushoutWeek2Priority
	,CASE 
		WHEN MON.deliveryfinishdts > DATEADD(day,21 +  CAST(MON.Rescheduleleadtime AS INT),TRUNC(CAST((SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 )) AS DATE), 'DAY'))
			THEN 'NO'
		ELSE 'YES'
		END AS PushoutWeek3Priority
	,CASE 
		WHEN MON.deliveryfinishdts > DATEADD(day,28 +  CAST(MON.Rescheduleleadtime AS INT),TRUNC(CAST((SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 )) AS DATE), 'DAY'))
			THEN 'NO'
		ELSE 'YES'
		END AS PushoutWeek4Priority
    
    ,CASE 
		WHEN MON.deliveryfinishdts > DATEADD(day,7 +  CAST(MON.cancellationleadtime  AS INT),TRUNC(CAST((SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 )) AS DATE), 'DAY'))
			THEN 'NO'
		ELSE 'YES'
		END AS CancelWeek1Priority
	,CASE 
	    WHEN MON.deliveryfinishdts > DATEADD(day,14 +  CAST(MON.cancellationleadtime  AS INT),TRUNC(CAST((SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 )) AS DATE), 'DAY'))
			THEN 'NO'
		ELSE 'YES'
		END AS CancelWeek2Priority
	,CASE 
		WHEN MON.deliveryfinishdts > DATEADD(day,21 +  CAST(MON.cancellationleadtime  AS INT),TRUNC(CAST((SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 )) AS DATE), 'DAY'))
			THEN 'NO'
		ELSE 'YES'
		END AS CancelWeek3Priority
	,CASE 
		WHEN MON.deliveryfinishdts > DATEADD(day,28 +  CAST(MON.cancellationleadtime  AS INT),TRUNC(CAST((SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 )) AS DATE), 'DAY'))
			THEN 'NO'
		ELSE 'YES'
		END AS CancelWeek4Priority
  
     , 0                                                                                                               AS PushOutEOQReschExec
     , 0                                                                                                               AS PushOutEOQNONReschExec
     , 0                                                                                                               AS TotalPushOutEOQExec
     , 0                                                                                                               AS PushOutWk1P1_exec
     , 0                                                                                                               AS POExecution
     , 0                                                                                                               AS CancellableExec
     , 0                                                                                                               AS NonCancellableExec
     , 0                                                                                                               AS TotalCancelExec
     , 0                                                                                                               AS CancelWk1P1_exec
     , 0                                                                                                               AS CancelExecution
     , ''                                                                                                              AS ExecutionFlag
     , 0                                                                                                               AS ExecutionValue
     , 0                                                                                                               AS ExecutionValuefinal
     , receiptissueindicator
     , ''                                                                                                              AS Shippinginstructions
     , CAST(MON.snapshotdate AS date)                                                                                  AS snapshotdate
     , metrictype
     , DataSourceKey
     , MON.fiscalquarterstartdatekey
FROM
(
    SELECT CASE
               WHEN SP.buyercode IS NULL THEN
                   B.buyercode
               else
                   BB.buyercode
           END                                                                                             AS buyercode
         , SP.abccode
         , CASE
               WHEN SP.buyercode IS NULL THEN
                   BB.FIRSTNAME || ' ' || BB.LASTNAME
               else
                   B.FIRSTNAME || ' ' || B.LASTNAME
           END                                                                                             AS buyername
         , MRP.Snapshotdate
         , 'C'                                                                                             AS metrictype
         , MRP.DataSourceKey
         , P.plantkey
         , SP.profitcentercode                                                                             AS ProfitCenter
         , SP.materialcode
         , MRP.documentnumber
         , MRP.documentitem
         , MRP.documentscheduleline
         , MRP.quantity                                                                                    AS POQuantity
		 , MRP.deliveryfinishdatekey
         , SP.STANDARDUNITCOSTINUSD                                                                        AS standardunitcostusd
         , MRP.quantity * SP.STANDARDUNITCOSTINUSD                                                         AS POValue
         , MRP.DeliveryFinishDateKey AS deliveryfinishdts
         , DeliveryDate.fiscalquarterstartdatekey
         , DeliveryDate.startmonthdatekey
         , DeliveryDate.fiscalyear
         , DeliveryDate.Fiscalquarternumber
         , MRPSnapshotdate.fiscalquarterstartdatekey                                                       AS MRPfiscalquarter
         , MRPSnapshotdate.fiscalyear                                                                      AS MRPfiscalyear
         , MRPSnapshotdate.Fiscalquarternumber                                                             AS MRPFiscalquarternumber
         , MRP.RescheduleToDateKey                                                                         AS mrpcalcdate
         , to_timestamp(to_date(DATEADD(days, CAST(SP.docktostockleadtime AS int) * -1, MRP.RescheduleToDateKey))) AS Reschedulingdate
         , RescheduleDate.fiscalquarterstartdatekey             AS RescheduleQuarterDate
         , CONCAT(
                     'FY'
                   , substr(CAST(RescheduleDate.fiscalyear AS STRING), 3, 2)
                   , '-Q'
                   , CAST(RescheduleDate.Fiscalquarternumber AS STRING)
                 )                                                                                         AS RescheduleFYQuarter
         , MRP.mrprecommendationcode
         , MRP.mrprecommendationcode2
         , MRP.fixedvendor
         , COALESCE (c.globalsuppliername, '')                                                             AS globalsuppliername
         , MRP.mpnmaterial
         , MP.manufacturerpartcode
         , IFNULL(MRP.cancellationleadtime,0)                                                                        AS cancellationleadtime
         , IFNULL(PO.poreminder1,0)                                                                                  AS Intransitleadtime
         , IFNULL(PO.poreminder2,0)                                                                                  AS Rescheduleleadtime
         , IFNULL(SP.fixedleadtime,0)                                                                                AS fixedleadtime
         , IFNULL(SP.docktostockleadtime,0)                                                                          AS docktostockleadtime
         , PDT.purchasedocumenttypecode
         , PT.paymentterms
         , MRP.ncnrflag
         , MRP.mrptypestdcode
         , MRP.mrpelementindicator
         , MRP.mrptypecode
         , MRP.firmedcomponentflag
         , MRP.firmedorderflag
         , MRP.planningproductionplant
         , MRP.processingrule
         , MRP.receiptissueindicator
         , COALESCE (c.localsuppliername, '')                                                               localsuppliername
         , SS.specialstockscode
         , PO.PURCHASEORDERCREATEDDATEKEY                                                                  AS dscreatedts
    FROM SAP.FactMRPHistorical                       AS MRP
        LEFT OUTER JOIN SAP.DimMaterials             AS SP
            ON SP.DataSourceKey = MRP.DataSourceKey
               AND SP.MATERIALKEY = MRP.MATERIALKEY
               AND SP.PlantKey = MRP.PlantKey
               AND
               (
                   MRP.mrprecommendationcode = 'U3'
                   OR MRP.mrprecommendationcode2 = 'U3'
                   OR MRP.mrprecommendationcode = 'U7'
                   OR MRP.mrprecommendationcode2 = 'U7'
               )
        LEFT OUTER JOIN SAP.FactPurchaseOrders       AS PO
            ON PO.DataSourceKey = MRP.DataSourceKey
               AND PO.MaterialKey = MRP.MaterialKey
               AND PO.PlantKey = MRP.PlantKey
               AND PO.purchasedocumentnumber = MRP.documentnumber
               AND CAST(PO.purchasedocumentitem AS int) = CAST(MRP.documentitem AS int)
               AND PO.SPECIALSTOCKSKEY in
                   (
                       SELECT SPECIALSTOCKSKEY
                       FROM sap.DimSpecialStocks
                       WHERE specialstockscode <> 'O'
                   )
               AND PO.PURCHASEDOCUMENTTYPEKEY not in
                   (
                       SELECT PURCHASEDOCUMENTTYPEKEY
                       FROM SAP.DIMPURCHASEDOCUMENTTYPES
                       WHERE PURCHASEDOCUMENTTYPECODE in ( 'ZSM')
                   )
        LEFT OUTER JOIN SAP.DimBuyers                AS B
            ON B.DataSourceKey = SP.DataSourceKey
               AND B.BuyerKey = SP.BuyerKey
        LEFT OUTER JOIN SAP.DimBuyers                AS BB
            ON BB.DataSourceKey = PO.DataSourceKey
               AND BB.BuyerKey = PO.BuyerKey
        LEFT OUTER JOIN SAP.DimPlants                AS P
            ON P.DataSourceKey = MRP.DataSourceKey
               AND P.PlantKey = MRP.PlantKey
        LEFT OUTER JOIN sap.DimSuppliers             C
            ON MRP.DataSourceKey = C.DataSourceKey
               AND MRP.fixedvendor = C.SupplierCode
        LEFT OUTER JOIN public.DIMDATES            AS DeliveryDate
            ON DeliveryDate.DATEKEY = MRP.DELIVERYFINISHDATEKEY
        LEFT OUTER JOIN public.DIMDATES            AS RescheduleDate
            ON RescheduleDate.DATEKEY = to_date(DATEADD(days, CAST(SP.docktostockleadtime AS INT) * -1, MRP.RescheduleToDateKey))
        LEFT OUTER JOIN public.DIMDATES            AS MRPSnapshotdate
            ON MRPSnapshotdate.DATEKEY = to_date(MRP.snapshotdate)
        LEFT OUTER JOIN sap.DimSpecialStocks         AS SS
            ON PO.DataSourceKey = SS.DataSourceKey
               AND PO.SPECIALSTOCKSKEY = SS.SPECIALSTOCKSKEY
        LEFT OUTER JOIN sap.DimPaymentTerms          AS PT
            ON PO.DataSourceKey = PT.DataSourceKey
               AND PO.PAYMENTTERMKEY = PT.PAYMENTTERMKEY
        LEFT OUTER JOIN sap.DimPurchaseDocumentTypes AS PDT
            ON PO.DataSourceKey = PDT.DataSourceKey
               AND PO.PURCHASEDOCUMENTTYPEKEY = PDT.PURCHASEDOCUMENTTYPEKEY
        LEFT OUTER JOIN sap.DimManufacturerParts     AS MP
            ON MP.DataSourceKey = PO.DataSourceKey
               AND MP.MANUFACTURERPARTKEY = PO.MANUFACTURERPARTKEY
    WHERE 
          CAST(MRP.snapshotdate AS DATE) = (SELECT MAX(datekey) FROM public.DIMDATES WHERE DAYNUMBERWEEK = 1 AND DATEKEY <= (CURRENT_DATE - 21 ))
          AND  MRP.receiptissueindicator = '+'
          AND COALESCE (MRP.mrpelementindicator, '') <> 'PA'
          AND COALESCE (MRP.mrpelementindicator, '') <> 'QM'
          AND COALESCE (MRP.mrpelementindicator, '') not like 'BA%'
          AND
          (
              MRP.mrprecommendationcode = 'U3'
              OR MRP.mrprecommendationcode2 = 'U3'
              OR MRP.mrprecommendationcode = 'U7'
              OR MRP.mrprecommendationcode2 = 'U7'
          )
AND SP.Makebuy = 'Buy'


) MON;
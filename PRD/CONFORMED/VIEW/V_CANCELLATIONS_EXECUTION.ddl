create or replace view V_CANCELLATIONS_EXECUTION(
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
	DATASOURCEKEY
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
     currentquarter
    ,NextQuarter
    ,CurrentFYQuarter
    ,plantkey
    ,MATERIALcode
    ,profitcenter
    ,buyercode
    ,buyername
    ,abccode
    ,documentnumber
    ,documentitem
    ,documentscheduleline
    ,POQuantity
    ,standardunitcostusd
    ,POValue
    ,deliveryfinishdts
    ,DeliveryMonthDate
    ,DeliveryDateQuarterDate
    ,DeliveryFYQuarter
    ,DeliveryNextQuarterDate
    ,DeliveryQuarterplus2monthsDate
    ,mrpcalcdate
    ,Reschedulingdate
    ,RescheduleMonthDate
    ,RescheduleQuarterDate
    ,RescheduleFYQuarter
    ,mrprecommendationcode
    ,mrprecommendationcode2
    ,fixedvendor
    ,globalsuppliername
    ,localsuppliername
    ,mpnmaterial
    ,manufacturerpartcode
    ,cancellationleadtime
    ,Rescheduleleadtime
    ,Intransitleadtime
    ,fixedleadtime
    ,docktostockleadtime
    ,purchasedocumenttypecode
    ,paymentterms
    ,ncnrflag
    ,mrpelementindicator
    ,mrptypestdcode
    ,mrptypecode
    ,firmedcomponentflag
    ,firmedorderflag
    ,planningproductionplant
    ,processingrule
    ,specialstockscode
    ,dscreatedts
    ,POTYPE
    ,EOQFlag
    ,RescheduleEOQFlag
    ,MonthFlag
    ,Reschedulable
    ,Cancellable
    ,cancellable_exec
    ,documentnumber_exec
    ,documentitem_exec
    ,documentscheduleline_exec
    ,POQuantity_exec
    ,POValue_exec
    ,Deliverydate_exec
    ,Reschedulingdate_exec
    ,mrprecommendationcode_exec
    ,mrprecommendationcode2_exec
    ,documentnumber_execl
    ,documentitem_execl
    ,POQuantity_execl
    ,POValue_execl
    ,Deliverydate_execl
    ,Reschedulingdate_execl
    ,mrprecommendationcode_execl
    ,mrprecommendationcode2_execl
    ,ReceiptQuantity_exec
    ,ReceiptValue_exec
    ,POFlag_exec
    ,POFlag_execl
    ,ReceiptFlag_exec
    ,QuantityFlag_exec
    ,QuantityFlag_execl
    ,DeliveryDateFlag_exec
    ,DeliveryDateFlag_execl
    ,PushoutWeek1Priority
    ,PushoutWeek2Priority
    ,PushoutWeek3Priority
    ,PushoutWeek4Priority
    ,CancelWeek1Priority
    ,CancelWeek2Priority
    ,CancelWeek3Priority
    ,CancelWeek4Priority
    ,0                             AS PushOutEOQReschExec
    ,0                             AS PushOutEOQNONReschExec
    ,0                             AS TotalPushOutEOQExec
    ,0                             AS PushOutWk1P1_exec
    ,0                             AS POExecution
    ,CASE
         WHEN ExecutionFlag = 'YES'
              AND Cancellable = 'YES' THEN ExecutionValue
     END                           AS CancellableExec
    ,CASE
         WHEN ExecutionFlag = 'YES'
              AND Cancellable = 'NO' THEN ExecutionValue
     END                           AS NonCancellableExec
    ,CASE
         WHEN (
                  ExecutionFlag = 'YES'
                  AND Cancellable = 'YES'
              )
              OR (
                     ExecutionFlag = 'YES'
                     AND Cancellable = 'NO'
                 ) THEN ExecutionValue
     END                           AS TotalCancelExec
    ,CASE
         WHEN ExecutionFlag = 'YES'
              AND Cancellable = 'YES'
              AND CancelWeek1Priority = 'YES' THEN ExecutionValue
     END                           AS CancelWk1P1_exec
    ,CancelExecution
    ,ExecutionFlag
    ,ExecutionValue
    ,ExecutionValuefinal
    ,receiptissueindicator
    ,Shippinginstructions
    ,snapshotdate
    ,'CE'                          AS metrictype
    ,datasourcekey
FROM (
         SELECT
              DataSourceKey
             ,currentquarter
             ,NextQuarter
             ,CurrentFYQuarter
             ,plantkey
             ,MATERIALcode
             ,profitcenter
             ,buyercode
             ,buyername
             ,abccode
             ,documentnumber
             ,documentitem
             ,documentscheduleline
             ,POQuantity
             ,standardunitcostusd
             ,POValue
             ,deliveryfinishdts
             ,DeliveryMonthDate
             ,DeliveryDateQuarterDate
             ,DeliveryFYQuarter
             ,DeliveryNextQuarterDate
             ,DeliveryQuarterplus2monthsDate
             ,mrpcalcdate
             ,Reschedulingdate
             ,RescheduleMonthDate
             ,RescheduleQuarterDate
             ,RescheduleFYQuarter
             ,mrprecommendationcode
             ,mrprecommendationcode2
             ,fixedvendor
             ,globalsuppliername
             ,localsuppliername
             ,mpnmaterial
             ,manufacturerpartcode
             ,cancellationleadtime
             ,Rescheduleleadtime
             ,Intransitleadtime
             ,fixedleadtime
             ,docktostockleadtime
             ,purchasedocumenttypecode
             ,paymentterms
             ,ncnrflag
             ,mrpelementindicator
             ,mrptypestdcode
             ,mrptypecode
             ,firmedcomponentflag
             ,firmedorderflag
             ,planningproductionplant
             ,processingrule
             ,specialstockscode
             ,dscreatedts
             ,POTYPE
             ,EOQFlag
             ,RescheduleEOQFlag
             ,MonthFlag
             ,Reschedulable
             ,Cancellable
             ,cancellable_exec
             ,documentnumber_exec
             ,documentitem_exec
             ,documentscheduleline_exec
             ,POQuantity_exec
             ,POValue_exec
             ,Deliverydate_exec
             ,Reschedulingdate_exec
             ,mrprecommendationcode_exec
             ,mrprecommendationcode2_exec
             ,documentnumber_execl
             ,documentitem_execl
             ,POQuantity_execl
             ,POValue_execl
             ,Deliverydate_execl
             ,Reschedulingdate_execl
             ,mrprecommendationcode_execl
             ,mrprecommendationcode2_execl
             ,ReceiptQuantity_exec
             ,ReceiptValue_exec
             ,POFlag_exec
             ,POFlag_execl
             ,ReceiptFlag_exec
             ,QuantityFlag_exec
             ,QuantityFlag_execl
             ,DeliveryDateFlag_exec
             ,DeliveryDateFlag_execl
             ,PushoutWeek1Priority
             ,PushoutWeek2Priority
             ,PushoutWeek3Priority
             ,PushoutWeek4Priority
             ,CancelWeek1Priority
             ,CancelWeek2Priority
             ,CancelWeek3Priority
             ,CancelWeek4Priority
             ,CASE
                  WHEN CancelExec.POFlag_exec = 'YES' THEN
                      CASE
                          WHEN CancelExec.DeliveryDateFlag_exec = 'NO'
                               AND CancelExec.Deliverydate_exec >= CancelExec.DeliveryNextQuarterDate
                               AND CancelExec.QuantityFlag_exec = 'YES' THEN 1
                          WHEN CancelExec.DeliveryDateFlag_exec = 'NO'
                               AND CancelExec.Deliverydate_exec >= CancelExec.DeliveryNextQuarterDate
                               AND CancelExec.QuantityFlag_exec = 'NO'
                               AND CancelExec.POQuantity < CancelExec.POQuantity_exec THEN 1
                          WHEN CancelExec.DeliveryDateFlag_exec = 'NO'
                               AND CancelExec.Deliverydate_exec >= CancelExec.DeliveryNextQuarterDate
                               AND CancelExec.QuantityFlag_exec = 'NO'
                               AND CancelExec.POQuantity > CancelExec.POQuantity_exec
                               AND CancelExec.ReceiptQuantity_exec = 0 THEN 2
                          WHEN CancelExec.DeliveryDateFlag_exec = 'NO'
                               AND CancelExec.Deliverydate_exec >= CancelExec.DeliveryNextQuarterDate
                               AND CancelExec.QuantityFlag_exec = 'NO'
                               AND CancelExec.ReceiptQuantity_exec > 0 THEN 3
                          WHEN CancelExec.mrprecommendationcode <> CancelExec.mrprecommendationcode_exec
                               AND CancelExec.mrprecommendationcode_exec <> 'U3'
                               AND CancelExec.mrprecommendationcode_exec <> 'U7' THEN 5
                          WHEN CancelExec.Cancellable = 'YES'
                               AND CancelExec.CancelWeek1Priority = 'YES' THEN 7
                          WHEN CancelExec.DeliveryDateFlag_exec = 'YES'
                               AND CancelExec.QuantityFlag_exec = 'NO'
                               AND CancelExec.POQuantity > CancelExec.POQuantity_exec
                               AND CancelExec.ReceiptQuantity_exec = 0 THEN 8
                          WHEN CancelExec.mrprecommendationcode = CancelExec.mrprecommendationcode_exec
                               AND CancelExec.Deliverydate_exec <= CancelExec.DeliveryNextQuarterDate
                               AND CancelExec.Deliverydate_exec < CancelExec.DELIVERYFINISHDTS
                               AND CancelExec.Cancellable = 'YES'
                               AND CancelExec.cancellable_exec = 'YES' THEN 9
                          WHEN CancelExec.mrprecommendationcode = CancelExec.mrprecommendationcode_exec
                               AND CancelExec.Cancellable = 'NO'
                               AND (
                                       CancelExec.ncnrflag <> 'TRUE'
                                       OR CancelExec.Cancellationleadtime < 900
                                   ) THEN 10
                          WHEN CancelExec.Cancellationleadtime = 999 THEN 12
                          WHEN CancelExec.Cancellationleadtime = 998 THEN 11
                          WHEN CancelExec.Cancellable = 'YES'
                               AND CancelExec.CancelWeek1Priority = 'NO' THEN 13
                          ELSE 14
                      END
                  ELSE
                      CASE
                          WHEN CancelExec.POFlag_execl = 'YES'
                               AND CancelExec.POFlag_exec = 'NO'
                               AND CancelExec.ReceiptFlag_exec = 'NO' THEN
                              CASE
                                  WHEN CancelExec.ReceiptQuantity_exec > 0
                                       AND CancelExec.DeliveryDateFlag_execl = 'NO'
                                       AND CancelExec.Deliverydate_execl >= CancelExec.DeliveryNextQuarterDate
                                       AND CancelExec.QuantityFlag_execl = 'NO'
                                       AND CancelExec.POQuantity > CancelExec.POQuantity_execl THEN 2
                                  WHEN CancelExec.ReceiptQuantity_exec = 0
                                       AND CancelExec.DeliveryDateFlag_execl = 'NO'
                                       AND CancelExec.Deliverydate_execl >= CancelExec.DeliveryNextQuarterDate
                                       AND CancelExec.QuantityFlag_execl = 'YES' THEN 1
                                  ELSE 14
                              END
                          WHEN CancelExec.POFlag_execl = 'NO'
                               AND CancelExec.POFlag_exec = 'NO'
                               AND CancelExec.ReceiptFlag_exec = 'NO' THEN
                              CASE
                                  WHEN CancelExec.ReceiptQuantity_exec = 0 THEN 16
                                  WHEN CancelExec.ReceiptQuantity_exec > 0 THEN 17
                              END
                          WHEN CancelExec.POFlag_exec = 'NO'
                               AND CancelExec.ReceiptFlag_exec = 'YES' THEN 20
                          ELSE 18
                      END
              END                           CancelExecution
             ,CASE
                  WHEN CancelExec.POFlag_exec = 'NO' THEN
                      CASE
                          WHEN (
                                   CancelExec.ReceiptFlag_exec = 'NO'
                                   AND CancelExec.POFlag_execl = 'NO'
                                   AND CancelExec.ReceiptQuantity_exec = 0
                               ) -- 'Cancelled Or PO Qty Reduced'

                               OR (
                                      CancelExec.ReceiptFlag_exec = 'NO'
                                      AND CancelExec.POFlag_execl = 'NO'
                                      AND CancelExec.ReceiptQuantity_exec > 0
                                  ) -- 'PO Quantity Reduced'

             THEN                                                 'YES'
                          ELSE 'NO'
                      END
                  ELSE 'NO'
              END                           ExecutionFlag
             ,CASE
                  WHEN CancelExec.POFlag_exec = 'YES' THEN
                      CASE
                          WHEN (
                                   CancelExec.DeliveryDateFlag_exec = 'NO'
                                   AND CancelExec.Deliverydate_exec >= CancelExec.DeliveryNextQuarterDate
                                   AND CancelExec.QuantityFlag_exec = 'NO'
                                   AND CancelExec.POQuantity > CancelExec.POQuantity_exec
                                   AND CancelExec.ReceiptQuantity_exec = 0
                               ) --  'Pushout Executed Partial'

                               OR (
                                      CancelExec.DeliveryDateFlag_exec = 'NO'
                                      AND CancelExec.Deliverydate_exec >= CancelExec.DeliveryNextQuarterDate
                                      AND CancelExec.QuantityFlag_exec = 'NO'
                                      AND CancelExec.ReceiptQuantity_exec > 0
                                  ) --  'Pushout Exec - Early Receipt'

             THEN                                                  CancelExec.POValue_exec
                          ELSE CancelExec.POValue
                      END
                  ELSE
                      CASE
                          WHEN CancelExec.POFlag_execl = 'YES'
                               AND CancelExec.POFlag_exec = 'NO' THEN
                              CASE
                                  WHEN (
                                           CancelExec.ReceiptFlag_exec = 'NO'
                                           AND CancelExec.ReceiptQuantity_exec > 0
                                           AND CancelExec.DeliveryDateFlag_execl = 'NO'
                                           AND CancelExec.Deliverydate_execl >= CancelExec.DeliveryNextQuarterDate
                                           AND CancelExec.QuantityFlag_execl = 'NO'
                                           AND CancelExec.POQuantity > CancelExec.POQuantity_execl
                                       ) --THEN 'Pushout Executed Partial - LINE'


             THEN                                                              CancelExec.POValue_execl
                                  ELSE CancelExec.POValue
                              END
                          ELSE
                              CASE
                                  WHEN CancelExec.POFlag_execl = 'NO'
                                       AND CancelExec.POFlag_exec = 'NO' THEN
                                      CASE
                                          WHEN (
                                                   CancelExec.ReceiptFlag_exec = 'NO'
                                                   AND CancelExec.ReceiptQuantity_exec = 0
                                               ) THEN CancelExec.POValue                                -- 'Cancelled Or PO Qty Reduced'

                                          WHEN (
                                                   CancelExec.ReceiptFlag_exec = 'NO'
                                                   AND CancelExec.ReceiptQuantity_exec > 0
                                               ) THEN
             (CancelExec.POQuantity - CancelExec.ReceiptQuantity_exec) * CancelExec.standardunitcostusd -- 'PO Quantity Reduced'


                                          ELSE CancelExec.POValue
                                      END
                              END
                      END
              END                           AS ExecutionValue
             ,CASE
                  WHEN CancelExec.POFlag_exec = 'NO' THEN
                      CASE
                          WHEN (
                                   CancelExec.ReceiptFlag_exec = 'NO'
                                   AND CancelExec.POFlag_execl = 'NO'
                                   AND CancelExec.ReceiptQuantity_exec = 0
                               ) THEN CancelExec.POValue                                                -- 'Cancelled Or PO Qty Reduced'

                          WHEN (
                                   CancelExec.ReceiptFlag_exec = 'NO'
                                   AND CancelExec.POFlag_execl = 'NO'
                                   AND CancelExec.ReceiptQuantity_exec > 0
                               ) THEN
             (CancelExec.POQuantity - CancelExec.ReceiptQuantity_exec) * CancelExec.standardunitcostusd -- 'PO Quantity Reduced'


                          ELSE 0
                      END
                  ELSE 0
              END                           AS ExecutionValuefinal
             ,receiptissueindicator
             ,Shippinginstructions
             ,snapshotdate
         FROM (
                  SELECT
                      MRP.DataSourceKey
                     ,MRP.currentquarter
                     ,MRP.NextQuarter
                     ,MRP.CurrentFYQuarter
                     ,MRP.plantKEY
                     ,SP.MATERIALcode
                     ,MRP.profitcenter
                     ,MRP.buyercode
                     ,MRP.BuyerName
                     ,MRP.abccode
                     ,MRP.documentnumber
                     ,MRP.documentitem
                     ,MRP.documentscheduleline
                     ,MRP.snapshotdate
                     ,MRP.receiptissueindicator
                     ,MRP.POQuantity
                     ,MRP.standardunitcostusd
                     ,MRP.POQuantity * MRP.standardunitcostusd                                                  AS POValue
                     ,MRP.deliveryfinishdts
                     ,MRP.DeliveryMonthDate
                     ,MRP.DeliveryDateQuarterDate
                     ,MRP.DeliveryFYQuarter
                     ,MRP.DeliveryNextQuarterDate
                     ,MRP.DeliveryQuarterplus2monthsDate
                     ,MRP.shippinginstructions
                     ,MRP.mrpcalcdate
                     ,CAST(DATEADD(DAY, CAST(SP.docktostockleadtime AS INTEGER) * -1, MRP.mrpcalcdate) AS DATE) AS Reschedulingdate
                     ,MRP.RescheduleMonthDate
                     ,MRP.RescheduleQuarterDate
                     ,MRP.RescheduleFYQuarter
                     ,MRP.mrprecommendationcode  --AS MRPActionP1
                     ,MRP.mrprecommendationcode2 --AS MRPActionP2
                     ,MRP.fixedvendor
                     ,MRP.globalsuppliername
                     ,MRP.localsuppliername
                     ,MRP.mpnmaterial
                     ,MRP.manufacturerpartcode
                     ,MRP.cancellationleadtime
                     ,MRP.Rescheduleleadtime
                     ,MRP.Intransitleadtime
                     ,MRP.fixedleadtime
                     ,SP.docktostockleadtime
                     ,MRP.purchasedocumenttypecode
                     ,MRP.paymentterms
                     ,MRP.ncnrflag
                     ,MRP.mrpelementindicator
                     ,MRP.mrptypestdcode
                     ,MRP.mrptypecode
                     ,MRP.firmedcomponentflag
                     ,MRP.firmedorderflag
                     ,MRP.planningproductionplant
                     ,MRP.processingrule
                     ,MRP.specialstockscode
                     ,MRP.dscreatedts
                     ,MRP.potype
                     ,MRP.EOQflag
                     ,MRPC.documentnumber                                                                       AS documentnumber_exec
                     ,MRPC.documentitem                                                                         AS documentitem_exec
                     ,MRPC.documentscheduleline                                                                 AS documentscheduleline_exec
                     ,MRPC.quantity                                                                             AS POQuantity_exec
                     ,MRPC.quantity * MRP.standardunitcostusd                                                   AS POValue_exec
                     ,MRPC.deliveryfinishdts                                                                    AS Deliverydate_exec
                     ,CAST(DATEADD(DAY, CAST(SP.docktostockleadtime AS INTEGER) * -1, MRP.mrpcalcdate) AS DATE) AS Reschedulingdate_exec
                     ,MRPC.mrprecommendationcode                                                                AS mrprecommendationcode_exec
                     ,MRPC.mrprecommendationcode2                                                               AS mrprecommendationcode2_exec
                     ,MRPCL.documentnumber                                                                      AS documentnumber_execl
                     ,MRPCL.documentitem                                                                        AS documentitem_execl
                     ,MRPCL.quantity                                                                            AS POQuantity_execl
                     ,MRPCL.quantity * MRP.standardunitcostusd                                                  AS POValue_execl
                     ,MRPCL.deliveryfinishdts                                                                  AS Deliverydate_execl
                     ,CAST(DATEADD(DAY, CAST(SP.docktostockleadtime AS INTEGER) * -1, MRP.mrpcalcdate) AS DATE) AS Reschedulingdate_execl
                     ,MRPCL.MRPActionP1_CompareLine                                                             AS mrprecommendationcode_execl
                     ,MRPCL.MRPActionP2_CompareLine                                                             AS mrprecommendationcode2_execl
                     ,CASE
                          WHEN (
                                   MOV.ReceiptQuantity < 0
                                   OR MOV.ReceiptQuantity IS NULL
                               ) THEN 0
                          ELSE MOV.ReceiptQuantity
                      END                                                                                       AS ReceiptQuantity_exec
                     ,MOV.ReceiptQuantity * MRP.standardunitcostusd                                             AS ReceiptValue_exec
                     ,CASE
                          WHEN (MRP.documentnumber = MRPC.documentnumber) THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       POFlag_exec
                     ,CASE
                          WHEN (MRP.documentnumber = MRPCL.documentnumber) THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       POFlag_execl
                     ,CASE
                          WHEN (
                                   MOV.ReceiptQuantity >= MRP.POquantity
                                   AND MOV.purchasedocumentnumber = MRP.documentnumber
                               ) THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       ReceiptFlag_exec
                     ,CASE
                          WHEN (MRP.POquantity = MRPC.quantity) THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       QuantityFlag_exec
                     ,CASE
                          WHEN (MRP.POquantity = MRPCL.quantity) THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       QuantityFlag_execl
                     ,CASE
                          WHEN (MRP.DELIVERYFINISHDTS = MRPC.DeliveryFinishDateKey) THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       DeliveryDateFlag_exec
                     ,CASE
                          WHEN (MRP.DELIVERYFINISHDTS = MRPCL.deliveryfinishdts) THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       DeliveryDateFlag_execl
                     ,MRP.RescheduleEOQFlag
                     ,MRP.MonthFlag
                     ,MRP.Reschedulable
                     ,MRP.Cancellable
                     ,CASE
                          WHEN MRPC.DeliveryFinishDateKey > DATEADD(
                                                                   DAY, MRP.cancellationleadtime
                                                                  ,(
                                                                       SELECT
                                                                           MAX(datekey)
                                                                       FROM
                                                                           PUBLIC.DIMDATES
                                                                       WHERE
                                                                           DAYNUMBERWEEK = 7
                                                                           AND DATEKEY   <= (CURRENT_DATE ) 
                                                                   )
                                                               )
                               AND MRP.cancellationleadtime NOT IN (
                                                                       911, 998, 999
                                                                   )
                               AND MRP.cancellationleadtime < 900 THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       AS cancellable_exec
                     ,MRP.PushoutWeek1Priority
                     ,MRP.PushoutWeek2Priority
                     ,MRP.PushoutWeek3Priority
                     ,MRP.PushoutWeek4Priority
                     ,MRP.CancelWeek1Priority
                     ,MRP.CancelWeek2Priority
                     ,MRP.CancelWeek3Priority
                     ,MRP.CancelWeek4Priority
                  FROM
                      SAP.FactPushoutCancelsQtrlyExecutions AS MRP
                      LEFT OUTER JOIN SAP.DimMaterials      AS SP ON SP.DataSourceKey                     = MRP.DataSourceKey
                                                                     AND SP.MATERIALCODE                   = MRP.MATERIALCODE
                                                                     AND SP.plantkey                      = MRP.plantkey
      
                               
                      LEFT OUTER JOIN SAP.FactMRPHistorical AS MRPC ON MRP.DataSourceKey                  = MRPC.DataSourceKey
                                                                       AND SP.MATERIALKEY                 = MRPC.MATERIALKEY
                                                                       AND MRP.plantkey                   = MRPC.plantkey
                                                                       AND MRP.documentnumber             = MRPC.Documentnumber
                                                                       AND MRP.documentitem               = MRPC.Documentitem
                                                                       AND MRP.documentscheduleline       = MRPC.documentscheduleline
                                                                       AND CAST(MRPC.snapshotdate AS DATE) = (
                                                                                                                SELECT
                                                                                                                    MAX(datekey)
                                                                                                                FROM
                                                                                                                    PUBLIC.DIMDATES
                                                                                                                WHERE
                                                                                                                    DAYNUMBERWEEK = 7
                                                                                                                    AND DATEKEY   <= (CURRENT_DATE ) 
                                                                                                            )
                      LEFT OUTER JOIN (
                                          SELECT
                                              MRP.DataSourceKey
                                             ,MAT.MATERIALKEY
                                             ,MAT.MATERIALCODE
                                             ,MRP.plantkey
                                             ,CAST(MRP.snapshotdate AS DATE)  AS snapshotdate
                                             ,MRP.documentnumber              AS documentnumber
                                             ,MRP.documentitem                AS documentitem
                                             ,SUM(MRP.quantity)               AS quantity
                                             ,MIN(MRP.DeliveryFinishDateKey ) AS deliveryfinishdts
                                             ,MIN(MRP.mrpcalcdate)            AS mrpcalcdate
                                             ,MIN(MRP.mrprecommendationcode)  AS MRPActionP1_CompareLine
                                             ,MIN(MRP.mrprecommendationcode2) AS MRPActionP2_CompareLine
                                          FROM --SELECT * FROM SAP.FactMRPHistorical LIMIT 10;
                                              SAP.FactMRPHistorical AS MRP
                                              LEFT OUTER JOIN SAP.DimMaterials      AS MAT  ON MAT.MATERIALKEY                     = MRP.MATERIALKEY
                                                                                            AND MAT.plantkey                        = MRP.plantkey
                                                                                            AND MAT.DataSourceKey                   = MRP.DataSourceKey   
                                          WHERE
                                              CAST(MRP.snapshotdate AS DATE) = (
                                                                               SELECT
                                                                                   MAX(datekey)
                                                                               FROM
                                                                                   PUBLIC.DIMDATES
                                                                               WHERE
                                                                                   DAYNUMBERWEEK = 7
                                                                                   AND DATEKEY   <= (CURRENT_DATE ) 
                                                                           )
                                          GROUP BY
                                              MRP.DataSourceKey
                                             ,MAT.MATERIALKEY
                                             ,MAT.MATERIALCODE
                                             ,MRP.plantkey
                                             ,CAST(MRP.snapshotdate AS DATE)
                                             ,MRP.documentnumber
                                             ,MRP.documentitem
                                      )                     AS MRPCL ON MRP.DataSourceKey                 = MRPCL.DataSourceKey
                                                                        AND MRP.MATERIALCODE               = MRPCL.MATERIALCODE
                                                                        AND MRP.plantkey                  = MRPCL.plantkey
                                                                        AND MRP.documentnumber            = MRPCL.Documentnumber
                                                                        AND MRP.documentitem              = MRPCL.Documentitem
                                                                        AND MRPCL.snapshotdate            = (
                                                                                                                SELECT
                                                                                                                    MAX(datekey)
                                                                                                                FROM
                                                                                                                    PUBLIC.DIMDATES
                                                                                                                WHERE
                                                                                                                    DAYNUMBERWEEK = 7
                                                                                                                    AND DATEKEY   <= (CURRENT_DATE ) 
                                                                                                            )
                      LEFT OUTER JOIN (
                                          SELECT
                                              M.DataSourceKey
                                             ,M.plantkey
                                             ,M.materialkey
                                             ,M.purchasedocumentnumber
                                             ,M.purchasedocumentitem
                                             ,SUM(   CASE
                                                         WHEN T.MOVEMENTTYPECODE = '101' THEN (quantity) * 1
                                                         ELSE (quantity) * -1
                                                     END
                                                 ) AS ReceiptQuantity
                                          FROM
                                              SAP.FactMovements              M
                                              LEFT JOIN SAP.DimMovementTypes T ON M.MOVEMENTTYPEKEY   = T.MOVEMENTTYPEKEY
                                                                                  AND M.DATASOURCEKEY = T.DATASOURCEKEY
                                          WHERE
                                              M.POSTEDDATEKEY     >= (
                                                                         SELECT
                                                                             MAX(datekey)
                                                                         FROM
                                                                             PUBLIC.DIMDATES
                                                                         WHERE
                                                                             DAYNUMBERWEEK = 1
                                                                             AND DATEKEY   <= (CURRENT_DATE ) 
                                                                     )
                                              AND M.POSTEDDATEKEY <= (
                                                                         SELECT
                                                                             MAX(datekey)
                                                                         FROM
                                                                             PUBLIC.DIMDATES
                                                                         WHERE
                                                                             DAYNUMBERWEEK = 7
                                                                             AND DATEKEY   <= (CURRENT_DATE ) 
                                                                     )
                                              AND T.MOVEMENTTYPECODE IN (
                                                                            '101', '102'
                                                                        )
                                          GROUP BY
                                              M.DataSourceKey
                                             ,M.plantkey
                                             ,M.materialkey
                                             ,M.purchasedocumentnumber
                                             ,M.purchasedocumentitem
                                      )                     AS MOV ON MOV.DataSourceKey                   = MRP.DataSourceKey
                                                                      AND MOV.MATERIALkey                 = SP.MATERIALkey
                                                                      AND MOV.plantkey                    = MRP.plantkey
                                                                      AND MRP.documentnumber              = MOV.Purchasedocumentnumber
                                                                      AND CAST(MRP.documentitem AS INT)   = CAST(MOV.purchasedocumentitem AS INT)

                  WHERE
                      MRP.snapshotdate                                     = (
                                                                                 SELECT
                                                                                     MAX(datekey)
                                                                                 FROM
                                                                                     PUBLIC.DIMDATES
                                                                                 WHERE
                                                                                     DAYNUMBERWEEK = 1
                                                                                     AND DATEKEY   <= (CURRENT_DATE ) 
                                                                             )
                      AND MRP.Metrictype                                   = 'C'
                      AND MRP.receiptissueindicator                        = '+'
                      AND COALESCE(MRP.mrpelementindicator, '')            <> 'PA'
                      AND COALESCE(MRP.mrpelementindicator, '')            <> 'QM'
                      AND COALESCE(MRP.mrpelementindicator, '')      NOT LIKE 'BA%'
                      AND (
                              MRP.mrprecommendationcode                    = 'U3'
                              OR MRP.mrprecommendationcode2                = 'U3'
                              OR MRP.mrprecommendationcode                 = 'U7'
                              OR MRP.mrprecommendationcode2                = 'U7'
                          )
                      AND (
                              COALESCE(MRP.mrprecommendationcode, '')      <> 'U3'
                              AND COALESCE(MRP.mrprecommendationcode2, '') <> 'U3'
                          )
                      AND SP.Makebuy                                       = 'Buy'
              ) AS CancelExec
     ) AS Cancel;
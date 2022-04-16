create or replace view V_PUSHOUTS_EXECUTION(
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
    ,materialcode
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
    ,''                            AS Cancellable
    ,''                            AS Cancellable_exec
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
    ,''                            AS CancelWeek1Priority
    ,''                            AS CancelWeek2Priority
    ,''                            AS CancelWeek3Priority
    ,''                            AS CancelWeek4Priority
    ,CASE
         WHEN ExecutionFlag = 'YES'
              AND RescheduleEOQFlag = 'YES'
              AND Reschedulable = 'YES' THEN ExecutionValue
     END                           AS PushOutEOQReschExec
    ,CASE
         WHEN ExecutionFlag = 'YES'
              AND RescheduleEOQFlag = 'YES'
              AND Reschedulable = 'NO' THEN ExecutionValue
     END                           AS PushOutEOQNONReschExec
    ,CASE
         WHEN (
                  ExecutionFlag = 'YES'
                  AND RescheduleEOQFlag = 'YES'
                  AND Reschedulable = 'YES'
              )
              OR (
                     ExecutionFlag = 'YES'
                     AND RescheduleEOQFlag = 'YES'
                     AND Reschedulable = 'NO'
                 ) THEN ExecutionValue
     END                           AS TotalPushOutEOQExec
    ,CASE
         WHEN ExecutionFlag = 'YES'
              AND RescheduleEOQFlag = 'YES'
              AND Reschedulable = 'YES'
              AND PushoutWeek1Priority = 'YES' THEN ExecutionValue
     END                           AS PushOutWk1P1_exec
    ,POExecution
    ,0                             AS CancellableExec
    ,0                             AS NonCancellableExec
    ,0                             AS TotalCancelExec
    ,0                             AS CancelWk1P1_exec
    ,0                             AS CancelExecution
    ,ExecutionFlag
    ,ExecutionValue
    ,ExecutionValuefinal
    ,receiptissueindicator
    ,Shippinginstructions
    ,snapshotdate
    ,'PE'                          AS metrictype
    ,datasourcekey
FROM (
         SELECT
              DataSourceKey
             ,currentquarter
             ,NextQuarter
             ,CurrentFYQuarter
             ,plantkey
             ,materialcode
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
             ,CASE
                  WHEN POEOQExec.POFlag_exec = 'YES' THEN
                      CASE
                          WHEN POEOQExec.DeliveryDateFlag_exec = 'NO'
                               AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                               AND POEOQExec.QuantityFlag_exec = 'YES' THEN 1
                          WHEN POEOQExec.DeliveryDateFlag_exec = 'NO'
                               AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                               AND POEOQExec.QuantityFlag_exec = 'NO'
                               AND POEOQExec.POQuantity < POEOQExec.POQuantity_exec THEN 1
                          WHEN POEOQExec.DeliveryDateFlag_exec = 'NO'
                               AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                               AND POEOQExec.QuantityFlag_exec = 'NO'
                               AND POEOQExec.POQuantity > POEOQExec.POQuantity_exec
                               AND POEOQExec.ReceiptQuantity_exec = 0 THEN 2
                          WHEN POEOQExec.DeliveryDateFlag_exec = 'NO'
                               AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                               AND POEOQExec.QuantityFlag_exec = 'NO'
                               AND POEOQExec.ReceiptQuantity_exec > 0 THEN 3
                          WHEN POEOQExec.DeliveryDateFlag_exec = 'NO'
                               AND POEOQExec.Reschedulingdate_exec < POEOQExec.DeliveryNextQuarterDate THEN 4
                          WHEN POEOQExec.mrprecommendationcode <> POEOQExec.mrprecommendationcode_exec THEN 5
                          WHEN POEOQExec.Reschedulable = 'YES'
                               AND POEOQExec.PushoutWeek1Priority = 'NO' THEN 6
                          WHEN POEOQExec.Reschedulable = 'YES'
                               AND POEOQExec.PushoutWeek1Priority = 'YES' THEN 7
                          WHEN POEOQExec.DeliveryDateFlag_exec = 'YES'
                               AND POEOQExec.QuantityFlag_exec = 'NO'
                               AND POEOQExec.POQuantity > POEOQExec.POQuantity_exec
                               AND POEOQExec.ReceiptQuantity_exec = 0 THEN 8
                          WHEN POEOQExec.mrprecommendationcode = POEOQExec.mrprecommendationcode_exec
                               AND POEOQExec.Deliverydate_exec <= POEOQExec.DeliveryNextQuarterDate
                               AND POEOQExec.Deliverydate_exec < POEOQExec.deliveryfinishdts THEN 9
                          WHEN (
                                   (
                                       POEOQExec.DeliveryDateFlag_exec = 'YES'
                                       OR POEOQExec.DeliveryDateFlag_exec = 'NO'
                                   )
                                   AND POEOQExec.mrprecommendationcode = POEOQExec.mrprecommendationcode_exec
                                   AND POEOQExec.Reschedulable = 'NO'
                               )
                               AND (
                                       POEOQExec.Cancellationleadtime <> 998
                                       AND POEOQExec.rescheduleleadtime < 900
                                   ) THEN 10
                          WHEN (
                                   POEOQExec.Rescheduleleadtime >= 900
                                   AND POEOQExec.Rescheduleleadtime < 999
                               ) THEN 11
                          WHEN POEOQExec.Cancellationleadtime = 999 THEN 12
                          ELSE 13
                      END
                  ELSE
                      CASE
                          WHEN POEOQExec.POFlag_execl = 'YES'
                               AND POEOQExec.POFlag_exec = 'NO'
                               AND POEOQExec.ReceiptFlag_exec = 'NO' THEN
                              CASE
                                  WHEN POEOQExec.ReceiptQuantity_exec > 0
                                       AND POEOQExec.DeliveryDateFlag_execl = 'NO'
                                       AND POEOQExec.Deliverydate_execl >= POEOQExec.DeliveryNextQuarterDate
                                       AND POEOQExec.QuantityFlag_execl = 'NO'
                                       AND POEOQExec.POQuantity > POEOQExec.POQuantity_execl THEN 2
                                  WHEN POEOQExec.ReceiptFlag_exec = 'NO'
                                       AND POEOQExec.ReceiptQuantity_exec = 0
                                       AND POEOQExec.DeliveryDateFlag_execl = 'NO'
                                       AND POEOQExec.Deliverydate_execl >= POEOQExec.DeliveryNextQuarterDate
                                       AND POEOQExec.QuantityFlag_execl = 'YES' THEN 1
                                  WHEN POEOQExec.mrprecommendationcode <> POEOQExec.mrprecommendationcode_execl THEN 5
                                  WHEN POEOQExec.Reschedulable = 'YES'
                                       AND POEOQExec.PushoutWeek1Priority = 'NO' THEN 6
                                  WHEN (
                                           (
                                               POEOQExec.DeliveryDateFlag_exec = 'YES'
                                               OR POEOQExec.DeliveryDateFlag_exec = 'NO'
                                           )
                                           AND POEOQExec.mrprecommendationcode = POEOQExec.mrprecommendationcode_execl
                                           AND POEOQExec.Reschedulable = 'NO'
                                       )
                                       AND (
                                               POEOQExec.Cancellationleadtime <> 998
                                               AND POEOQExec.rescheduleleadtime < 900
                                           ) THEN 10
                                  WHEN (
                                           POEOQExec.Rescheduleleadtime >= 900
                                           AND POEOQExec.Rescheduleleadtime < 999
                                       ) THEN 11
                                  WHEN POEOQExec.Cancellationleadtime = 999 THEN 12
                                  ELSE 18
                              END
                          ELSE CASE
                                   WHEN POEOQExec.POFlag_exec = 'NO'
                                        AND POEOQExec.ReceiptFlag_exec = 'NO'
                                        AND POEOQExec.POFlag_execl = 'NO'
                                        AND POEOQExec.ReceiptQuantity_exec = 0 THEN 14
                                   WHEN POEOQExec.POFlag_exec = 'NO'
                                        AND POEOQExec.ReceiptFlag_exec = 'NO'
                                        AND POEOQExec.POFlag_execl = 'NO'
                                        AND POEOQExec.ReceiptQuantity_exec > 0 THEN 15
                                   WHEN POEOQExec.POFlag_exec = 'NO'
                                        AND POEOQExec.ReceiptFlag_exec = 'YES' THEN 16
                                   ELSE 17
                               END
                      END
              END                           POExecution
             ,CASE
                  WHEN POEOQExec.POFlag_exec = 'YES' THEN
                      CASE
                          WHEN (
                                   POEOQExec.DeliveryDateFlag_exec = 'NO'
                                   AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                   AND POEOQExec.QuantityFlag_exec = 'YES'
                               ) --  'Push Out Executed'
                               OR (
                                      POEOQExec.DeliveryDateFlag_exec = 'NO'
                                      AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                      AND POEOQExec.QuantityFlag_exec = 'NO'
                                      AND POEOQExec.POQuantity < POEOQExec.POQuantity_exec
                                  ) -- 'Push Out Executed'
                               OR (
                                      POEOQExec.DeliveryDateFlag_exec = 'NO'
                                      AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                      AND POEOQExec.QuantityFlag_exec = 'NO'
                                      AND POEOQExec.POQuantity > POEOQExec.POQuantity_exec
                                      AND POEOQExec.ReceiptQuantity_exec = 0
                                  ) --  'Pushout Executed Partial'
                               OR (
                                      POEOQExec.DeliveryDateFlag_exec = 'NO'
                                      AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                      AND POEOQExec.QuantityFlag_exec = 'NO'
                                      AND POEOQExec.ReceiptQuantity_exec > 0
                                  ) --  'Pushout Exec - Early Receipt'
             THEN                                                 'YES'
                          ELSE 'NO'
                      END
                  ELSE
                      CASE
                          WHEN POEOQExec.POFlag_execl = 'YES'
                               AND POEOQExec.POFlag_exec = 'NO' THEN
                              CASE
                                  WHEN (
                                           POEOQExec.ReceiptFlag_exec = 'NO'
                                           AND POEOQExec.ReceiptQuantity_exec > 0
                                           AND POEOQExec.DeliveryDateFlag_execl = 'NO'
                                           AND POEOQExec.Deliverydate_execl >= POEOQExec.DeliveryNextQuarterDate
                                           AND POEOQExec.QuantityFlag_execl = 'NO'
                                           AND POEOQExec.POQuantity > POEOQExec.POQuantity_execl
                                       ) -- 'Pushout Executed Partial - LINE'
                                       OR (
                                              POEOQExec.ReceiptFlag_exec = 'NO'
                                              AND POEOQExec.ReceiptQuantity_exec = 0
                                              AND POEOQExec.DeliveryDateFlag_execl = 'NO'
                                              AND POEOQExec.Deliverydate_execl >= POEOQExec.DeliveryNextQuarterDate
                                              AND POEOQExec.QuantityFlag_execl = 'YES'
                                          ) --    'Push Out Executed - LINE'
             THEN                                                             'YES'
                                  ELSE 'NO'
                              END
                          ELSE 'NO'
                      END
              END                           ExecutionFlag
             ,CASE
                  WHEN POEOQExec.POFlag_exec = 'YES' THEN
                      CASE
                          WHEN (
                                   POEOQExec.DeliveryDateFlag_exec = 'NO'
                                   AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                   AND POEOQExec.QuantityFlag_exec = 'NO'
                                   AND POEOQExec.POQuantity > POEOQExec.POQuantity_exec
                                   AND POEOQExec.ReceiptQuantity_exec = 0
                               ) --  'Pushout Executed Partial'
                               OR (
                                      POEOQExec.DeliveryDateFlag_exec = 'NO'
                                      AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                      AND POEOQExec.QuantityFlag_exec = 'NO'
                                      AND POEOQExec.ReceiptQuantity_exec > 0
                                  ) --  'Pushout Exec - Early Receipt'
             THEN                                                 POEOQExec.POValue_exec
                          ELSE POEOQExec.POValue
                      END
                  ELSE
                      CASE
                          WHEN POEOQExec.POFlag_execl = 'YES'
                               AND POEOQExec.POFlag_exec = 'NO' THEN
                              CASE
                                  WHEN (
                                           POEOQExec.ReceiptFlag_exec = 'NO'
                                           AND POEOQExec.ReceiptQuantity_exec > 0
                                           AND POEOQExec.DeliveryDateFlag_execl = 'NO'
                                           AND POEOQExec.Deliverydate_execl >= POEOQExec.DeliveryNextQuarterDate
                                           AND POEOQExec.QuantityFlag_execl = 'NO'
                                           AND POEOQExec.POQuantity > POEOQExec.POQuantity_execl
                                       ) -- 'Pushout Executed Partial - LINE'
             THEN                                                             POEOQExec.POValue_execl
                                  ELSE POEOQExec.POValue
                              END
                          ELSE POEOQExec.POValue
                      END
              END                           AS ExecutionValue
             ,CASE
                  WHEN POEOQExec.POFlag_exec = 'YES' THEN
                      CASE
                          WHEN (
                                   POEOQExec.DeliveryDateFlag_exec = 'NO'
                                   AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                   AND POEOQExec.QuantityFlag_exec = 'YES'
                               ) --  'Push Out Executed'
                               OR (
                                      POEOQExec.DeliveryDateFlag_exec = 'NO'
                                      AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                      AND POEOQExec.QuantityFlag_exec = 'NO'
                                      AND POEOQExec.POQuantity < POEOQExec.POQuantity_exec
                                  ) -- 'Push Out Executed'
             THEN                                                 POEOQExec.POValue
                          WHEN (
                                   POEOQExec.DeliveryDateFlag_exec = 'NO'
                                   AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                   AND POEOQExec.QuantityFlag_exec = 'NO'
                                   AND POEOQExec.POQuantity > POEOQExec.POQuantity_exec
                                   AND POEOQExec.ReceiptQuantity_exec = 0
                               ) --  'Pushout Executed Partial'
                               OR (
                                      POEOQExec.DeliveryDateFlag_exec = 'NO'
                                      AND POEOQExec.Deliverydate_exec >= POEOQExec.DeliveryNextQuarterDate
                                      AND POEOQExec.QuantityFlag_exec = 'NO'
                                      AND POEOQExec.ReceiptQuantity_exec > 0
                                  ) --  'Pushout Exec - Early Receipt'
             THEN                                                 POEOQExec.POValue_exec
                          ELSE 0
                      END
                  ELSE
                      CASE
                          WHEN POEOQExec.POFlag_execl = 'YES'
                               AND POEOQExec.POFlag_exec = 'NO' THEN
                              CASE
                                  WHEN (
                                           POEOQExec.ReceiptFlag_exec = 'NO'
                                           AND POEOQExec.ReceiptQuantity_exec > 0
                                           AND POEOQExec.DeliveryDateFlag_execl = 'NO'
                                           AND POEOQExec.Deliverydate_execl >= POEOQExec.DeliveryNextQuarterDate
                                           AND POEOQExec.QuantityFlag_execl = 'NO'
                                           AND POEOQExec.POQuantity > POEOQExec.POQuantity_execl
                                       ) -- 'Pushout Executed Partial - LINE'
             THEN                                                             POEOQExec.POValue_execl
                                  WHEN (
                                           POEOQExec.ReceiptFlag_exec = 'NO'
                                           AND POEOQExec.ReceiptQuantity_exec = 0
                                           AND POEOQExec.DeliveryDateFlag_execl = 'NO'
                                           AND POEOQExec.Deliverydate_execl >= POEOQExec.DeliveryNextQuarterDate
                                           AND POEOQExec.QuantityFlag_execl = 'YES'
                                       ) --    THEN 'Push Out Executed - LINE'
             THEN                                                             POEOQExec.POValue
                                  ELSE 0
                              END
                          ELSE 0
                      END
              END                           ExecutionValuefinal
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
                     ,sp.materialcode
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
                     ,MRPC.DeliveryFinishDateKey                                                                AS Deliverydate_exec
                     ,CAST(DATEADD(DAY, CAST(SP.docktostockleadtime AS INTEGER) * -1, MRP.mrpcalcdate) AS DATE) AS Reschedulingdate_exec
                     ,MRPC.mrprecommendationcode                                                                AS mrprecommendationcode_exec
                     ,MRPC.mrprecommendationcode2                                                               AS mrprecommendationcode2_exec
                     ,MRPCL.documentnumber                                                                      AS documentnumber_execl
                     ,MRPCL.documentitem                                                                        AS documentitem_execl
                     ,MRPCL.quantity                                                                            AS POQuantity_execl
                     ,MRPCL.quantity * MRP.standardunitcostusd                                                  AS POValue_execl
                     ,MRPCL.deliveryfinishdts                                                               AS Deliverydate_execl
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
                          WHEN (MRP.deliveryfinishdts = MRPC.deliveryfinishdts) THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       DeliveryDateFlag_exec
                     ,CASE
                          WHEN (MRP.deliveryfinishdts = MRPCL.deliveryfinishdts) THEN 'YES'
                          ELSE 'NO'
                      END                                                                                       DeliveryDateFlag_execl
                     ,MRP.RescheduleEOQFlag
                     ,MRP.MonthFlag
                     ,MRP.Reschedulable
                     ,MRP.PushoutWeek1Priority
                     ,MRP.PushoutWeek2Priority
                     ,MRP.PushoutWeek3Priority
                     ,MRP.PushoutWeek4Priority
                  FROM
                      SAP.FactPushoutCancelsQtrlyExecutions AS MRP 
                      LEFT OUTER JOIN SAP.DimMaterials      AS SP    ON  SP.DataSourceKey                 = MRP.DataSourceKey
                                                                     AND SP.materialcode                  = MRP.materialcode
                                                                     AND SP.plantkey                      = MRP.plantkey
                                                                     AND MRP.snapshotdate                 = (
                                                                                                                SELECT
                                                                                                                    MAX(datekey)
                                                                                                                FROM
                                                                                                                    PUBLIC.DIMDATES
                                                                                                                WHERE
                                                                                                                    DAYNUMBERWEEK = 1
                                                                                                                    AND DATEKEY   <= (CURRENT_DATE)
                                                                                                            )

                      LEFT OUTER JOIN SAP.FactMRPHistorical AS MRPC ON MRP.DataSourceKey                  = MRPC.DataSourceKey
                                                                       AND SP.MATERIALKEY                = MRPC.MATERIALKEY
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
                                                                                                                    AND DATEKEY   <= (CURRENT_DATE)
                                                                                                            )
                      LEFT OUTER JOIN (
                                          SELECT
                                              DataSourceKey
                                             ,MATERIALKEY
                                             ,plantkey
                                             ,CAST(snapshotdate AS DATE)  AS snapshotdate
                                             ,documentnumber              AS documentnumber
                                             ,documentitem                AS documentitem
                                             ,SUM(quantity)               AS quantity
                                             ,MIN(DELIVERYFINISHDATEKEY)  AS deliveryfinishdts
                                             ,MIN(mrpcalcdate)            AS mrpcalcdate
                                             ,MIN(mrprecommendationcode)  AS MRPActionP1_CompareLine
                                             ,MIN(mrprecommendationcode2) AS MRPActionP2_CompareLine
                                          FROM
                                              SAP.FactMRPHistorical
                                          WHERE
                                              CAST(snapshotdate AS DATE) = (
                                                                               SELECT
                                                                                   MAX(datekey)
                                                                               FROM
                                                                                   PUBLIC.DIMDATES
                                                                               WHERE
                                                                                   DAYNUMBERWEEK = 7
                                                                                   AND DATEKEY   <= (CURRENT_DATE)
                                                                           )
                                          GROUP BY
                                              DataSourceKey
                                             ,MATERIALKEY
                                             ,plantkey
                                             ,CAST(snapshotdate AS DATE)
                                             ,documentnumber
                                             ,documentitem
                                      )                     AS MRPCL ON MRP.DataSourceKey                 = MRPCL.DataSourceKey
                                                                        AND SP.MATERIALKEY               = MRPCL.MATERIALKEY
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
                                                                                                                    AND DATEKEY   <= (CURRENT_DATE)
                                                                                                            )
                      LEFT OUTER JOIN (
                                          SELECT
                                              M.DataSourceKey
                                             ,M.plantkey
                                             ,M.MATERIALKEY
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
                                                                             AND DATEKEY   <= (CURRENT_DATE)
                                                                     )
                                              AND M.POSTEDDATEKEY <= (
                                                                         SELECT
                                                                             MAX(datekey)
                                                                         FROM
                                                                             PUBLIC.DIMDATES
                                                                         WHERE
                                                                             DAYNUMBERWEEK = 7
                                                                             AND DATEKEY   <= (CURRENT_DATE)
                                                                     )
                                              AND T.MOVEMENTTYPECODE IN (
                                                                            '101', '102'
                                                                        )
                                          GROUP BY
                                              M.DataSourceKey
                                             ,M.plantkey
                                             ,M.MATERIALKEY
                                             ,M.purchasedocumentnumber
                                             ,M.purchasedocumentitem
                                      )                     AS MOV ON MOV.DataSourceKey                   = MRP.DataSourceKey
                                                                      AND MOV.MATERIALKEY                 = SP.MATERIALKEY
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
                                                                                     AND DATEKEY   <= (CURRENT_DATE)
                                                                             )
                      AND MRP.Metrictype                                   = 'P'
                      AND MRP.receiptissueindicator                        = '+'
                      AND COALESCE(MRP.mrpelementindicator, '')            <> 'PA'
                      AND COALESCE(MRP.mrpelementindicator, '')            <> 'QM'
                      AND COALESCE(MRP.mrpelementindicator, '')NOT LIKE 'BA%'
                      AND (
                              MRP.mrprecommendationcode                    = 'U2'
                              OR MRP.mrprecommendationcode2                = 'U2'
                          )
                      AND (
                              COALESCE(MRP.mrprecommendationcode, '')      <> 'U7'
                              AND COALESCE(MRP.mrprecommendationcode2, '') <> 'U7'
                          )
                      AND SP.Makebuy                                       = 'Buy'
                      AND MRP.mrptypestdcode IN (
                                                    'Purchase Order', 'Workorder'
                                                )
              ) AS POEOQExec
     ) AS PO;
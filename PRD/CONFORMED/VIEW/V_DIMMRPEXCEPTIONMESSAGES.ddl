create or replace view V_DIMMRPEXCEPTIONMESSAGES(
	DATASOURCEKEY,
	EXCEPTIONMESSAGEKEY,
	LANGUAGEKEY,
	EXCEPTIONMESSAGENUMBER,
	EXCEPTIONMESSAGEGROUP,
	CREATEMATERIALREQLIST,
	EXCEPTIONMESSAGEPRIORITY,
	DONOSETEXCEPTIONMESSAGE,
	EXCEPTIONMESSAGE
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimMRPExceptionMessages
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-15      Carlos Carrillo             Initial Revision
*/
   
SELECT DISTINCT
      
      1         AS  DataSourceKey
     ,TA.AUSSL  AS  ExceptionMessageKey
     ,TB.SPRAS  AS  LanguageKey      
     ,TA.AUSKT  AS  ExceptionMessageNumber
     ,TA.SELGP  AS  ExceptionMessageGroup
     ,TA.ERDIS  AS  CreateMaterialReqList
     ,TA.ASPRI  AS  ExceptionMessagePriority
     ,TA.ASNOT  AS  DoNoSetExceptionMessage
     ,TB.AUSLT  AS  ExceptionMessage
FROM 
    conformed.ecc_ha_T458a ta
    LEFT OUTER JOIN conformed.ecc_ha_T458b tb ON ta.aussl=tb.aussl
WHERE
    tb.spras='E';
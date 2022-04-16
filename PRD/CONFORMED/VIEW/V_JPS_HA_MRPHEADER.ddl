create or replace view V_JPS_HA_MRPHEADER(
	SITEPARTCODE,
	BASEUNITOFMEASUREDSCODE,
	SITECODE,
	MRPSCENARIO,
	MRPPROCESSEDFLAG,
	MRPNUMBER,
	LOWLEVELCODE,
	MRPCURRENTASOFDTS,
	UPDATED_ON,
	MDKP_SNAPSHOTDATE
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.v_Factmrp
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-07-28      Jagan                   Initial Revision
                                        
*/
SELECT 
       query3.matnr AS SitePartCode,
       query3.meins AS BaseUnitOfMeasureDSCode,
       query3.plwrk AS SiteCode,
       query3.Plscn AS MRPScenario,
       query3.bdbkz AS MRPProcessedFlag,
       query3.dtnum AS MRPNumber,
       query3.disst AS LowLevelCode,
       CASE
           WHEN query5.disst = '999' THEN
               query5.dstmp
           WHEN (
                    query5.disst IS NOT NULL
                    OR query5.disst <> ''
                )
                AND query3.disst = query5.disst THEN
               query5.dstmp
           ELSE
               ''
       END AS MRPCurrentAsOFDTS,
       GETDATE() AS updated_on,
       mdkp_SNAPSHOTDATE
FROM
    (
    SELECT 
	       mdkp.matnr,
           mdkp.meins,
           mdkp.plwrk,
           mdkp.Plscn,
           mdkp.bdbkz,
           mdkp.dtnum,
           mdkp.disst,
           mdkp.dsdat,
           mdkp.dtart, 
           cast(mdkp.FRMW_EXTRACTED_ON as date) as mdkp_SNAPSHOTDATE
    FROM 
	     CONFORMED.JPS_HA_MDKP mdkp
    INNER JOIN     
		 CONFORMED.JPS_HA_MARC marc
      ON  mdkp.matnr = marc.matnr
      AND mdkp.plwrk = marc.werks
	  AND mdkp.FRMW_EXTRACTED_ON  = (SELECT MAX(FRMW_EXTRACTED_ON) FROM CONFORMED.JPS_HA_MDKP )
      AND
          (
              trim(marc.LVORM) = ''
              OR marc.LVORM IS NULL
          )
      AND NOT (
                      mdkp.dtnum IS NULL
                      OR mdkp.dtnum = ''
              )
      AND NOT (
                      mdkp.matnr IS NULL
                      OR mdkp.matnr = ''
              )
    ) query3
    LEFT OUTER JOIN
    (
        SELECT 
		       dbvm.disst,
               dbvm.matnr,
               dbvm.berid,
               dbvm.dstmp
        FROM   
		       CONFORMED.JPS_HA_DBVM dbvm
        INNER JOIN
               (
                SELECT 
				       mdkp.matnr,
                       mdkp.plwrk,
                       CASE
                           WHEN mdkp.disst IS NULL
                                OR mdkp.disst = '' THEN
                               '999'
                           ELSE
                               mdkp.disst
                       END AS disst
                FROM 
				     CONFORMED.JPS_HA_MDKP mdkp
                INNER JOIN 
				     CONFORMED.JPS_HA_MARC marc
                        ON mdkp.matnr = marc.matnr
                       AND mdkp.plwrk = marc.werks
		               AND mdkp.FRMW_EXTRACTED_ON  = (SELECT MAX(FRMW_EXTRACTED_ON) FROM CONFORMED.JPS_HA_MDKP )
                       AND
                           (
                               trim(marc.LVORM) = ''
                               OR marc.LVORM IS NULL
                           )
                       AND
                           (
                               mdkp.dtnum IS NOT NULL
                               OR mdkp.dtnum <> ''
                           )
                       AND
                           (
                               mdkp.matnr IS NOT NULL
                               OR mdkp.matnr <> ''
                           )
        
	        ) AS query4
                   ON  dbvm.mafid = 'B'
                   AND dbvm.disst = query4.disst
                   AND dbvm.matnr = query4.matnr
                   AND dbvm.berid = query4.plwrk
	) query5
        ON query3.MATNR = query5.MATNR
        AND query3.PLWRK = query5.berid
GROUP BY SitePartCode
       , BaseUnitOfMeasureDSCode
	   , SiteCode
       , MRPScenario
       , MRPProcessedFlag
       , MRPNumber
       , LowLevelCode
	   , MRPCurrentAsOFDTS
       , updated_on
       , mdkp_SNAPSHOTDATE
;
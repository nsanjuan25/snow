create or replace view V_ECC_HA_MRPHEADER(
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
2021-03-03      Carlos Carrillo             Initial Revision
                                        
*/


SELECT query3.matnr AS SitePartCode,
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
    SELECT DISTINCT
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
    FROM CONFORMED.BW_HA_MDKP mdkp,
         CONFORMED.ECC_HA_MARC marc
    WHERE mdkp.matnr = marc.matnr
          AND mdkp.plwrk = marc.werks
	AND cast( mdkp.FRMW_EXTRACTED_ON as date)  >=  (SELECT cast( MAX(FRMW_EXTRACTED_ON) as date ) FROM CONFORMED.BW_HA_MDTB)
          AND
          (
              trim(marc.LVORM) = ''
              OR marc.LVORM IS NULL
          )
          AND mdkp.dtart = 'MD'
          AND mdkp.plscn = '000'
          AND NOT (
                      mdkp.dtnum IS NULL
                      OR mdkp.dtnum = ''
                  )
          AND NOT (
                      mdkp.matnr IS NULL
                      OR mdkp.matnr = ''
                  )
    UNION ALL
    SELECT DISTINCT
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
    FROM CONFORMED.BW_HA_MDKP mdkp,
         CONFORMED.ECC_HA_MARC marc
    WHERE mdkp.matnr = marc.matnr
          AND mdkp.plwrk = marc.werks
	      AND cast(mdkp.FRMW_EXTRACTED_ON as date) >= (SELECT cast( MAX(FRMW_EXTRACTED_ON) as date ) FROM CONFORMED.BW_HA_MDTB)--(SELECT MAX(FRMW_EXTRACTED_ON) FROM CONFORMED.BW_HA_MDKP )
          AND
          (
              trim(marc.LVORM) = ''
              OR marc.LVORM IS NULL
          )
          AND mdkp.dtart = 'LP'
          AND mdkp.plscn = '027'
          AND mdkp.dismm = 'Z1'
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
        SELECT DISTINCT
               dbvm.disst,
               dbvm.matnr,
               dbvm.berid,
               dbvm.dstmp
        FROM CONFORMED.BW_HA_DBVM dbvm
            INNER JOIN
            (
                SELECT DISTINCT
                       mdkp.matnr,
                       mdkp.plwrk,
                       CASE
                           WHEN mdkp.disst IS NULL
                                OR mdkp.disst = '' THEN
                               '999'
                           ELSE
                               mdkp.disst
                       END AS disst
                FROM CONFORMED.BW_HA_MDKP mdkp
                    INNER JOIN CONFORMED.ECC_HA_MARC marc
                        ON mdkp.matnr = marc.matnr
                           AND mdkp.plwrk = marc.werks
		          AND cast( mdkp.FRMW_EXTRACTED_ON as date)  = (SELECT cast( MAX(FRMW_EXTRACTED_ON) as date) FROM CONFORMED.BW_HA_MDTB ) --(SELECT MAX(FRMW_EXTRACTED_ON) FROM CONFORMED.BW_HA_MDKP )
                           AND
                           (
                               trim(marc.LVORM) = ''
                               OR marc.LVORM IS NULL
                           )
                           AND mdkp.dtart = 'MD'
                           AND mdkp.plscn = '000'
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
                ON dbvm.mafid = 'B'
                   AND dbvm.disst = query4.disst
                   AND dbvm.matnr = query4.matnr
                   AND dbvm.berid = query4.plwrk
    ) query5
        ON query3.MATNR = query5.MATNR
           AND query3.PLWRK = query5.berid;
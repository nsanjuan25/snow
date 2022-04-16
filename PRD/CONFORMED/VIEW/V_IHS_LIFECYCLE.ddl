create or replace view V_IHS_LIFECYCLE(
	PARTOBJECTID,
	MANUFACTUREROBJECTID,
	MANUFACTURERPARTNUMBER,
	MANUFACTURERFULLNAME,
	PARTSTATUS,
	LIFECYCLESTAGE,
	LIFECYCLECODE,
	DATEOFINTRO,
	AVAILABILITYYTEOL,
	ESTIMATEDYTEOL,
	ALERTPREDICTIONDATE,
	LIFECYCLECOMMENTS,
	LIFECYCLEINFORMATIONSOURCE,
	FRMWEXTRACTEDON
) as
SELECT
       part_objectid                    AS PartObjectID,
       manufacturer_objectid            AS ManufacturerObjectID,
       manufacturer_part_number         AS ManufacturerPartNumber,
       manufacturer_full_name           AS ManufacturerFullName,
       part_status                      AS PartStatus,
       life_cycle_stage                 AS LifeCycleStage,
       life_cycle_code                  AS LifeCycleCode,
       date_of_intro                    AS DateOfIntro,
       availabilityyteol                AS AvailabilityYteol,
       estimated_yteol                  AS EstimatedYteol,
       alert_prediction_date            AS AlertPredictionDate,
       life_cycle_comments              AS LifeCycleComments,
       life_cycle_information_source    AS LifeCycleInformationSource,
       FRMW_EXTRACTED_ON                AS FrmwExtractedOn
FROM
  (SELECT
          part_objectid,
          manufacturer_objectid,
          IFNULL(manufacturer_part_number,'') AS manufacturer_part_number,
          IFNULL(manufacturer_full_name,'') AS manufacturer_full_name,
          IFNULL(part_status,'') AS part_status,
          IFNULL(life_cycle_stage,'') AS life_cycle_stage,
          IFNULL(life_cycle_code,'') AS life_cycle_code,
          TO_DATE(
			CASE WHEN date_of_intro = '' THEN '01-JAN-1900'
			  WHEN date_of_intro IS NULL THEN '01-JAN-1900'
			  WHEN date_of_intro = 'NULL' THEN '01-JAN-1900'
			ELSE date_of_intro 
			END) AS date_of_intro,
          IFNULL(availabilityyteol,'') AS availabilityyteol,
          IFNULL(estimated_yteol,'') AS estimated_yteol,
		  TO_DATE(
			CASE WHEN alert_prediction_date = '' THEN '01-JAN-1900'
			  WHEN alert_prediction_date IS NULL THEN '01-JAN-1900'
			  WHEN alert_prediction_date = 'NULL' THEN '01-JAN-1900'
			ELSE alert_prediction_date 
			END) AS alert_prediction_date,
          IFNULL(life_cycle_comments,'') AS life_cycle_comments,
          IFNULL(life_cycle_information_source,'') AS life_cycle_information_source,
          FRMW_EXTRACTED_ON,
          ROW_NUMBER() OVER(PARTITION BY part_objectid ORDER BY FRMW_EXTRACTED_ON DESC) AS rownum
   FROM CONFORMED.IHS_LIFECYCLE) a
   WHERE rownum = 1;
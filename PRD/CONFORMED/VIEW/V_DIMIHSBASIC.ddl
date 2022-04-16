create or replace view V_DIMIHSBASIC(
	OBJECTID,
	MANUFACTURERPARTNUMBER,
	MANUFACTURERNAME,
	PARTDESCRIPTION,
	MFRPACKAGEDESCRIPTION,
	REACHCOMPLIANT,
	EUROHSCOMPLIANT,
	CHINAROHSCOMPLIANT,
	MANUFACTUREURL,
	STATUS,
	GENERICNUMBER,
	CATEGORY,
	DATASHEETURL,
	FRMWEXTRACTEDON,
	HASH_VALUE
) as
SELECT
  objectid                  AS ObjectID,
  manufacturer_part_number  AS ManufacturerPartNumber,
  manufacturer_name         AS ManufacturerName,
  part_description          AS PartDescription,
  mfr_package_description   AS MfrPackageDescription,
  reach_compliant           AS ReachCompliant,
  eu_rohs_compliant         AS EuRohsCompliant,
  china_rohs_compliant      AS ChinaRohsCompliant,
  manufacturer_url          AS ManufactureUrl,
  Status                    AS Status,
  generic_number            AS GenericNumber,
  category                  AS Category,
  datasheet_url             AS DatasheetUrl,
  FRMW_EXTRACTED_ON         AS FrmwExtractedOn,
  HASH(
        manufacturer_part_number,
        manufacturer_name,
        part_description,
        mfr_package_description,
        reach_compliant,
        eu_rohs_compliant,
        china_rohs_compliant,
        manufacturer_url,
        Status,
        generic_number,
        category,
        datasheet_url
      ) 					As HASH_VALUE
FROM
    (
        SELECT
          objectid,
          IFNULL(manufacturer_part_number,'') AS manufacturer_part_number,
          IFNULL(manufacturer_name,'') AS manufacturer_name,
          IFNULL(part_description,'') AS part_description,
          IFNULL(mfr_package_description,'') AS mfr_package_description,
          IFNULL(reach_compliant,'') AS reach_compliant,
          IFNULL(eu_rohs_compliant,'') AS eu_rohs_compliant,
          IFNULL(china_rohs_compliant,'') AS china_rohs_compliant,
          IFNULL(manufacturer_url,'') AS manufacturer_url,
          IFNULL(status,'') AS Status,
          IFNULL(generic_number,'') AS generic_number,
          IFNULL(category,'') AS category,
          IFNULL(datasheet_url,'') AS datasheet_url,
          FRMW_EXTRACTED_ON,
          row_number() OVER(PARTITION BY objectid ORDER BY FRMW_EXTRACTED_ON DESC) AS rownum
        FROM CONFORMED.IHS_BASIC
    ) basic
        WHERE rownum = 1;
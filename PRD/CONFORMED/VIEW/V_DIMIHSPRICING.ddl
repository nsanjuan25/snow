create or replace view V_DIMIHSPRICING(
	PARTOBJECTID,
	MANUFACTUREROBJECTID,
	MANUFACTURERPARTNUMBER,
	MANUFACTURERFULLNAME,
	AVERAGEPRICE,
	LYTICAPRICE,
	FRMWEXTRACTEDON,
	HASH_VALUE
) as               
SELECT
  part_objectid             AS PartObjectID,
  manufacturer_objectid     AS ManufacturerObjectID,
  manufacturer_part_number  AS ManufacturerPartNumber,
  manufacturer_full_name    AS ManufacturerFullName,
  average_price             AS AveragePrice,
  lytica_price              AS LyticaPrice,
  FRMW_EXTRACTED_ON         AS FrmwExtractedOn,
  HASH(
        manufacturer_objectid,
        manufacturer_part_number,
        manufacturer_full_name,
        average_price,
        lytica_price
       )                    As HASH_VALUE
FROM
  (SELECT
    part_objectid,
    manufacturer_objectid,
    IFNULL(manufacturer_part_number,'') AS manufacturer_part_number,
    IFNULL(manufacturer_full_name,'') AS manufacturer_full_name,
    CAST( CASE WHEN average_price IS NULL THEN 0
					WHEN average_price = 'NULL' THEN 0
					WHEN average_price = '' THEN 0
					ELSE average_price
		  END AS DECIMAL(38,5))	AS average_price,
    CAST( CASE WHEN lytica_price IS NULL THEN 0
					WHEN lytica_price = 'NULL' THEN 0
					WHEN lytica_price = '' THEN 0
					ELSE lytica_price
		  END AS DECIMAL(38,5))	AS lytica_price,
    FRMW_EXTRACTED_ON,
    ROW_NUMBER() OVER(PARTITION BY part_objectid ORDER BY FRMW_EXTRACTED_ON DESC) AS rownum
   FROM CONFORMED.IHS_PRICING) a
WHERE rownum = 1;
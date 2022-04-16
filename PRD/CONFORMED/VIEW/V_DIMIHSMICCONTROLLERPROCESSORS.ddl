create or replace view V_DIMIHSMICCONTROLLERPROCESSORS(
	PARTOBJECTID,
	MANUFACTURERNAME,
	MANUFACTURERPARTNUMBER,
	GLOBALMANUFACTURERNAME,
	BITSIZE,
	ROMWORDS,
	SUBCATEGORY,
	TECHNOLOGY,
	CPUFAMILY,
	TEMPERATUREGRADE,
	PERIPHERALICSTYPE,
	PACKAGECODE,
	ROMPROGRAMMABILITY,
	FRMWEXTRACTEDON,
	HASH_VALUE
) as 
SELECT
    PartObjectId,
    ManufacturerName,
    ManufacturerPartNumber,
    GlobalManufacturerName,
    BitSize,
    RomWords,
    SubCategory,
    Technology,
    CpuFamily,
    TemperatureGrade,
    PeripheralIcsType,
    PackageCode,
    RomProgrammability,
    FrmwExtractedOn,
    HASH(
        ManufacturerName,
        ManufacturerPartNumber,
        GlobalManufacturerName,
        BitSize,
        RomWords,
        SubCategory,
        Technology,
        CpuFamily,
        TemperatureGrade,
        PeripheralIcsType,
        PackageCode,
        RomProgrammability
       )                       AS HASH_VALUE
FROM
(
  SELECT
    ics.ihs_objectid AS PartObjectId,
    IFNULL(basic.manufacturer_name,'') AS ManufacturerName,
    IFNULL(basic.manufacturer_part_number,'') AS ManufacturerPartNumber,
    IFNULL(c.corporationname,'') AS GlobalManufacturerName,
    IFNULL(ics.bit_size,'') AS BitSize,
    IFNULL(ics.rom_words,'') AS RomWords,
    IFNULL(ics.sub_category,'') AS SubCategory,
    IFNULL(ics.technology,'') AS Technology,
    IFNULL(ics.cpu_family,'') AS CpuFamily,
    IFNULL(ics.temperature_grade,'') AS TemperatureGrade,
    IFNULL(ics.ups_ucs_peripheral_ics_type,'') AS PeripheralIcsType,
    IFNULL(ics.package_code,'') AS PackageCode,
    IFNULL(ics.rom_programmability,'') AS RomProgrammability,
    ics.FRMW_EXTRACTED_ON AS FrmwExtractedOn,
    ROW_NUMBER() OVER(PARTITION BY IHS_OBJECTID ORDER BY ics.FRMW_EXTRACTED_ON DESC) AS ROWNUM
  FROM CONFORMED.IHS_UPS_UCS_PERIPHERAL_ICS ics
  INNER JOIN CONFORMED.IHS_BASIC basic
      ON ics.ihs_objectid = basic.objectid
  LEFT OUTER JOIN SCMDB_CORPORATIONDS cds
      ON basic.manufacturer_name = cds.corporationdsname
      AND cds.datasourceid = 21
  LEFT OUTER JOIN SCMDB_CORPORATION c
      ON cds.corporationid = c.corporationid
) a
WHERE ROWNUM = 1;
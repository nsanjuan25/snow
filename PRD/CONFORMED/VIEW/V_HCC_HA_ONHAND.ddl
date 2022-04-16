create or replace view V_HCC_HA_ONHAND(
	DATASOURCEKEY,
	INVENTORYDTS,
	ZREGION,
	SITECODE,
	SITEPARTCODE,
	BATCHNUMBER,
	LOCATION,
	Z_DISKZ,
	INVENTORYTYPECODE,
	STOCKCAT,
	VALSPECST,
	CUSTOMER,
	SUPPLIERCODE,
	PURCH_ORG,
	COMP_CODE,
	UNITOFMEASUREDSCODE,
	VAL_TYPE,
	RECORDMODE,
	DATEFROM,
	Z_VENGRP,
	QUANTITY,
	ZK_RATE,
	PRICE_UNIT,
	COND_CURR,
	PRICE_MAT,
	CURRENCY,
	ZPRC_UNIT,
	MAT_PLANT,
	NETTABLEFLAG,
	SERIALNUMBER,
	DELETEFLAG,
	MRPINDICATOR,
	BIN,
	STOCKDATE,
	SPECIALSTOCKSCODE
) as
   SELECT 2 DataSourceKey, 
             date(o.FRMW_EXTRACTED_ON)  InventoryDTS, 
            -- date(sysdate()) InventoryDTS,
             '' ZREGION, 
                IFF( left(o.plant,1) = '_' , substring(o.plant,2 , len(o.plant) ) , o.plant )  SiteCode, 
                regexp_replace(o.material, '^0+', '') SitePartCode, 
                '' BatchNumber, 
                   o.loc_id Location, 
                   '' Z_DISKZ, 
                      CASE 
                          WHEN upper(o.invtype) IN ('07-I-0')  THEN 'I' 
                          WHEN upper(o.invtype) IN ('07-OP-0') THEN 'F' 
                          WHEN upper(o.invtype) IN ('07-CC-0') THEN 'F' 
                          WHEN upper(o.invtype) IN ('07-X-0')  THEN 'X' 
                          WHEN upper(o.invtype) IN ('07-S-0')  THEN 'S' 
                          WHEN upper(o.invtype) IN ('07-F-0')  THEN 'F' 
                          ELSE upper(o.invtype)
                      END InventoryTypeCode, 
                      CASE 
                          WHEN upper(invtype) IN ('07-I-0') THEN 'I' 
                          WHEN upper(invtype) IN ('07-OP-0',
                                                  '07-CC-0') THEN 'F' 
                          WHEN upper(invtype) IN ('07-X-0') THEN 'X' 
                          WHEN upper(invtype) IN ('07-S-0') THEN 'S' 
                          WHEN upper(invtype) IN ('07-F-0') THEN 'F' 
                          ELSE upper(invtype )
                      END STOCKCAT, 
                      CASE 
                          WHEN upper(src) IN (upper('VConsigned'))    THEN 'K' 
                          WHEN upper(src) IN (upper('CConsigned'))    THEN 'W' 
                          WHEN upper(src) IN (upper('ProjectStock'))  THEN 'Q' 
                          WHEN upper(src) IN (upper('VndrParts'))     THEN 'O' 
                          WHEN upper(src) IN (upper('SalesOrder'))    THEN 'E' 
                          ELSE '' 
                      END valspecst, 
                      '' CUSTOMER, 
                         '' Suppliercode, 
                            w.ekorg purch_org, 
                            k.bukrs comp_code, 
                            '' UnitOfMeasureDSCode, 
                               '' VAL_TYPE, 
                                  '' RECORDMODE, 
                                     '' DATEFROM, 
                                        o.vnd_grp Z_VENGRP, 
                                        o.qty  Quantity, 
                                        o.xrate zk_rate, 
                                        1 PRICE_UNIT, 
                                        '' COND_CURR, 
                                           unitprice PRICE_MAT, 
                                           o.waers currency, 
                                           1 ZPRC_UNIT, 
                                           o.plant MAT_PLANT, 
                                           CASE 
                                               WHEN upper(o.invtype) NOT IN ('07-OP-0', '07-CC-0') THEN 1 
                                               ELSE 0
                                           END NETTABLEFLAG ,
                0	SerialNumber,
  0	DeleteFlag,
  0	MRPIndicator,
  0	Bin,
  '19010101' StockDate,
  CASE 
      WHEN upper(src) IN (upper('VConsigned'))    THEN 'K' 
      WHEN upper(src) IN (upper('CConsigned'))    THEN 'W' 
      WHEN upper(src) IN (upper('ProjectStock'))  THEN 'Q' 
      WHEN upper(src) IN (upper('VndrParts'))     THEN 'O' 
      WHEN upper(src) IN (upper('SalesOrder'))    THEN 'E' 
      ELSE '' 
  END SPECIALSTOCKSCODE             
FROM 
    CONFORMED.HCC_HA_ON_HAND o 
    LEFT OUTER JOIN CONFORMED.hcc_ha_t001k k ON o.plant = k.bwkey 
    LEFT OUTER JOIN CONFORMED.hcc_ha_t001w w ON o.plant = w.werks;
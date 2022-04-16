create or replace view V_ECC_HA_ONHAND(
	DATASOURCEKEY,
	INVENTORYDTS,
	ZREGION,
	SITECODE,
	SITEPARTCODE,
	BATCHNUMBER,
	LOCATION,
	Z_DISKZ,
	INVENTORYTYPECODE,
	STOCKTYPECODE,
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
/*-------------------------------------------------------------------------------------------

This view  used in SAP.FactInventory
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-**-**								Initial Revision
2021-10-25		Sridhar Koormadasu		Change NETTABLEFLAG condition based on hadoop N=0, NN=1
*/
SELECT 
	1 DataSourceKey,
	CC_EDATE InventoryDTS,      
	ZREGION, 
	PLANT SiteCode, 
	MATERIAL SitePartCode, 
	BATCH BatchNumber, 
	STOR_LOC Location, 
	Z_DISKZ, 
	CASE upper(trim(stocktype))
	WHEN 'A' THEN 'F'	 	 
	WHEN 'B' THEN 'X'	 	 
	WHEN 'D' THEN 'S'	 	 
	WHEN 'F' THEN 'I'	 	 
	WHEN 'H' THEN 'I'	 	 
	WHEN 'K' THEN 'F'	 	 
	WHEN 'Q' THEN 'F'	 	 
	ELSE 'UNASSIGNED'	 	 
	END InventoryTypeCode,       
	stocktype as stocktypeCode,  
	--STOCKTYPE InventoryTypeCode, 
	STOCKCAT, 
	VALSPECST, 
	CUSTOMER, 
	VENDOR Suppliercode, 
	PURCH_ORG, 
	COMP_CODE, 
	BASE_UOM UnitOfMeasureDSCode, 
	VAL_TYPE, 
	RECORDMODE, 
	DATEFROM, 
	Z_VENGRP, 
	ZQUANTITY QUANTITY, 
	ZK_RATE, 
	PRICE_UNIT, 
	COND_CURR, 
	PRICE_MAT, 
	CURRENCY, 
	ZPRC_UNIT, 
	MAT_PLANT, 
	CASE 
		WHEN (stocktype = 'A' 
				AND z_diskz != '1' 
				AND valspecst != 'O' 
				AND valspecst != 'W') THEN 0
		WHEN (stocktype = 'A' 
				AND z_diskz = '1' 
				AND valspecst != 'O' 
				AND valspecst != 'W') THEN  1
		WHEN (stocktype = 'D' 
				AND z_diskz != '1' 
				AND valspecst != 'O' 
				AND valspecst != 'W') THEN  1  
		WHEN (stocktype = 'D' 
				AND z_diskz = '1' 
				AND valspecst != 'O' 
				AND valspecst != 'W') THEN 1
		WHEN ((stocktype = 'B' 
				OR stocktype = 'L' 
				OR stocktype = 'O' 
				OR stocktype = 'R') 
				AND z_diskz != '1' 
				AND valspecst != 'O' 
				AND valspecst != 'W') THEN 0 
		WHEN (stocktype = 'F' 
				AND z_diskz != '1' 
				AND valspecst != 'O' 
				AND valspecst != 'W') THEN 0 
		WHEN (stocktype = 'F' 
				AND z_diskz = '1' 
				AND valspecst != 'O' 
				AND valspecst != 'W') THEN  1
		WHEN (valspecst = 'O') THEN 1 
		WHEN (valspecst = 'W') THEN 1 
		ELSE 1
	END NETTABLEFLAG ,
	0	SerialNumber,
	0	DeleteFlag,
	0	MRPIndicator,
	0	Bin,
	'19010101'	StockDate,
	IFNULL(valspecst, '') SPECIALSTOCKSCODE 
FROM        
    CONFORMED.BW_HA_ONHAND;
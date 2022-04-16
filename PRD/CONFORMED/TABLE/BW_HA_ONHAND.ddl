create or replace TABLE BW_HA_ONHAND (
	CC_EDATE VARCHAR(10),
	ZREGION VARCHAR(1),
	PLANT VARCHAR(4),
	MATERIAL VARCHAR(18),
	BATCH VARCHAR(10),
	STOR_LOC VARCHAR(4),
	Z_DISKZ VARCHAR(1),
	STOCKTYPE VARCHAR(1),
	STOCKCAT VARCHAR(1),
	VALSPECST VARCHAR(1),
	CUSTOMER VARCHAR(10),
	VENDOR VARCHAR(10),
	PURCH_ORG VARCHAR(4),
	COMP_CODE VARCHAR(4),
	BASE_UOM VARCHAR(3),
	VAL_TYPE VARCHAR(10),
	RECORDMODE VARCHAR(1),
	DATEFROM VARCHAR(8),
	Z_VENGRP VARCHAR(20),
	ZQUANTITY NUMBER(38,3),
	ZK_RATE NUMBER(38,2),
	PRICE_UNIT NUMBER(38,3),
	COND_CURR VARCHAR(5),
	PRICE_MAT NUMBER(38,2),
	CURRENCY VARCHAR(5),
	ZPRC_UNIT NUMBER(38,3),
	MAT_PLANT VARCHAR(18),
	Z_FLAG VARCHAR(2),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
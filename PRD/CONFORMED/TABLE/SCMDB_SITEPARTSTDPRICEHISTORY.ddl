create or replace TABLE SCMDB_SITEPARTSTDPRICEHISTORY (
	STDPH_ID NUMBER(38,0),
	SITEPARTID NUMBER(38,0),
	P0EFFECTIVEFROMDATE TIMESTAMP_NTZ(9),
	EFFECTIVEFROMDATE TIMESTAMP_NTZ(9),
	EFFECTIVETODATE TIMESTAMP_NTZ(9),
	STDUNITCOSTP0 NUMBER(38,6),
	LOCALCURRENCYTOUSDEXCHANGERATE NUMBER(38,6),
	UPDATEUSER VARCHAR(25),
	SPPH_CREATEDTS TIMESTAMP_NTZ(9),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
create or replace TABLE SCMDB_MOVEMENTTYPESTD (
	MOVEMENTTYPESTDID NUMBER(38,0),
	MOVEMENTTYPESTDCODE VARCHAR(30),
	DOUBLESIDEDTRANSACTION VARCHAR(1),
	RECEIPT BOOLEAN,
	CONSUMPTION BOOLEAN,
	ADJUSTMENT BOOLEAN,
	SALE BOOLEAN,
	SALETYPECODE VARCHAR(50),
	NOTES VARCHAR(1),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
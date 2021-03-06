create or replace TABLE BW_HA_COMP_WHU (
	MANDT VARCHAR(3),
	WHUID NUMBER(38,0),
	TIMEST NUMBER(38,0),
	PLANT VARCHAR(4),
	COMPONENT VARCHAR(18),
	CDATE VARCHAR(8),
	BOM VARCHAR(8),
	BOMUSG VARCHAR(1),
	SUBASSEM VARCHAR(18),
	ASSEMBLY VARCHAR(18),
	DATEFROM VARCHAR(8),
	DATETO VARCHAR(8),
	BLEVEL NUMBER(38,0),
	COMP_QTY NUMBER(38,0),
	NLFZT NUMBER(38,3),
	WHU VARCHAR(5000),
	UNIT VARCHAR(3),
	UDATE VARCHAR(8),
	SEQGEN NUMBER(38,0),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
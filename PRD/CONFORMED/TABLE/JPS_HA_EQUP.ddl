create or replace TABLE JPS_HA_EQUP (
	MANDT VARCHAR(3),
	QUNUM VARCHAR(10),
	QUPOS VARCHAR(3),
	BESKZ VARCHAR(1),
	SOBES VARCHAR(1),
	LIFNR VARCHAR(10),
	BEWRK VARCHAR(4),
	QUOTE NUMBER(38,0),
	QUBMG NUMBER(38,3),
	QUMNG NUMBER(38,3),
	MAXMG NUMBER(38,3),
	VERID VARCHAR(4),
	MAXLS NUMBER(38,3),
	MINLS NUMBER(38,3),
	RDPRF VARCHAR(4),
	KZEIN VARCHAR(1),
	ABRMG NUMBER(38,3),
	ABPER VARCHAR(1),
	ABANZ VARCHAR(2),
	PREIH VARCHAR(2),
	EMATN VARCHAR(40),
	PLIFZ NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
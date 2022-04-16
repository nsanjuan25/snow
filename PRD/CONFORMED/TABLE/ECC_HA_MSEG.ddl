create or replace TABLE ECC_HA_MSEG (
	MANDT VARCHAR(3),
	MBLNR VARCHAR(10),
	MJAHR VARCHAR(4),
	ZEILE VARCHAR(4),
	BWART VARCHAR(3),
	MATNR VARCHAR(18),
	WERKS VARCHAR(4),
	LGORT VARCHAR(4),
	CHARG VARCHAR(10),
	INSMK VARCHAR(1),
	SOBKZ VARCHAR(1),
	LIFNR VARCHAR(10),
	KDAUF VARCHAR(10),
	KDPOS VARCHAR(6),
	SHKZG VARCHAR(1),
	WAERS VARCHAR(5),
	DMBTR NUMBER(38,2),
	MENGE NUMBER(38,3),
	MEINS VARCHAR(3),
	EBELN VARCHAR(10),
	EBELP VARCHAR(5),
	SGTXT VARCHAR(50),
	BUKRS VARCHAR(4),
	KZBEW VARCHAR(1),
	GRUND VARCHAR(4),
	EMATN VARCHAR(18),
	BUDAT_MKPF VARCHAR(8),
	ANLN1 VARCHAR(12),
	AUFNR VARCHAR(12),
	KOSTL VARCHAR(10),
	PS_PSP_PNR VARCHAR(8),
	SAKTO VARCHAR(10),
	BUZEI VARCHAR(3),
	SEQGEN NUMBER(38,0),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
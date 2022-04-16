create or replace TABLE ECC_HA_PBED (
	MANDT VARCHAR(3),
	BDZEI VARCHAR(12),
	PDATU VARCHAR(8),
	WDATU VARCHAR(8),
	AENAM VARCHAR(12),
	LAEDA VARCHAR(8),
	MEINS VARCHAR(3),
	PLNMG NUMBER(38,3),
	ENTMG NUMBER(38,3),
	UPLMG NUMBER(38,3),
	ENTLI VARCHAR(1),
	ENTLU VARCHAR(1),
	PERXX VARCHAR(6),
	SERNR VARCHAR(8),
	VERID VARCHAR(4),
	ERFME VARCHAR(3),
	ERFMG NUMBER(38,3),
	UMREZ NUMBER(38,0),
	UMREN NUMBER(38,0),
	FIXMG NUMBER(38,3),
	TXTET VARCHAR(1),
	LOEVR VARCHAR(1),
	CUOBJ VARCHAR(18),
	STPKT VARCHAR(1),
	TECHS VARCHAR(12),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
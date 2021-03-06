create or replace TABLE ECC_HA_VBEP (
	MANDT VARCHAR(3),
	VBELN VARCHAR(10),
	POSNR VARCHAR(6),
	ETENR VARCHAR(4),
	ETTYP VARCHAR(2),
	LFREL VARCHAR(1),
	EDATU VARCHAR(8),
	EZEIT VARCHAR(6),
	WMENG NUMBER(38,3),
	BMENG NUMBER(38,3),
	VRKME VARCHAR(3),
	LMENG NUMBER(38,3),
	MEINS VARCHAR(3),
	BDDAT VARCHAR(8),
	BDART VARCHAR(2),
	PLART VARCHAR(1),
	VBELE VARCHAR(10),
	POSNE VARCHAR(6),
	ETENE VARCHAR(4),
	RSDAT VARCHAR(8),
	IDNNR VARCHAR(10),
	BANFN VARCHAR(10),
	BSART VARCHAR(4),
	BSTYP VARCHAR(1),
	WEPOS VARCHAR(1),
	REPOS VARCHAR(1),
	LRGDT VARCHAR(8),
	PRGRS VARCHAR(1),
	TDDAT VARCHAR(8),
	MBDAT VARCHAR(8),
	LDDAT VARCHAR(8),
	WADAT VARCHAR(8),
	CMENG NUMBER(38,3),
	LIFSP VARCHAR(2),
	GRSTR VARCHAR(3),
	ABART VARCHAR(1),
	ABRUF VARCHAR(10),
	ROMS1 NUMBER(38,3),
	ROMS2 NUMBER(38,3),
	ROMS3 NUMBER(38,3),
	ROMEI VARCHAR(3),
	RFORM VARCHAR(2),
	UMVKZ NUMBER(38,0),
	UMVKN NUMBER(38,0),
	VERFP VARCHAR(1),
	BWART VARCHAR(3),
	BNFPO VARCHAR(5),
	ETART VARCHAR(1),
	AUFNR VARCHAR(12),
	PLNUM VARCHAR(10),
	SERNR VARCHAR(8),
	AESKD VARCHAR(17),
	ABGES FLOAT,
	MBUHR VARCHAR(6),
	TDUHR VARCHAR(6),
	LDUHR VARCHAR(6),
	WAUHR VARCHAR(6),
	AULWE VARCHAR(10),
	MBDAT_DRS VARCHAR(8),
	HANDOVERDATE VARCHAR(8),
	HANDOVERTIME VARCHAR(6),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
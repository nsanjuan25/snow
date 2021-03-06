create or replace TABLE ECC_HA_VBBE (
	MANDT VARCHAR(3),
	VBELN VARCHAR(10),
	POSNR VARCHAR(6),
	ETENR VARCHAR(4),
	MATNR VARCHAR(18),
	WERKS VARCHAR(4),
	BERID VARCHAR(10),
	MBDAT VARCHAR(8),
	LGORT VARCHAR(4),
	CHARG VARCHAR(10),
	VBTYP VARCHAR(1),
	BDART VARCHAR(2),
	PLART VARCHAR(1),
	OMENG NUMBER(38,3),
	VMENG NUMBER(38,3),
	MEINS VARCHAR(3),
	VBELE VARCHAR(10),
	POSNE VARCHAR(6),
	ETENE VARCHAR(4),
	AWAHR VARCHAR(3),
	AUART VARCHAR(4),
	PROJN VARCHAR(16),
	KUNNR VARCHAR(10),
	NODIS VARCHAR(1),
	VPZUO VARCHAR(1),
	VPMAT VARCHAR(18),
	VPWRK VARCHAR(4),
	PRBME VARCHAR(3),
	UMREF FLOAT,
	PZMNG NUMBER(38,3),
	KNTTP VARCHAR(1),
	SOBKZ VARCHAR(1),
	KZVBR VARCHAR(1),
	SERNR VARCHAR(8),
	PSPEL VARCHAR(8),
	PLNKZ VARCHAR(1),
	CUOBJ VARCHAR(18),
	MONKZ VARCHAR(1),
	KZBWS VARCHAR(1),
	TECHS VARCHAR(12),
	SGT_RCAT VARCHAR(16),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
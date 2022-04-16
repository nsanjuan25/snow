create or replace TABLE BW_HA_VBRK (
	VBELN VARCHAR(10),
	POSNR VARCHAR(6),
	PERIV VARCHAR(2),
	ROCANCEL VARCHAR(1),
	AEDAT VARCHAR(8),
	BUKRS VARCHAR(4),
	BZIRK VARCHAR(6),
	FKART VARCHAR(4),
	FKDAT VARCHAR(8),
	FKTYP VARCHAR(1),
	KDGRP VARCHAR(2),
	KUNAG VARCHAR(10),
	KUNRG VARCHAR(10),
	AKTNR VARCHAR(10),
	AUBEL VARCHAR(10),
	AUPOS VARCHAR(6),
	BONUS VARCHAR(2),
	CHARG VARCHAR(10),
	EAN11 VARCHAR(18),
	ERDAT VARCHAR(8),
	FBUDA VARCHAR(8),
	KNUMA_AG VARCHAR(10),
	KURSK_DAT VARCHAR(8),
	KVGR1 VARCHAR(3),
	KVGR2 VARCHAR(3),
	KVGR3 VARCHAR(3),
	KVGR4 VARCHAR(3),
	KVGR5 VARCHAR(3),
	LGORT VARCHAR(4),
	MATWA VARCHAR(18),
	MVGR1 VARCHAR(3),
	MVGR2 VARCHAR(3),
	MVGR3 VARCHAR(3),
	MVGR4 VARCHAR(3),
	MVGR5 VARCHAR(3),
	PKUNRE VARCHAR(10),
	PKUNWE VARCHAR(10),
	POSAR VARCHAR(1),
	PRODH VARCHAR(18),
	PROVG VARCHAR(2),
	PRSDT VARCHAR(8),
	PSTYV VARCHAR(4),
	PVRTNR VARCHAR(8),
	STADAT VARCHAR(8),
	VDATU VARCHAR(8),
	VGBEL VARCHAR(10),
	VGPOS VARCHAR(6),
	VKBUR VARCHAR(4),
	VSTEL VARCHAR(4),
	WERKS VARCHAR(4),
	KURST VARCHAR(4),
	VBTYP VARCHAR(2),
	VKORG VARCHAR(4),
	VTWEG VARCHAR(2),
	KOKRS VARCHAR(4),
	KOSTL VARCHAR(10),
	MATKL VARCHAR(9),
	MATNR VARCHAR(18),
	SPART VARCHAR(2),
	SPARA VARCHAR(2),
	BWAPPLNM VARCHAR(30),
	BWVORG VARCHAR(3),
	FAREG VARCHAR(1),
	VKGRP VARCHAR(3),
	KURRF NUMBER(38,3),
	BONBA NUMBER(38,2),
	BRGEW NUMBER(38,3),
	FKIMG NUMBER(38,3),
	FKLMG NUMBER(38,3),
	KURSK FLOAT,
	LMENG NUMBER(38,3),
	MWSBP NUMBER(38,2),
	NTGEW NUMBER(38,3),
	SKFBP NUMBER(38,2),
	SMENG NUMBER(38,3),
	UMVKN NUMBER(38,3),
	UMVKZ NUMBER(38,3),
	VOLUM NUMBER(38,3),
	WAVWR NUMBER(38,2),
	ANZFKPOS NUMBER(38,3),
	KZWI1 NUMBER(38,2),
	KZWI2 NUMBER(38,2),
	KZWI3 NUMBER(38,2),
	KZWI4 NUMBER(38,2),
	KZWI5 NUMBER(38,2),
	KZWI6 NUMBER(38,2),
	NETWR NUMBER(38,2),
	STCUR FLOAT,
	BRTWR NUMBER(38,2),
	EXRATEXACC FLOAT,
	WAERK VARCHAR(5),
	HWAER VARCHAR(5),
	STWAE VARCHAR(5),
	GEWEI VARCHAR(3),
	VRKME VARCHAR(3),
	MEINS VARCHAR(3),
	VOLEH VARCHAR(3),
	PS_POSID VARCHAR(24),
	FKSTO VARCHAR(1),
	EXNUM VARCHAR(10),
	SFAKN VARCHAR(10),
	SHKZG VARCHAR(1),
	ZZDATE VARCHAR(8),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
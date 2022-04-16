create or replace TABLE ECC_HA_BKPF (
	MANDT VARCHAR(3),
	BUKRS VARCHAR(4),
	BELNR VARCHAR(10),
	GJAHR VARCHAR(4),
	BLART VARCHAR(2),
	BLDAT VARCHAR(8),
	BUDAT VARCHAR(8),
	MONAT VARCHAR(2),
	CPUDT VARCHAR(8),
	CPUTM VARCHAR(6),
	AEDAT VARCHAR(8),
	UPDDT VARCHAR(8),
	WWERT VARCHAR(8),
	USNAM VARCHAR(12),
	TCODE VARCHAR(20),
	BVORG VARCHAR(16),
	XBLNR VARCHAR(16),
	DBBLG VARCHAR(10),
	STBLG VARCHAR(10),
	STJAH VARCHAR(4),
	BKTXT VARCHAR(25),
	WAERS VARCHAR(5),
	KURSF NUMBER(38,5),
	KZWRS VARCHAR(5),
	KZKRS NUMBER(38,5),
	BSTAT VARCHAR(1),
	XNETB VARCHAR(1),
	FRATH NUMBER(38,2),
	XRUEB VARCHAR(1),
	GLVOR VARCHAR(4),
	GRPID VARCHAR(12),
	DOKID VARCHAR(40),
	ARCID VARCHAR(10),
	IBLAR VARCHAR(2),
	AWTYP VARCHAR(5),
	AWKEY VARCHAR(20),
	FIKRS VARCHAR(4),
	HWAER VARCHAR(5),
	HWAE2 VARCHAR(5),
	HWAE3 VARCHAR(5),
	KURS2 NUMBER(38,5),
	KURS3 NUMBER(38,5),
	BASW2 VARCHAR(1),
	BASW3 VARCHAR(1),
	UMRD2 VARCHAR(1),
	UMRD3 VARCHAR(1),
	XSTOV VARCHAR(1),
	STODT VARCHAR(8),
	XMWST VARCHAR(1),
	CURT2 VARCHAR(2),
	CURT3 VARCHAR(2),
	KUTY2 VARCHAR(4),
	KUTY3 VARCHAR(4),
	XSNET VARCHAR(1),
	AUSBK VARCHAR(4),
	XUSVR VARCHAR(1),
	DUEFL VARCHAR(1),
	AWSYS VARCHAR(10),
	TXKRS NUMBER(38,5),
	LOTKZ VARCHAR(10),
	XWVOF VARCHAR(1),
	STGRD VARCHAR(2),
	PPNAM VARCHAR(12),
	BRNCH VARCHAR(4),
	NUMPG VARCHAR(3),
	ADISC VARCHAR(1),
	XREF1_HD VARCHAR(20),
	XREF2_HD VARCHAR(20),
	XREVERSAL VARCHAR(1),
	REINDAT VARCHAR(8),
	RLDNR VARCHAR(2),
	LDGRP VARCHAR(4),
	PROPMANO VARCHAR(13),
	XBLNR_ALT VARCHAR(26),
	VATDATE VARCHAR(8),
	DOCCAT VARCHAR(6),
	XSPLIT VARCHAR(1),
	CASH_ALLOC VARCHAR(1),
	FOLLOW_ON VARCHAR(1),
	XREORG VARCHAR(1),
	SUBSET VARCHAR(4),
	KURST VARCHAR(4),
	KURSX NUMBER(38,14),
	KUR2X NUMBER(38,14),
	KUR3X NUMBER(38,14),
	XMCA VARCHAR(1),
	SAPF15_STATUS VARCHAR(1),
	PSOTY VARCHAR(2),
	PSOAK VARCHAR(10),
	PSOKS VARCHAR(10),
	PSOSG VARCHAR(1),
	PSOFN VARCHAR(30),
	INTFORM VARCHAR(4),
	INTDATE VARCHAR(8),
	PSOBT VARCHAR(8),
	PSOZL VARCHAR(1),
	PSODT VARCHAR(8),
	PSOTM VARCHAR(6),
	FM_UMART VARCHAR(1),
	CCINS VARCHAR(4),
	CCNUM VARCHAR(25),
	SSBLK VARCHAR(1),
	BATCH VARCHAR(10),
	SNAME VARCHAR(12),
	SAMPLED VARCHAR(1),
	EXCLUDE_FLAG VARCHAR(1),
	BLIND VARCHAR(1),
	OFFSET_STATUS VARCHAR(2),
	OFFSET_REFER_DAT VARCHAR(8),
	PENRC VARCHAR(2),
	KNUMV VARCHAR(10),
	CTXKRS NUMBER(38,5),
	RESUBMISSION VARCHAR(8),
	SEQGEN NUMBER(38,0),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
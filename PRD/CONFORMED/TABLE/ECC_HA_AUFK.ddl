create or replace TABLE ECC_HA_AUFK (
	MANDT VARCHAR(3),
	AUFNR VARCHAR(12),
	AUART VARCHAR(4),
	AUTYP VARCHAR(2),
	REFNR VARCHAR(12),
	ERNAM VARCHAR(12),
	ERDAT VARCHAR(8),
	AENAM VARCHAR(12),
	AEDAT VARCHAR(8),
	KTEXT VARCHAR(40),
	LTEXT VARCHAR(1),
	BUKRS VARCHAR(4),
	WERKS VARCHAR(4),
	GSBER VARCHAR(4),
	KOKRS VARCHAR(4),
	CCKEY VARCHAR(23),
	KOSTV VARCHAR(10),
	STORT VARCHAR(10),
	SOWRK VARCHAR(4),
	ASTKZ VARCHAR(1),
	WAERS VARCHAR(5),
	ASTNR VARCHAR(2),
	STDAT VARCHAR(8),
	ESTNR VARCHAR(2),
	PHAS0 VARCHAR(1),
	PHAS1 VARCHAR(1),
	PHAS2 VARCHAR(1),
	PHAS3 VARCHAR(1),
	PDAT1 VARCHAR(8),
	PDAT2 VARCHAR(8),
	PDAT3 VARCHAR(8),
	IDAT1 VARCHAR(8),
	IDAT2 VARCHAR(8),
	IDAT3 VARCHAR(8),
	OBJID VARCHAR(1),
	VOGRP VARCHAR(4),
	LOEKZ VARCHAR(1),
	PLGKZ VARCHAR(1),
	KVEWE VARCHAR(1),
	KAPPL VARCHAR(2),
	KALSM VARCHAR(6),
	ZSCHL VARCHAR(6),
	ABKRS VARCHAR(2),
	KSTAR VARCHAR(10),
	KOSTL VARCHAR(10),
	SAKNR VARCHAR(10),
	SETNM VARCHAR(12),
	CYCLE VARCHAR(10),
	SDATE VARCHAR(8),
	SEQNR VARCHAR(4),
	USER0 VARCHAR(20),
	USER1 VARCHAR(20),
	USER2 VARCHAR(20),
	USER3 VARCHAR(20),
	USER4 NUMBER(38,2),
	USER5 VARCHAR(8),
	USER6 VARCHAR(15),
	USER7 VARCHAR(8),
	USER8 VARCHAR(8),
	USER9 VARCHAR(1),
	OBJNR VARCHAR(22),
	PRCTR VARCHAR(10),
	PSPEL VARCHAR(8),
	AWSLS VARCHAR(6),
	ABGSL VARCHAR(6),
	TXJCD VARCHAR(15),
	FUNC_AREA VARCHAR(16),
	SCOPE VARCHAR(2),
	PLINT VARCHAR(1),
	KDAUF VARCHAR(10),
	KDPOS VARCHAR(6),
	AUFEX VARCHAR(20),
	IVPRO VARCHAR(6),
	LOGSYSTEM VARCHAR(10),
	FLG_MLTPS VARCHAR(1),
	ABUKR VARCHAR(4),
	AKSTL VARCHAR(10),
	SIZECL VARCHAR(2),
	IZWEK VARCHAR(2),
	UMWKZ VARCHAR(5),
	KSTEMPF VARCHAR(1),
	ZSCHM VARCHAR(7),
	PKOSA VARCHAR(12),
	ANFAUFNR VARCHAR(12),
	PROCNR VARCHAR(12),
	PROTY VARCHAR(4),
	RSORD VARCHAR(1),
	BEMOT VARCHAR(2),
	ADRNRA VARCHAR(10),
	ERFZEIT VARCHAR(6),
	AEZEIT VARCHAR(6),
	CSTG_VRNT VARCHAR(4),
	COSTESTNR VARCHAR(12),
	VERAA_USER VARCHAR(12),
	ZZPRCTR VARCHAR(10),
	ZZABKRS VARCHAR(2),
	ZZPHAS0 VARCHAR(1),
	ZZPHAS1 VARCHAR(1),
	ZZPHAS2 VARCHAR(1),
	ZZPHAS3 VARCHAR(1),
	VNAME VARCHAR(6),
	RECID VARCHAR(2),
	ETYPE VARCHAR(3),
	OTYPE VARCHAR(4),
	JV_JIBCL VARCHAR(3),
	JV_JIBSA VARCHAR(5),
	JV_OCO VARCHAR(1),
	CUM_INDCU VARCHAR(1),
	CUM_CMNUM VARCHAR(12),
	CUM_AUEST VARCHAR(1),
	CUM_DESNUM VARCHAR(12),
	VAPLZ VARCHAR(8),
	WAWRK VARCHAR(4),
	FERC_IND VARCHAR(4),
	CLAIM_CONTROL VARCHAR(1),
	UPDATE_NEEDED VARCHAR(1),
	UPDATE_CONTROL VARCHAR(1),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
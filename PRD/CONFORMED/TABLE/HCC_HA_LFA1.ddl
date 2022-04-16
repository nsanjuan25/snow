create or replace TABLE HCC_HA_LFA1 (
	MANDT VARCHAR(3),
	LIFNR VARCHAR(10),
	LAND1 VARCHAR(3),
	NAME1 VARCHAR(35),
	NAME2 VARCHAR(35),
	NAME3 VARCHAR(35),
	NAME4 VARCHAR(35),
	ORT01 VARCHAR(35),
	ORT02 VARCHAR(35),
	PFACH VARCHAR(10),
	PSTL2 VARCHAR(10),
	PSTLZ VARCHAR(10),
	REGIO VARCHAR(3),
	SORTL VARCHAR(10),
	STRAS VARCHAR(35),
	ADRNR VARCHAR(10),
	MCOD1 VARCHAR(25),
	MCOD2 VARCHAR(25),
	MCOD3 VARCHAR(25),
	ANRED VARCHAR(15),
	BAHNS VARCHAR(25),
	BBBNR VARCHAR(7),
	BBSNR VARCHAR(5),
	BEGRU VARCHAR(4),
	BRSCH VARCHAR(4),
	BUBKZ VARCHAR(1),
	DATLT VARCHAR(14),
	DTAMS VARCHAR(1),
	DTAWS VARCHAR(2),
	ERDAT VARCHAR(8),
	ERNAM VARCHAR(12),
	ESRNR VARCHAR(11),
	KONZS VARCHAR(10),
	KTOKK VARCHAR(4),
	KUNNR VARCHAR(10),
	LNRZA VARCHAR(10),
	LOEVM VARCHAR(1),
	SPERR VARCHAR(1),
	SPERM VARCHAR(1),
	SPRAS VARCHAR(1),
	STCD1 VARCHAR(16),
	STCD2 VARCHAR(11),
	STKZA VARCHAR(1),
	STKZU VARCHAR(1),
	TELBX VARCHAR(15),
	TELF1 VARCHAR(16),
	TELF2 VARCHAR(16),
	TELFX VARCHAR(31),
	TELTX VARCHAR(30),
	TELX1 VARCHAR(30),
	XCPDK VARCHAR(1),
	XZEMP VARCHAR(1),
	VBUND VARCHAR(6),
	FISKN VARCHAR(10),
	STCEG VARCHAR(20),
	STKZN VARCHAR(1),
	SPERQ VARCHAR(2),
	GBORT VARCHAR(25),
	GBDAT VARCHAR(8),
	SEXKZ VARCHAR(1),
	KRAUS VARCHAR(11),
	REVDB VARCHAR(8),
	QSSYS VARCHAR(4),
	KTOCK VARCHAR(4),
	PFORT VARCHAR(35),
	WERKS VARCHAR(4),
	LTSNA VARCHAR(1),
	WERKR VARCHAR(1),
	PLKAL VARCHAR(2),
	DUEFL VARCHAR(1),
	TXJCD VARCHAR(15),
	SPERZ VARCHAR(1),
	SCACD VARCHAR(4),
	SFRGR VARCHAR(4),
	LZONE VARCHAR(10),
	XLFZA VARCHAR(1),
	DLGRP VARCHAR(4),
	FITYP VARCHAR(2),
	STCDT VARCHAR(2),
	REGSS VARCHAR(1),
	ACTSS VARCHAR(3),
	STCD3 VARCHAR(18),
	STCD4 VARCHAR(18),
	STCD5 VARCHAR(60),
	IPISP VARCHAR(1),
	TAXBS VARCHAR(1),
	PROFS VARCHAR(30),
	STGDL VARCHAR(2),
	EMNFR VARCHAR(10),
	LFURL VARCHAR(132),
	J_1KFREPRE VARCHAR(10),
	J_1KFTBUS VARCHAR(30),
	J_1KFTIND VARCHAR(30),
	CONFS VARCHAR(1),
	UPDAT VARCHAR(8),
	UPTIM VARCHAR(6),
	NODEL VARCHAR(1),
	QSSYSDAT VARCHAR(8),
	PODKZB VARCHAR(1),
	FISKU VARCHAR(10),
	STENR VARCHAR(18),
	CARRIER_CONF VARCHAR(1),
	RG VARCHAR(11),
	EXP VARCHAR(3),
	UF VARCHAR(2),
	RGDATE VARCHAR(8),
	RIC VARCHAR(11),
	RNE VARCHAR(10),
	RNEDATE VARCHAR(8),
	CNAE VARCHAR(7),
	LEGALNAT VARCHAR(4),
	CRTN VARCHAR(1),
	ICMSTAXPAY VARCHAR(2),
	INDTYP VARCHAR(2),
	TDT VARCHAR(2),
	COMSIZE VARCHAR(2),
	DECREGPC VARCHAR(2),
	J_SC_CAPITAL NUMBER(38,2),
	J_SC_CURRENCY VARCHAR(5),
	ALC VARCHAR(8),
	PMT_OFFICE VARCHAR(5),
	PSOFG VARCHAR(10),
	PSOIS VARCHAR(20),
	PSON1 VARCHAR(35),
	PSON2 VARCHAR(35),
	PSON3 VARCHAR(35),
	PSOVN VARCHAR(35),
	PSOTL VARCHAR(20),
	PSOHS VARCHAR(6),
	PSOST VARCHAR(28),
	TRANSPORT_CHAIN VARCHAR(10),
	STAGING_TIME NUMBER(38,0),
	SCHEDULING_TYPE VARCHAR(1),
	SUBMI_RELEVANT VARCHAR(1),
	MIN_COMP VARCHAR(1),
	TERM_LI VARCHAR(1),
	CRC_NUM VARCHAR(25),
	CVP_XBLCK VARCHAR(1),
	PPA_RELEVANT VARCHAR(1),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
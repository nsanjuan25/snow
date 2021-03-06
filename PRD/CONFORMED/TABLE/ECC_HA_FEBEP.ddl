create or replace TABLE ECC_HA_FEBEP (
	MANDT VARCHAR(3),
	KUKEY VARCHAR(8),
	ESNUM VARCHAR(5),
	EPERL VARCHAR(1),
	VB1OK VARCHAR(1),
	VB2BA VARCHAR(1),
	VB2OK VARCHAR(1),
	PIPRE VARCHAR(1),
	GRPNR VARCHAR(2),
	ESTAT VARCHAR(4),
	BELNR VARCHAR(10),
	GJAHR VARCHAR(4),
	BVDAT VARCHAR(8),
	BUDAT VARCHAR(8),
	VALUT VARCHAR(8),
	BUTIM VARCHAR(6),
	VOZEI VARCHAR(2),
	KWAER VARCHAR(5),
	KWBTR NUMBER(38,2),
	SPESK NUMBER(38,2),
	FWAER VARCHAR(5),
	FWBTR NUMBER(38,2),
	SPESF NUMBER(38,2),
	VORGC VARCHAR(3),
	TEXTS VARCHAR(4),
	VGEXT VARCHAR(27),
	VGMAN VARCHAR(4),
	VGINT VARCHAR(4),
	VGDEF VARCHAR(1),
	KFMOD VARCHAR(10),
	VGSAP VARCHAR(4),
	BUTXT VARCHAR(50),
	ANZSP VARCHAR(5),
	XBLNR VARCHAR(16),
	ZUONR VARCHAR(18),
	PABKS VARCHAR(3),
	PABLZ VARCHAR(15),
	PASWI VARCHAR(11),
	PAKTO VARCHAR(18),
	PARTN VARCHAR(55),
	BUSAB VARCHAR(2),
	KOSTL VARCHAR(10),
	GSBER VARCHAR(4),
	PRCTR VARCHAR(10),
	VERTN VARCHAR(13),
	VERTT VARCHAR(1),
	PNOTA VARCHAR(10),
	CHECT VARCHAR(13),
	STAVV VARCHAR(2),
	TXTVV VARCHAR(40),
	EPVOZ VARCHAR(1),
	INFO1 VARCHAR(30),
	INFO2 VARCHAR(30),
	AVSID VARCHAR(16),
	INTAG VARCHAR(3),
	NBBLN VARCHAR(10),
	AK1BL VARCHAR(10),
	AKBLN VARCHAR(10),
	KNRZA VARCHAR(10),
	AVKOA VARCHAR(1),
	AVKON VARCHAR(10),
	BATCH VARCHAR(3),
	ITMNR VARCHAR(3),
	KURSF NUMBER(38,5),
	SGTXT VARCHAR(50),
	JPDAT VARCHAR(8),
	POSAG VARCHAR(3),
	SDOC2 VARCHAR(10),
	VGREF VARCHAR(35),
	XBENR VARCHAR(20),
	XBTYP VARCHAR(5),
	ARRSK NUMBER(38,2),
	PFORM VARCHAR(2),
	KIDNO VARCHAR(30),
	KKREF VARCHAR(35),
	KKRF2 VARCHAR(35),
	MANSP VARCHAR(1),
	FNAM1 VARCHAR(132),
	FVAL1 VARCHAR(132),
	FKOA1 VARCHAR(1),
	FNAM2 VARCHAR(132),
	FVAL2 VARCHAR(132),
	FKOA2 VARCHAR(1),
	FNAM3 VARCHAR(132),
	FVAL3 VARCHAR(132),
	FKOA3 VARCHAR(1),
	IDENR VARCHAR(10),
	B1APP VARCHAR(6),
	B1ERR VARCHAR(4),
	B1STD VARCHAR(1),
	B1DOC VARCHAR(70),
	B1TYP VARCHAR(5),
	B2APP VARCHAR(6),
	B2ERR VARCHAR(4),
	B2STD VARCHAR(1),
	B2DOC VARCHAR(70),
	B2TYP VARCHAR(5),
	PIBAN VARCHAR(34),
	N2PCH VARCHAR(1),
	SVBUK VARCHAR(4),
	SVKOA VARCHAR(1),
	SVKON VARCHAR(10),
	SVAVS VARCHAR(16),
	REPRO VARCHAR(1),
	TRNID VARCHAR(35),
	TATYP VARCHAR(4),
	X_FWBTR_CHG VARCHAR(1),
	CURR_RATE NUMBER(38,5),
	XREF1 VARCHAR(12),
	FIPEX VARCHAR(24),
	SEQGEN NUMBER(38,0),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
create or replace TABLE BW_HA_BSIK (
	BUKRS VARCHAR(4),
	LIFNR VARCHAR(10),
	FISCPER VARCHAR(7),
	FISCVAR VARCHAR(2),
	BELNR VARCHAR(10),
	BUZEI VARCHAR(3),
	UPOSZ VARCHAR(4),
	STATUSPS VARCHAR(1),
	KKBER VARCHAR(4),
	MABER VARCHAR(2),
	KOART VARCHAR(1),
	UMSKZ VARCHAR(1),
	BLART VARCHAR(2),
	BSCHL VARCHAR(2),
	BLDAT VARCHAR(8),
	BUDAT VARCHAR(8),
	CPUDT VARCHAR(8),
	AUGDT VARCHAR(8),
	MADAT VARCHAR(8),
	NETDT VARCHAR(8),
	SK1DT VARCHAR(8),
	SK2DT VARCHAR(8),
	ZBD1T NUMBER(38,3),
	ZBD2T NUMBER(38,3),
	ZBD3T NUMBER(38,3),
	ZBD1P NUMBER(38,3),
	ZBD2P NUMBER(38,3),
	ZLSCH VARCHAR(1),
	ZTERM VARCHAR(4),
	ZLSPR VARCHAR(1),
	RSTGR VARCHAR(3),
	ZFBDT VARCHAR(8),
	MANSP VARCHAR(1),
	MSCHL VARCHAR(1),
	DMSOL NUMBER(38,2),
	LCURR VARCHAR(5),
	DMHAB NUMBER(38,2),
	DMSHB NUMBER(38,2),
	SKNTO NUMBER(38,2),
	WRSOL NUMBER(38,2),
	WAERS VARCHAR(5),
	WRHAB NUMBER(38,2),
	WRSHB NUMBER(38,2),
	SKFBT NUMBER(38,2),
	WSKTO NUMBER(38,2),
	MANST VARCHAR(1),
	KTOPL VARCHAR(4),
	HKONT VARCHAR(10),
	SAKNR VARCHAR(10),
	FILKD VARCHAR(10),
	AUGBL VARCHAR(10),
	XBLNR VARCHAR(16),
	REBZG VARCHAR(10),
	REBZZ VARCHAR(3),
	REBZJ VARCHAR(4),
	VBELN VARCHAR(10),
	XREF1 VARCHAR(12),
	XREF2 VARCHAR(12),
	XREF3 VARCHAR(20),
	XARCH VARCHAR(1),
	UPDMOD VARCHAR(1),
	SGTXT VARCHAR(60),
	LAND1 VARCHAR(3),
	UMSKS VARCHAR(1),
	ZUONR VARCHAR(18),
	DMBTR NUMBER(38,2),
	DMBE2 NUMBER(38,2),
	DMBE3 NUMBER(38,2),
	GJAHR VARCHAR(4),
	HWAE2 VARCHAR(5),
	HWAE3 VARCHAR(5),
	SHKZG VARCHAR(1),
	WRBTR NUMBER(38,2),
	REBZT VARCHAR(1),
	GSBER VARCHAR(4),
	ZZDATE VARCHAR(8),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
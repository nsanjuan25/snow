create or replace TABLE JMD_HA_MDTB (
	MANDT VARCHAR(3),
	DTNUM VARCHAR(10),
	DTPOS VARCHAR(6),
	PLAKZ VARCHAR(1),
	PLANR VARCHAR(20),
	DAT00 VARCHAR(8),
	SORT1 VARCHAR(1),
	SORT2 VARCHAR(2),
	DELKZ VARCHAR(2),
	VSTAT VARCHAR(1),
	VRFKZ VARCHAR(1),
	PLUMI VARCHAR(1),
	MNG01 NUMBER(38,3),
	MNG02 NUMBER(38,3),
	MNG03 NUMBER(38,3),
	DAT01 VARCHAR(8),
	DAT02 VARCHAR(8),
	DAT03 VARCHAR(8),
	PERKZ VARCHAR(1),
	PRPER VARCHAR(6),
	WEBAZ NUMBER(38,0),
	FIX01 VARCHAR(1),
	FIX02 VARCHAR(1),
	BAART VARCHAR(4),
	BESKZ VARCHAR(1),
	SOBES VARCHAR(1),
	UMSKZ VARCHAR(1),
	PLART VARCHAR(1),
	AUSSL VARCHAR(2),
	WRK02 VARCHAR(4),
	LGORT VARCHAR(4),
	DELNR VARCHAR(10),
	DELPS VARCHAR(6),
	DELET VARCHAR(4),
	AUFVR VARCHAR(10),
	POSVR VARCHAR(6),
	EINVR VARCHAR(4),
	UKZ01 VARCHAR(1),
	UMDAT VARCHAR(8),
	DEL12 VARCHAR(12),
	BAUGR VARCHAR(18),
	DELVR VARCHAR(2),
	VERSB VARCHAR(2),
	OLDSL VARCHAR(2),
	RDMNG NUMBER(38,3),
	PLAAB VARCHAR(2),
	TAG00 VARCHAR(2),
	ABEKZ VARCHAR(1),
	MDFST VARCHAR(1),
	MDMNG NUMBER(38,3),
	VERID VARCHAR(4),
	WRK01 VARCHAR(4),
	SERNR VARCHAR(8),
	REVLV VARCHAR(2),
	DBSKZ VARCHAR(1),
	EXTNL VARCHAR(1),
	ADINF VARCHAR(4),
	RESLO VARCHAR(4),
	PRIO_URG VARCHAR(2),
	PRIO_REQ VARCHAR(3),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
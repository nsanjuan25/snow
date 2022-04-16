create or replace TABLE JPS_HA_EDP13 (
	MANDT VARCHAR(3),
	RCVPRN VARCHAR(10),
	RCVPRT VARCHAR(2),
	RCVPFC VARCHAR(2),
	MESTYP VARCHAR(30),
	MESCOD VARCHAR(3),
	MESFCT VARCHAR(3),
	TEST VARCHAR(1),
	METHOD VARCHAR(1),
	DOCTYP VARCHAR(8),
	SYNCHK VARCHAR(1),
	USRTYP VARCHAR(10),
	USRKEY VARCHAR(70),
	USRLNG VARCHAR(1),
	ALEADR VARCHAR(10),
	ALESCA VARCHAR(3),
	OUTMOD VARCHAR(1),
	RCVPOR VARCHAR(10),
	IDOCTYP VARCHAR(30),
	CIMTYP VARCHAR(30),
	STD VARCHAR(1),
	STDVRS VARCHAR(6),
	STDMES VARCHAR(6),
	PCKSIZ VARCHAR(4),
	IDOCVRS VARCHAR(6),
	SEGREL VARCHAR(4),
	EDIVIEW VARCHAR(30),
	SEGAPPLREL VARCHAR(10),
	QURULE VARCHAR(30),
	SYNNORUN VARCHAR(1),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
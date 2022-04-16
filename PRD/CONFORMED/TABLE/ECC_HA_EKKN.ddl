create or replace TABLE ECC_HA_EKKN (
	MANDT VARCHAR(3),
	EBELN VARCHAR(10),
	EBELP VARCHAR(5),
	ZEKKN VARCHAR(2),
	LOEKZ VARCHAR(1),
	AEDAT VARCHAR(8),
	KFLAG VARCHAR(1),
	MENGE NUMBER(38,3),
	VPROZ NUMBER(38,1),
	NETWR NUMBER(38,2),
	SAKTO VARCHAR(10),
	GSBER VARCHAR(4),
	KOSTL VARCHAR(10),
	PROJN VARCHAR(16),
	VBELN VARCHAR(10),
	VBELP VARCHAR(6),
	VETEN VARCHAR(4),
	KZBRB VARCHAR(1),
	ANLN1 VARCHAR(12),
	ANLN2 VARCHAR(4),
	AUFNR VARCHAR(12),
	WEMPF VARCHAR(12),
	ABLAD VARCHAR(25),
	KOKRS VARCHAR(4),
	XBKST VARCHAR(1),
	XBAUF VARCHAR(1),
	XBPRO VARCHAR(1),
	EREKZ VARCHAR(1),
	KSTRG VARCHAR(12),
	PAOBJNR VARCHAR(10),
	PRCTR VARCHAR(10),
	PS_PSP_PNR VARCHAR(8),
	NPLNR VARCHAR(12),
	AUFPL VARCHAR(10),
	IMKEY VARCHAR(8),
	APLZL VARCHAR(8),
	VPTNR VARCHAR(10),
	FIPOS VARCHAR(14),
	RECID VARCHAR(2),
	FISTL VARCHAR(16),
	GEBER VARCHAR(10),
	FKBER VARCHAR(16),
	DABRZ VARCHAR(8),
	AUFPL_ORD VARCHAR(10),
	APLZL_ORD VARCHAR(8),
	MWSKZ VARCHAR(2),
	TXJCD VARCHAR(15),
	NAVNW NUMBER(38,2),
	KBLNR VARCHAR(10),
	KBLPOS VARCHAR(3),
	LSTAR VARCHAR(6),
	PRZNR VARCHAR(12),
	GRANT_NBR VARCHAR(20),
	BUDGET_PD VARCHAR(10),
	FM_SPLIT_BATCH VARCHAR(3),
	FM_SPLIT_BEGRU VARCHAR(4),
	AA_FINAL_IND VARCHAR(1),
	AA_FINAL_REASON VARCHAR(2),
	AA_FINAL_QTY NUMBER(38,3),
	AA_FINAL_QTY_F FLOAT,
	MENGE_F FLOAT,
	EGRUP VARCHAR(3),
	VNAME VARCHAR(6),
	TCOBJNR VARCHAR(22),
	DATEOFSERVICE VARCHAR(8),
	NOTAXCORR VARCHAR(1),
	DIFFOPTRATE NUMBER(38,6),
	HASDIFFOPTRATE VARCHAR(1),
	FMFGUS_KEY VARCHAR(22),
	SEQGEN NUMBER(38,0),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
create or replace TABLE HCC_HA_VBAK (
	MANDT VARCHAR(3),
	VBELN VARCHAR(10),
	ERDAT VARCHAR(8),
	ERZET VARCHAR(6),
	ERNAM VARCHAR(12),
	ANGDT VARCHAR(8),
	BNDDT VARCHAR(8),
	AUDAT VARCHAR(8),
	VBTYP VARCHAR(1),
	TRVOG VARCHAR(1),
	AUART VARCHAR(4),
	AUGRU VARCHAR(3),
	GWLDT VARCHAR(8),
	SUBMI VARCHAR(10),
	LIFSK VARCHAR(2),
	FAKSK VARCHAR(2),
	NETWR NUMBER(38,2),
	WAERK VARCHAR(5),
	VKORG VARCHAR(4),
	VTWEG VARCHAR(2),
	SPART VARCHAR(2),
	VKGRP VARCHAR(3),
	VKBUR VARCHAR(4),
	GSBER VARCHAR(4),
	GSKST VARCHAR(4),
	GUEBG VARCHAR(8),
	GUEEN VARCHAR(8),
	KNUMV VARCHAR(10),
	VDATU VARCHAR(8),
	VPRGR VARCHAR(1),
	AUTLF VARCHAR(1),
	VBKLA VARCHAR(9),
	VBKLT VARCHAR(1),
	KALSM VARCHAR(6),
	VSBED VARCHAR(2),
	FKARA VARCHAR(4),
	AWAHR VARCHAR(3),
	KTEXT VARCHAR(40),
	BSTNK VARCHAR(20),
	BSARK VARCHAR(4),
	BSTDK VARCHAR(8),
	BSTZD VARCHAR(4),
	IHREZ VARCHAR(12),
	BNAME VARCHAR(35),
	TELF1 VARCHAR(16),
	MAHZA NUMBER(38,0),
	MAHDT VARCHAR(8),
	KUNNR VARCHAR(10),
	KOSTL VARCHAR(10),
	STAFO VARCHAR(6),
	STWAE VARCHAR(5),
	AEDAT VARCHAR(8),
	KVGR1 VARCHAR(3),
	KVGR2 VARCHAR(3),
	KVGR3 VARCHAR(3),
	KVGR4 VARCHAR(3),
	KVGR5 VARCHAR(3),
	KNUMA VARCHAR(10),
	KOKRS VARCHAR(4),
	PS_PSP_PNR VARCHAR(8),
	KURST VARCHAR(4),
	KKBER VARCHAR(4),
	KNKLI VARCHAR(10),
	GRUPP VARCHAR(4),
	SBGRP VARCHAR(3),
	CTLPC VARCHAR(3),
	CMWAE VARCHAR(5),
	CMFRE VARCHAR(8),
	CMNUP VARCHAR(8),
	CMNGV VARCHAR(8),
	AMTBL NUMBER(38,2),
	HITYP_PR VARCHAR(1),
	ABRVW VARCHAR(3),
	ABDIS VARCHAR(1),
	VGBEL VARCHAR(10),
	OBJNR VARCHAR(22),
	BUKRS_VF VARCHAR(4),
	TAXK1 VARCHAR(1),
	TAXK2 VARCHAR(1),
	TAXK3 VARCHAR(1),
	TAXK4 VARCHAR(1),
	TAXK5 VARCHAR(1),
	TAXK6 VARCHAR(1),
	TAXK7 VARCHAR(1),
	TAXK8 VARCHAR(1),
	TAXK9 VARCHAR(1),
	XBLNR VARCHAR(16),
	ZUONR VARCHAR(18),
	VGTYP VARCHAR(1),
	KALSM_CH VARCHAR(6),
	AGRZR VARCHAR(2),
	AUFNR VARCHAR(12),
	QMNUM VARCHAR(12),
	VBELN_GRP VARCHAR(10),
	SCHEME_GRP VARCHAR(4),
	ABRUF_PART VARCHAR(1),
	ABHOD VARCHAR(8),
	ABHOV VARCHAR(6),
	ABHOB VARCHAR(6),
	RPLNR VARCHAR(10),
	VZEIT VARCHAR(6),
	STCEG_L VARCHAR(3),
	LANDTX VARCHAR(3),
	XEGDR VARCHAR(1),
	ENQUEUE_GRP VARCHAR(1),
	DAT_FZAU VARCHAR(8),
	FMBDAT VARCHAR(8),
	VSNMR_V VARCHAR(12),
	HANDLE VARCHAR(22),
	PROLI VARCHAR(3),
	CONT_DG VARCHAR(1),
	CRM_GUID VARCHAR(70),
	UPD_TMSTMP NUMBER(38,7),
	MSR_ID VARCHAR(10),
	TM_CTRL_KEY VARCHAR(4),
	HANDOVERLOC VARCHAR(10),
	PSM_BUDAT VARCHAR(8),
	SWENR VARCHAR(8),
	SMENR VARCHAR(8),
	PHASE VARCHAR(11),
	MTLAUR VARCHAR(1),
	STAGE NUMBER(38,0),
	HB_CONT_REASON VARCHAR(2),
	HB_EXPDATE VARCHAR(8),
	HB_RESDATE VARCHAR(8),
	MILL_APPL_ID VARCHAR(2),
	TAS VARCHAR(30),
	BETC VARCHAR(10),
	MOD_ALLOW VARCHAR(1),
	CANCEL_ALLOW VARCHAR(1),
	PAY_METHOD VARCHAR(10),
	BPN VARCHAR(6),
	REP_FREQ VARCHAR(3),
	LOGSYSB VARCHAR(10),
	KALCD VARCHAR(6),
	MULTI VARCHAR(1),
	SPPAYM VARCHAR(2),
	WTYSC_CLM_HDR VARCHAR(16),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
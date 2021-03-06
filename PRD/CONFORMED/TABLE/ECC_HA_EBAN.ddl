create or replace TABLE ECC_HA_EBAN (
	MANDT VARCHAR(3),
	BANFN VARCHAR(10),
	BNFPO VARCHAR(5),
	BSART VARCHAR(4),
	BSTYP VARCHAR(1),
	BSAKZ VARCHAR(1),
	LOEKZ VARCHAR(1),
	STATU VARCHAR(1),
	ESTKZ VARCHAR(1),
	FRGKZ VARCHAR(1),
	FRGZU VARCHAR(8),
	FRGST VARCHAR(2),
	EKGRP VARCHAR(3),
	ERNAM VARCHAR(12),
	ERDAT VARCHAR(8),
	AFNAM VARCHAR(12),
	TXZ01 VARCHAR(40),
	MATNR VARCHAR(18),
	EMATN VARCHAR(18),
	WERKS VARCHAR(4),
	LGORT VARCHAR(4),
	BEDNR VARCHAR(10),
	MATKL VARCHAR(9),
	RESWK VARCHAR(4),
	MENGE NUMBER(38,3),
	MEINS VARCHAR(3),
	BUMNG NUMBER(38,3),
	BADAT VARCHAR(8),
	LPEIN VARCHAR(1),
	LFDAT VARCHAR(8),
	FRGDT VARCHAR(8),
	WEBAZ NUMBER(38,0),
	PREIS NUMBER(38,2),
	PEINH NUMBER(38,0),
	PSTYP VARCHAR(1),
	KNTTP VARCHAR(1),
	KZVBR VARCHAR(1),
	KFLAG VARCHAR(1),
	VRTKZ VARCHAR(1),
	TWRKZ VARCHAR(1),
	WEPOS VARCHAR(1),
	WEUNB VARCHAR(1),
	REPOS VARCHAR(1),
	LIFNR VARCHAR(10),
	FLIEF VARCHAR(10),
	EKORG VARCHAR(4),
	VRTYP VARCHAR(1),
	KONNR VARCHAR(10),
	KTPNR VARCHAR(5),
	INFNR VARCHAR(10),
	ZUGBA VARCHAR(1),
	QUNUM VARCHAR(10),
	QUPOS VARCHAR(3),
	DISPO VARCHAR(3),
	SERNR VARCHAR(8),
	BVDAT VARCHAR(8),
	BATOL NUMBER(38,0),
	BVDRK NUMBER(38,0),
	EBELN VARCHAR(10),
	EBELP VARCHAR(5),
	BEDAT VARCHAR(8),
	BSMNG NUMBER(38,3),
	LBLNI VARCHAR(10),
	BWTAR VARCHAR(10),
	XOBLR VARCHAR(1),
	EBAKZ VARCHAR(1),
	RSNUM VARCHAR(10),
	SOBKZ VARCHAR(1),
	ARSNR VARCHAR(10),
	ARSPS VARCHAR(4),
	FIXKZ VARCHAR(1),
	BMEIN VARCHAR(3),
	REVLV VARCHAR(2),
	VORAB VARCHAR(1),
	PACKNO VARCHAR(10),
	KANBA VARCHAR(1),
	BPUEB VARCHAR(1),
	CUOBJ VARCHAR(18),
	FRGGR VARCHAR(2),
	FRGRL VARCHAR(1),
	AKTNR VARCHAR(10),
	CHARG VARCHAR(10),
	UMSOK VARCHAR(1),
	VERID VARCHAR(4),
	FIPOS VARCHAR(14),
	FISTL VARCHAR(16),
	GEBER VARCHAR(10),
	KZKFG VARCHAR(1),
	SATNR VARCHAR(18),
	MNG02 NUMBER(38,3),
	DAT01 VARCHAR(8),
	ATTYP VARCHAR(2),
	ADRNR VARCHAR(10),
	ADRN2 VARCHAR(10),
	KUNNR VARCHAR(10),
	EMLIF VARCHAR(10),
	LBLKZ VARCHAR(1),
	KZBWS VARCHAR(1),
	WAERS VARCHAR(5),
	IDNLF VARCHAR(35),
	GSFRG VARCHAR(1),
	MPROF VARCHAR(4),
	KZFME VARCHAR(1),
	SPRAS VARCHAR(1),
	TECHS VARCHAR(12),
	MFRPN VARCHAR(40),
	MFRNR VARCHAR(10),
	EMNFR VARCHAR(10),
	FORDN VARCHAR(10),
	FORDP VARCHAR(5),
	PLIFZ NUMBER(38,0),
	BERID VARCHAR(10),
	UZEIT VARCHAR(6),
	FKBER VARCHAR(16),
	GRANT_NBR VARCHAR(20),
	MEMORY VARCHAR(1),
	BANPR VARCHAR(2),
	RLWRT NUMBER(38,2),
	BLCKD VARCHAR(1),
	REVNO VARCHAR(8),
	BLCKT VARCHAR(60),
	BESWK VARCHAR(4),
	EPROFILE VARCHAR(2),
	EPREFDOC VARCHAR(10),
	EPREFITM VARCHAR(5),
	GMMNG NUMBER(38,3),
	WRTKZ VARCHAR(1),
	RESLO VARCHAR(4),
	KBLNR VARCHAR(10),
	KBLPOS VARCHAR(3),
	PRIO_URG VARCHAR(2),
	PRIO_REQ VARCHAR(3),
	MEMORYTYPE VARCHAR(1),
	ANZSN NUMBER(38,0),
	MHDRZ NUMBER(38,0),
	IPRKZ VARCHAR(1),
	NODISP VARCHAR(1),
	SRM_CONTRACT_ID VARCHAR(10),
	SRM_CONTRACT_ITM VARCHAR(10),
	BUDGET_PD VARCHAR(10),
	STORENETWORKID VARCHAR(128),
	STORESUPPLIERID VARCHAR(64),
	FMFGUS_KEY VARCHAR(22),
	ADVCODE VARCHAR(2),
	STACODE VARCHAR(2),
	BANFN_CS VARCHAR(10),
	BNFPO_CS VARCHAR(5),
	ITEM_CS VARCHAR(1),
	BSMNG_SND NUMBER(38,3),
	NO_MARD_DATA VARCHAR(1),
	SERRU VARCHAR(1),
	DISUB_SOBKZ VARCHAR(1),
	DISUB_PSPNR VARCHAR(8),
	DISUB_KUNNR VARCHAR(10),
	DISUB_VBELN VARCHAR(10),
	DISUB_POSNR VARCHAR(6),
	DISUB_OWNER VARCHAR(10),
	IUID_RELEVANT VARCHAR(1),
	SGT_SCAT VARCHAR(16),
	SGT_RCAT VARCHAR(16),
	WRF_CHARSTC1 VARCHAR(18),
	WRF_CHARSTC2 VARCHAR(18),
	WRF_CHARSTC3 VARCHAR(18),
	SEQGEN NUMBER(38,0),
	ZZDATE VARCHAR(8),
	ZZTIME VARCHAR(6),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
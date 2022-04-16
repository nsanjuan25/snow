create or replace TABLE PLA_HA_RESB (
	MANDT VARCHAR(3),
	RSNUM VARCHAR(10),
	RSPOS VARCHAR(4),
	RSART VARCHAR(1),
	BDART VARCHAR(2),
	RSSTA VARCHAR(1),
	XLOEK VARCHAR(1),
	XWAOK VARCHAR(1),
	KZEAR VARCHAR(1),
	XFEHL VARCHAR(1),
	MATNR VARCHAR(18),
	WERKS VARCHAR(4),
	LGORT VARCHAR(4),
	PRVBE VARCHAR(10),
	CHARG VARCHAR(10),
	PLPLA VARCHAR(10),
	SOBKZ VARCHAR(1),
	BDTER VARCHAR(8),
	BDMNG NUMBER(38,3),
	MEINS VARCHAR(3),
	SHKZG VARCHAR(1),
	FMENG VARCHAR(1),
	ENMNG NUMBER(38,3),
	ENWRT NUMBER(38,2),
	WAERS VARCHAR(5),
	ERFMG NUMBER(38,3),
	ERFME VARCHAR(3),
	PLNUM VARCHAR(10),
	BANFN VARCHAR(10),
	BNFPO VARCHAR(5),
	AUFNR VARCHAR(12),
	BAUGR VARCHAR(18),
	SERNR VARCHAR(8),
	KDAUF VARCHAR(10),
	KDPOS VARCHAR(6),
	KDEIN VARCHAR(4),
	PROJN VARCHAR(16),
	BWART VARCHAR(3),
	SAKNR VARCHAR(10),
	GSBER VARCHAR(4),
	UMWRK VARCHAR(4),
	UMLGO VARCHAR(4),
	NAFKZ VARCHAR(1),
	NOMAT VARCHAR(18),
	NOMNG NUMBER(38,3),
	POSTP VARCHAR(1),
	POSNR VARCHAR(4),
	ROMS1 NUMBER(38,3),
	ROMS2 NUMBER(38,3),
	ROMS3 NUMBER(38,3),
	ROMEI VARCHAR(3),
	ROMEN NUMBER(38,3),
	SGTXT VARCHAR(50),
	LMENG NUMBER(38,3),
	ROHPS VARCHAR(1),
	RFORM VARCHAR(2),
	ROANZ NUMBER(38,3),
	FLMNG NUMBER(38,3),
	STLTY VARCHAR(1),
	STLNR VARCHAR(8),
	STLKN VARCHAR(8),
	STPOZ VARCHAR(8),
	LTXSP VARCHAR(1),
	POTX1 VARCHAR(40),
	POTX2 VARCHAR(40),
	SANKA VARCHAR(1),
	ALPOS VARCHAR(1),
	EWAHR NUMBER(38,0),
	AUSCH NUMBER(38,2),
	AVOAU NUMBER(38,2),
	NETAU VARCHAR(1),
	NLFZT NUMBER(38,0),
	AENNR VARCHAR(12),
	UMREZ NUMBER(38,0),
	UMREN NUMBER(38,0),
	SORTF VARCHAR(10),
	SBTER VARCHAR(8),
	VERTI VARCHAR(4),
	SCHGT VARCHAR(1),
	UPSKZ VARCHAR(1),
	DBSKZ VARCHAR(1),
	TXTPS VARCHAR(1),
	DUMPS VARCHAR(1),
	BEIKZ VARCHAR(1),
	ERSKZ VARCHAR(1),
	AUFST VARCHAR(2),
	AUFWG VARCHAR(2),
	BAUST VARCHAR(2),
	BAUWG VARCHAR(2),
	AUFPS VARCHAR(2),
	EBELN VARCHAR(10),
	EBELP VARCHAR(5),
	EBELE VARCHAR(4),
	KNTTP VARCHAR(1),
	KZVBR VARCHAR(1),
	PSPEL VARCHAR(8),
	AUFPL VARCHAR(10),
	PLNFL VARCHAR(6),
	VORNR VARCHAR(4),
	APLZL VARCHAR(8),
	OBJNR VARCHAR(22),
	FLGAT VARCHAR(1),
	GPREIS NUMBER(38,2),
	FPREIS NUMBER(38,2),
	PEINH NUMBER(38,0),
	RGEKZ VARCHAR(1),
	EKGRP VARCHAR(3),
	ROKME VARCHAR(3),
	ZUMEI VARCHAR(3),
	ZUMS1 NUMBER(38,3),
	ZUMS2 NUMBER(38,3),
	ZUMS3 NUMBER(38,3),
	ZUDIV VARCHAR(5),
	VMENG NUMBER(38,3),
	PRREG VARCHAR(2),
	LIFZT NUMBER(38,0),
	CUOBJ VARCHAR(18),
	KFPOS VARCHAR(1),
	REVLV VARCHAR(2),
	BERKZ VARCHAR(1),
	LGNUM VARCHAR(3),
	LGTYP VARCHAR(3),
	LGPLA VARCHAR(10),
	TBMNG NUMBER(38,3),
	NPTXTKY VARCHAR(12),
	KBNKZ VARCHAR(1),
	KZKUP VARCHAR(1),
	AFPOS VARCHAR(4),
	NO_DISP VARCHAR(1),
	BDZTP VARCHAR(6),
	ESMNG FLOAT,
	ALPGR VARCHAR(2),
	ALPRF VARCHAR(2),
	ALPST VARCHAR(1),
	KZAUS VARCHAR(1),
	NFEAG VARCHAR(2),
	NFPKZ VARCHAR(1),
	NFGRP VARCHAR(2),
	NFUML NUMBER(38,4),
	ADRNR VARCHAR(10),
	CHOBJ VARCHAR(18),
	SPLKZ VARCHAR(1),
	SPLRV VARCHAR(4),
	KNUMH VARCHAR(10),
	WEMPF VARCHAR(12),
	ABLAD VARCHAR(25),
	HKMAT VARCHAR(1),
	HRKFT VARCHAR(4),
	VORAB VARCHAR(1),
	MATKL VARCHAR(9),
	FRUNV VARCHAR(1),
	CLAKZ VARCHAR(1),
	INPOS VARCHAR(1),
	WEBAZ NUMBER(38,0),
	LIFNR VARCHAR(10),
	FLGEX VARCHAR(1),
	FUNCT VARCHAR(3),
	GPREIS_2 NUMBER(38,2),
	FPREIS_2 NUMBER(38,2),
	PEINH_2 NUMBER(38,0),
	INFNR VARCHAR(10),
	KZECH VARCHAR(1),
	KZMPF VARCHAR(1),
	STLAL VARCHAR(2),
	PBDNR VARCHAR(10),
	STVKN VARCHAR(8),
	KTOMA VARCHAR(1),
	VRPLA VARCHAR(1),
	KZBWS VARCHAR(1),
	NLFZV NUMBER(38,0),
	NLFMV VARCHAR(3),
	TECHS VARCHAR(12),
	OBJTYPE VARCHAR(1),
	CH_PROC VARCHAR(1),
	FXPRU VARCHAR(1),
	UMSOK VARCHAR(1),
	VORAB_SM VARCHAR(1),
	FIPOS VARCHAR(14),
	FIPEX VARCHAR(24),
	FISTL VARCHAR(16),
	GEBER VARCHAR(10),
	GRANT_NBR VARCHAR(20),
	FKBER VARCHAR(16),
	PRIO_URG VARCHAR(2),
	PRIO_REQ VARCHAR(3),
	ADVCODE VARCHAR(2),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
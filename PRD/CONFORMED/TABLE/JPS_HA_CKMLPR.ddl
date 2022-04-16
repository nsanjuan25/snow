create or replace TABLE JPS_HA_CKMLPR (
	MANDT VARCHAR(3),
	KALNR VARCHAR(12),
	CURTP VARCHAR(2),
	PEINH NUMBER(38,0),
	ZPRSDAT VARCHAR(8),
	ZKPRS NUMBER(38,2),
	KALKZ VARCHAR(1),
	PPRDZ VARCHAR(3),
	PDATZ VARCHAR(4),
	BWVA1 VARCHAR(3),
	VERS1 VARCHAR(2),
	ZPLPR NUMBER(38,2),
	FPLPX NUMBER(38,2),
	ZBWST VARCHAR(1),
	KALKL VARCHAR(1),
	PPRDL VARCHAR(3),
	PDATL VARCHAR(4),
	BWVA2 VARCHAR(3),
	VERS2 VARCHAR(2),
	LPLPR NUMBER(38,2),
	LPLPX NUMBER(38,2),
	LBWST VARCHAR(1),
	KALKV VARCHAR(1),
	PPRDV VARCHAR(3),
	PDATV VARCHAR(4),
	BWVA3 VARCHAR(3),
	VERS3 VARCHAR(2),
	VPLPR NUMBER(38,2),
	VPLPX NUMBER(38,2),
	CBWST VARCHAR(1),
	SET_BY_MARKING VARCHAR(1),
	EIBDATJ VARCHAR(4),
	EIPOPER VARCHAR(3),
	EIPRICE NUMBER(38,2),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
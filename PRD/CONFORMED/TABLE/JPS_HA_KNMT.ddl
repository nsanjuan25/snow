create or replace TABLE JPS_HA_KNMT (
	MANDT VARCHAR(3),
	VKORG VARCHAR(4),
	VTWEG VARCHAR(2),
	KUNNR VARCHAR(10),
	MATNR VARCHAR(40),
	ERNAM VARCHAR(12),
	ERDAT VARCHAR(8),
	SORTL VARCHAR(10),
	KDMAT VARCHAR(35),
	POSTX VARCHAR(40),
	LPRIO VARCHAR(2),
	MINLF NUMBER(38,3),
	MEINS VARCHAR(3),
	CHSPL VARCHAR(1),
	KZTLF VARCHAR(1),
	ANTLF NUMBER(38,0),
	UNTTO NUMBER(38,1),
	UEBTO NUMBER(38,1),
	UEBTK VARCHAR(1),
	WERKS VARCHAR(4),
	RDPRF VARCHAR(4),
	MEGRU VARCHAR(4),
	J_1BTXSDC VARCHAR(2),
	VWPOS VARCHAR(4),
	VRKME_T VARCHAR(3),
	UMVKN_T NUMBER(38,0),
	UMVKZ_T NUMBER(38,0),
	DUMMY_SLSCUSMAT_INCL_EEW_PS VARCHAR(1),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
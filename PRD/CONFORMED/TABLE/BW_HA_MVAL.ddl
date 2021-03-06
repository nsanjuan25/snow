create or replace TABLE BW_HA_MVAL (
	MATERIAL VARCHAR(18),
	ID_VALAREA VARCHAR(4),
	VAL_TYPE VARCHAR(10),
	PRICE_AVG NUMBER(38,2),
	PRICE_MAT NUMBER(38,2),
	COMP_CODE VARCHAR(4),
	PLANT VARCHAR(4),
	MAT_PLANT VARCHAR(18),
	VAL_CLASS VARCHAR(4),
	BICZK_FPP0 NUMBER(38,2),
	BICZK_FPP1 NUMBER(38,2),
	BICZK_FPP2 NUMBER(38,2),
	BICZK_FPP3 NUMBER(38,2),
	BASE_UOM VARCHAR(3),
	BICZ_FP1DAT VARCHAR(8),
	BICZ_FP2DAT VARCHAR(8),
	CURRENCY VARCHAR(5),
	BICZ_FP3DAT VARCHAR(8),
	RECORDMODE VARCHAR(1),
	DEL_FLAG VARCHAR(1),
	BICZPRC_UNIT NUMBER(38,3),
	BICZK_TPSTK NUMBER(38,3),
	BICZK_VTTSTK NUMBER(38,2),
	BICZK_LPLPR NUMBER(38,2),
	BICZK_VMVER NUMBER(38,2),
	TOT_STKQTY NUMBER(38,3),
	BICZK_ZKPRS NUMBER(38,2),
	BICZ_ZKDAT VARCHAR(8),
	BICZPRUNBUOM NUMBER(38,3),
	BICZ_VPRSV VARCHAR(1),
	BICZK_SALK3 NUMBER(38,2),
	BICZK_SALKV NUMBER(38,2),
	BICZ_LAEPR VARCHAR(8),
	BICZ_PPRDL VARCHAR(3),
	BICZ_PDATL VARCHAR(4),
	BICZ_MLMAA VARCHAR(1),
	BICZ_KALN1 VARCHAR(12),
	BICZ_LFGJA VARCHAR(4),
	BICZ_LFMON VARCHAR(2),
	BICZ_VMPEI NUMBER(38,3),
	BICZ_VMVPR VARCHAR(1),
	BICZ_VMSTP NUMBER(38,2),
	BICZ_PP1_10 NUMBER(38,2),
	BICZ_PP1_30 NUMBER(38,2),
	BICZ_PP1_40 NUMBER(38,2),
	BICZ_PP2_10 NUMBER(38,2),
	BICZ_PP2_30 NUMBER(38,2),
	BICZ_PP2_40 NUMBER(38,2),
	BICZ_PP3_10 NUMBER(38,2),
	BICZ_PP3_30 NUMBER(38,2),
	BICZ_PP3_40 NUMBER(38,2),
	BICZ_MVP_10 NUMBER(38,2),
	BICZ_MVP_30 NUMBER(38,2),
	BICZ_MVP_40 NUMBER(38,2),
	BICZ_STD_10 NUMBER(38,2),
	BICZ_STD_30 NUMBER(38,2),
	BICZ_STD_40 NUMBER(38,2),
	BICZSCENARIO VARCHAR(1),
	BICZPRSD10 VARCHAR(8),
	BICZPRSD30 VARCHAR(8),
	BICZPRSD40 VARCHAR(8),
	ZPEINH_10 NUMBER(38,3),
	ZPEINH_30 NUMBER(38,3),
	ZPEINH_40 NUMBER(38,3),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
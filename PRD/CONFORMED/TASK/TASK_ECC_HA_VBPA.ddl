create or replace task TASK_ECC_HA_VBPA
	warehouse=WH_TASKS
	schedule='500 MINUTE'
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_ecc_ha_vbpa')
	as call Conformed.SAP_DimSalesDocPartner_Add ('ecc_ha_vbpa');
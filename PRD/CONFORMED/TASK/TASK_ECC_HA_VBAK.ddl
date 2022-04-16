create or replace task TASK_ECC_HA_VBAK
	warehouse=WH_TASKS
	schedule='500 MINUTE'
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_ecc_ha_vbak')
	as call Conformed.SAP_FactSales_Add ('ecc_ha_vbak');
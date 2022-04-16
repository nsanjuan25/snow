create or replace task TASK_ECC_HA_LIKP
	warehouse=WH_TASKS
	schedule='500 MINUTE'
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_ecc_ha_likp')
	as call Conformed.SAP_FactDeliveries_Add ('ecc_ha_likp');
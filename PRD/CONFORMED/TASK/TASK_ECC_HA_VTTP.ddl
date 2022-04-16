create or replace task TASK_ECC_HA_VTTP
	warehouse=WH_TASKS
	schedule='500 MINUTE'
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_ecc_ha_vttp')
	as call Conformed.SAP_FactShipments_Add ('ecc_ha_vttp');
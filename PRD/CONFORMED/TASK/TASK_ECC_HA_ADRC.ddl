create or replace task TASK_ECC_HA_ADRC
	warehouse=WH_TASKS
	schedule='500 MINUTE'
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_ecc_ha_adrc')
	as call Conformed.SAP_DimAddresses_Add ('ecc_ha_adrc');
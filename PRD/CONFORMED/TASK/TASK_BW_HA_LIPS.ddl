create or replace task TASK_BW_HA_LIPS
	warehouse=WH_TASKS
	schedule='500 MINUTE'
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_bw_ha_lips')
	as call Conformed.SAP_FactDeliveries_Add ('bw_ha_lips');
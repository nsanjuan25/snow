create or replace view V_FACTINVENTORY(
	DATASOURCEKEY,
	PLANTKEY,
	MATERIALKEY,
	INVENTORYTYPEKEY,
	SUPPLIERKEY,
	LOCATIONKEY,
	STOCKDATEKEY,
	BATCHNUMBER,
	SERIALNUMBER,
	SPECIALSTOCKSKEY,
	NETTABLEFLAG,
	QUANTITY,
	UNITOFMEASURECODE,
	SNAPSHOTDATEKEY,
	MRPINDICATOR,
	STOCKTYPEKEY
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into v_FactInventory
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-04-14     SRIDHAR                 Initial Revision     
*/
select * from conformed.v_ECC_FactInventory
union all
select * from conformed.v_HCC_FactInventory;
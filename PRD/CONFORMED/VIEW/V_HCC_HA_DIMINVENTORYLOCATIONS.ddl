create or replace view V_HCC_HA_DIMINVENTORYLOCATIONS(
	CLIENT,
	SITECODE,
	LOCATION,
	LOCATIONNAME,
	DIVISION,
	NEGATIVESTOCKSOK,
	FREEZINGBLOCKINV,
	MRPFLAG,
	GOODSMOVEMENTACTIVE,
	ALLOCATEDTORESOURCE,
	HANDLINGUNITREQT,
	PARTNERLOCATION,
	SALESORGANIZATION,
	DISTRIBUTIONCHANNEL,
	SHIPPINGPOINT,
	VENDORACCOUNT,
	CUSTOMERACCOUNT,
	UPDATED_ON
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to do the old tranformation spend_analytics.inventorylocation
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-04      Carlos Carrillo         Initial Revision
  */
SELECT t001l.mandt AS client,
       t001l.werks AS sitecode,
       t001l.lgort AS location,
       t001l.lgobe AS locationname,
       t001l.spart AS division,
       t001l.xlong AS negativestocksok,
       t001l.xbufx AS freezingblockinv,
       t001l.diskz AS mrpflag,
       t001l.xblgo AS goodsmovementactive,
       t001l.xress AS allocatedtoresource,
       t001l.xhupf AS handlingunitreqt,
       t001l.parlg AS partnerlocation,
       t001l.vkorg AS salesorganization,
       t001l.vtweg AS distributionchannel,
       t001l.vstel AS shippingpoint,
       t001l.lifnr AS vendoraccount,
       t001l.kunnr AS customeraccount,
       CURRENT_TIMESTAMP AS updated_on
FROM conformed.hcc_ha_t001l t001l;
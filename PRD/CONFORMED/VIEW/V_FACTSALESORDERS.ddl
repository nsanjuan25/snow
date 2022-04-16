create or replace view V_FACTSALESORDERS(
	DATASOURCEKEY,
	CUSTOMERKEY,
	EFFECTIVEFROMDATEKEY,
	EFFECTIVETODATEKEY,
	REQUESTDELIVERYDATEKEY,
	RECEIPTDATEKEY,
	PLANTKEY,
	MATERIALKEY,
	SALESDOCUMENTTYPEKEY,
	SALESDOCUMENTCATEGORYKEY,
	SALESITEMTYPEKEY,
	SALESITEMCATEGORYKEY,
	SPECIALSTOCKSKEY,
	BUSINESSADDRESSKEY,
	SALESDOCUMENTNUMBER,
	SALESDOCUMENTITEM,
	COMPANYORGANIZATIONCODE,
	SALESORGANIZATIONCODE,
	CUSTOMERORDERNUMBER,
	REJECTIONFLAG,
	DELIVERYBLOCKINDICATOR,
	DSCREATEDTIME,
	DSCREATEDBY,
	DSCREATEDONDATEKEY,
	DSLASTCHANGEDDATEKEY,
	DSITEMCREATEDONDATEKEY,
	DSITEMLASTCHANGEDDATEKEY,
	CUSTOMERPURCHASEORDERDATEKEY,
	REQUIREMENTDATEKEY,
	ROUTE,
	NCFLAG,
	DESTINATIONCODE,
	PRIORITY,
	SHIPPINGTYPEKEY,
	CUSTOMERORDERTYPEKEY,
	TOTALNETVALUE,
	NETVALUE,
	UNITPRICE,
	PRICEUNIT,
	TARGETQUANTITY,
	CUMULATIVEORDERQUANTITY,
	CUMULATIVEOPENQUANTITY,
	CUMULATIVECONFIRMEDQUANTITY,
	SRCLASTMODIFIEDDATE,
	WCS_ORDERDATEKEY,
	MATERIALSTAGINGDATEKEY,
	DOCUMENTDATEKEY,
	GOODSMOVEMENTDATEKEY,
	WCS_ORDERNUMBER,
	WCS_ORDERLINENUMBER,
	CUSTOMERMATERIALCODE,
	CUSTOMERMATERIALDESCRIPTION,
	POLINENUMBER,
	SALESUNITSORDERQTY,
	CONFIRMEDQTY,
	STATUS,
	SHIPSERVICELEVEL,
	DESIGNID,
	BILLTOBUSINESSADDRESSKEY,
	SALESORDERCOMPLETEDELIVERY,
	TRACEABILITYNUMBER,
	INVOICENUMBER,
	CARRIERADDRESSKEY,
	DELIVERYNUMBER,
	BILLOFLANDING,
	ACTUALDELIVEREDQTY,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.FACTSALESORDERS table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-04-05      Noel San Juan          Initial Revision
*/
SELECT  DISTINCT
	ESSO.DataSourceKey							AS DataSourceKey,
	IFNULL(DC.MaterialGroupKey,0)				AS CustomerKey,
	CASE
		WHEN ESSO.EFFECTIVEFROMDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.EFFECTIVEFROMDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS EFFECTIVEFROMDATEKEY,
	CASE
		WHEN ESSO.EFFECTIVETODATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.EFFECTIVETODATE, 'YYYYMMDD' ), '1900-01-01')
	END AS EFFECTIVETODATEKEY,
	CASE
		WHEN ESSO.REQUESTDELIVERYDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.REQUESTDELIVERYDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS REQUESTDELIVERYDATEKEY,
	CASE
		WHEN ESSO.RECEIPTDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.RECEIPTDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS RECEIPTDATEKEY,
	IFNULL(DP.PlantKey,0)						AS PlantKey,
	IFNULL(DM.MaterialKey,0)					AS MaterialKey,
	IFNULL(DSDT.SalesDocumentTypeKey,0)			AS SalesDocumentTypeKey,
	IFNULL(DSDC.SalesDocumentCategoryKey, 0)	AS SalesDocumentCategoryKey,
	IFNULL(DSIT.SalesItemTypeKey,0)				AS SalesItemTypeKey,
	IFNULL(DSIC.SalesItemCategoryKey,0)			AS SalesItemCategoryKey,
	IFNULL(DSS.SpecialStocksKey,0 )				AS SpecialStocksKey,
	IFNULL(DBA.BusinessAddressKey,0 )			AS BusinessAddressKey,
	IFNULL(ESSO.salesdocumentnumber,'')			AS SalesDocumentNumber,
	IFNULL(ESSO.salesdocumentitem::integer,'0')	AS salesdocumentitem,
	IFNULL(ESSO.companyorganizationcode,'')		AS companyorganizationcode,
	IFNULL(ESSO.salesorganizationcode,'')		AS salesorganizationcode,
	IFNULL(ESSO.customerordernumber,'')			AS customerordernumber,
	IFNULL(ESSO.rejectionflag,'')				AS rejectionflag,
	IFNULL(ESSO.deliveryblockindicator,'')		AS deliveryblockindicator,
	IFNULL(ESSO.dscreatedtime,'000000')			AS dscreatedtime,
	IFNULL(ESSO.dscreatedby,'')					AS dscreatedby,
	CASE
		WHEN ESSO.DSCREATEDONDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.DSCREATEDONDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS DSCREATEDONDATEKEY,
	CASE
		WHEN ESSO.DSLASTCHANGEDDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.DSLASTCHANGEDDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS DSLastChangedDateKey,
	CASE
		WHEN ESSO.DSITEMCREATEDONDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.DSITEMCREATEDONDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS DSITEMCREATEDONDATEKEY,
	CASE
		WHEN ESSO.DSITEMLASTCHANGEDDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.DSITEMLASTCHANGEDDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS DSITEMLASTCHANGEDDATEKEY,
	CASE
		WHEN ESSO.CUSTOMERPURCHASEORDERDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.CUSTOMERPURCHASEORDERDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS CUSTOMERPURCHASEORDERDATEKEY,
	CASE
		WHEN ESSO.REQUIREMENTDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.REQUIREMENTDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS REQUIREMENTDATEKEY,
	IFNULL(ESSO.route,'')						AS route,
	IFNULL(ESSO.ncflag,'')						AS ncflag,
	IFNULL(ESSO.destinationcode,'')				AS destinationcode,
	IFNULL(ESSO.Priority,'')					AS Priority,
	IFNULL(DST.ShippingTypeKey,0)				AS ShippingTypeKey,
	IFNULL(DCOT.CustomerOrderTypeKey,0)			AS CustomerOrderTypeKey,
	IFNULL(ESSO.totalnetvalue,0)				AS totalnetvalue,
	IFNULL(ESSO.netvalue,0)						AS netvalue,
	IFNULL(ESSO.unitprice,0)					AS unitprice,
	IFNULL(ESSO.priceunit,0)					AS priceunit,
	IFNULL(ESSO.targetquantity,0)				AS targetquantity,
	IFNULL(ESSO.cumulativeorderquantity,0)		AS cumulativeorderquantity,
	IFNULL(ESSO.cumulativeopenquantity,0)		AS cumulativeopenquantity,
	IFNULL(ESSO.cumulativeconfirmedquantity,0)	AS cumulativeconfirmedquantity,
	ESSO.Updated_on_VBAK						AS SrclastModifiedDate,
	CASE
		WHEN ESSO.WCS_ORDERDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.WCS_ORDERDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS WCS_ORDERDATEKEY,
	CASE
		WHEN ESSO.MATERIALSTAGINGDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.MATERIALSTAGINGDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS MATERIALSTAGINGDATEKEY,
	CASE
		WHEN ESSO.DOCUMENTDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.DOCUMENTDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS DOCUMENTDATEKEY,
	CASE
		WHEN ESSO.GOODSMOVEMENTDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESSO.GOODSMOVEMENTDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS GOODSMOVEMENTDATEKEY,
	IFNULL(ESSO.wcs_ordernumber,'')				AS WCS_OrderNumber,
	IFNULL(ESSO.wcs_orderlinenumber,'')			AS WCS_OrderLineNumber,
	IFNULL(ESSO.customermaterial,'')			AS CustomerMaterialCode,
	IFNULL(ESSO.customermaterialdescription,'') AS CustomerMaterialDescription,
	IFNULL(ESSO.po_linenumber,'')				AS POLineNumber,
	IFNULL(ESSO.salesunitsorderqty, 0)			AS SalesUnitsOrderQty,
	IFNULL(ESSO.confirmedqty, 0)				AS ConfirmedQty,
	IFNULL(ESSO.status,'')						AS status,
	IFNULL(ESSO.shipservicelevel,'')			AS shipservicelevel,
	IFNULL(ESSO.designid,'')					AS designid,
	IFNULL(DBAB.BusinessAddressKey, 0)			AS BillToBusinessAddressKey,
	IFNULL(ESSO.salesordercompletedelivery,'')	AS salesordercompletedelivery,
	IFNULL(ESSO.TraceabilityNumber,'')			AS TraceabilityNumber,
	IFNULL(ESSO.InvoiceNumber,'')        		AS InvoiceNumber,
	IFNULL(DBAB1.BusinessAddressKey,0)			AS CarrierAddressKey,
	IFNULL(ESSO.Delivery,'')					AS DeliveryNumber,
	IFNULL(ESSO.BillOfLanding,'')				AS BillOfLanding,
	IFNULL(ESSO.ActualDeliveredQty,0)			AS ActualDeliveredQty,
	HASH
	(
		IFNULL(DC.MaterialGroupKey,0),
		IFNULL(ESSO.EFFECTIVEFROMDATE,''),
		IFNULL(ESSO.EFFECTIVETODATE,''),
		IFNULL(ESSO.REQUESTDELIVERYDATE,''),
		IFNULL(ESSO.RECEIPTDATE,''),
		IFNULL(DP.PlantKey,0),
		IFNULL(DM.MaterialKey,0),
		IFNULL(DSDT.SalesDocumentTypeKey,0),
		IFNULL(DSDC.SalesDocumentCategoryKey,0),
		IFNULL(DSIT.SalesItemTypeKey,0),
		IFNULL(DSIC.SalesItemCategoryKey,0),
		IFNULL(DSS.SpecialStocksKey,0),
		IFNULL(DBA.BusinessAddressKey,0),
		IFNULL(ESSO.salesdocumentnumber,''),
		IFNULL(ESSO.salesdocumentitem::integer,0),
		IFNULL(ESSO.companyorganizationcode,''),
		IFNULL(ESSO.salesorganizationcode,''),
		IFNULL(ESSO.customerordernumber,''),
		IFNULL(ESSO.rejectionflag,''), 
		IFNULL(ESSO.deliveryblockindicator,''),
		IFNULL(ESSO.dscreatedtime,''),
		IFNULL(ESSO.dscreatedby,''),
		IFNULL(ESSO.DSCREATEDONDATE,''),
		IFNULL(ESSO.DSLASTCHANGEDDATE,''),
		IFNULL(ESSO.DSITEMCREATEDONDATE,''),
		IFNULL(ESSO.DSITEMLASTCHANGEDDATE,''),
		IFNULL(ESSO.CUSTOMERPURCHASEORDERDATE,''),
		IFNULL(ESSO.REQUIREMENTDATE,''),
		IFNULL(ESSO.WCS_ORDERDATE,''),
		IFNULL(ESSO.route,''),
		IFNULL(ESSO.ncflag,''), 
		IFNULL(ESSO.destinationcode,''),
		IFNULL(ESSO.Priority,''),
		IFNULL(DST.ShippingTypeKey,0),
		IFNULL(DCOT.CustomerOrderTypeKey,0),
		IFNULL(ESSO.totalnetvalue,0),
		IFNULL(netvalue,0),
		IFNULL(ESSO.unitprice,0),
		IFNULL(ESSO.priceunit,0),
		IFNULL(ESSO.targetquantity ,0),
		IFNULL(ESSO.cumulativeorderquantity,0),
		IFNULL(ESSO.cumulativeopenquantity,0),
		IFNULL(ESSO.cumulativeconfirmedquantity,0),
		IFNULL(ESSO.MATERIALSTAGINGDATE,''),
		IFNULL(ESSO.wcs_ordernumber,''),
		IFNULL(ESSO.wcs_orderlinenumber,''),
		IFNULL(ESSO.customermaterial,''),
		IFNULL(ESSO.customermaterialdescription,''),
		IFNULL(ESSO.po_linenumber,''),
		IFNULL(ESSO.salesunitsorderqty,0),
		IFNULL(ESSO.confirmedqty,0),
		IFNULL(ESSO.DOCUMENTDATE,'')
    )  AS HASH_VALUE
FROM 
	CONFORMED.SAP_SALESORDERS AS ESSO
    LEFT OUTER JOIN SAP.DimSalesDocumentCategories AS DSDC ON ESSO.salesdocumentcategory = DSDC.SalesDocumentCategoryCode
        AND DSDC.DataSourceKey = ESSO.DataSourceKey
    LEFT OUTER JOIN SAP.DimSalesDocumentTypes AS DSDT ON ESSO.salesdocumenttype = DSDT.SalesDocumentTypeCode
        AND DSDT.DataSourceKey = ESSO.DataSourceKey
    LEFT OUTER JOIN SAP.DimSalesItemCategories AS DSIC ON ESSO.salesitemcategory = DSIC.SalesItemCategoryCode
        AND DSIC.DataSourceKey = ESSO.DataSourceKey
    LEFT OUTER JOIN SAP.DimSalesItemTypes AS DSIT ON ESSO.salesitemtype = DSIT.SalesItemTypeCode
        AND DSIT.DataSourceKey = ESSO.DataSourceKey
    LEFT OUTER JOIN SAP.DimShippingTypes AS DST ON ESSO.ShippingType = DST.ShippingTypeCode
        AND DST.DataSourceKey = ESSO.DataSourceKey
    LEFT OUTER JOIN SAP.DimCustomerOrderTypes AS DCOT ON ESSO.CustomerOrderType = DCOT.CustomerOrderTypeCode
        AND DCOT.DataSourceKey = ESSO.DataSourceKey
	LEFT OUTER JOIN SAP.DimMaterialGroups AS DC ON DC.MaterialGroupCode = ESSO.customer
        AND DC.DataSourceKey = ESSO.DataSourceKey
	LEFT OUTER JOIN SAP.DimPlants AS DP	ON ESSO.plant = DP.PlantCode
        AND DP.DataSourceKey = ESSO.DataSourceKey
	LEFT OUTER JOIN SAP.DimMaterials AS DM ON RTRIM(ESSO.material ) = DM.MaterialCode
        AND DP.PlantKey = DM.PlantKey
        AND DM.DataSourceKey = ESSO.DataSourceKey
	LEFT OUTER JOIN SAP.DimSpecialStocks AS DSS ON ESSO.specialstocks = DSS.SpecialStocksCode
        AND DSS.DataSourceKey = ESSO.DataSourceKey
    LEFT OUTER JOIN SAP.DimBusinessAddress  DBA ON DBA.AddressCode = IFNULL(ESSO.AddressCode,'1') AND DBA.DataSourceKey <> 0
        AND DBA.DataSourceKey = ESSO.DataSourceKey
	LEFT OUTER JOIN SAP.DimBusinessAddress AS DBAB ON DBAB.AddressCode = IFNULL(ESSO.BillToAddressCode,'1') AND DBAB.DataSourceKey <> 0
        AND DBAB.DataSourceKey = ESSO.DataSourceKey
	LEFT OUTER JOIN SAP.DimBusinessAddress AS DBAB1 ON DBAB1.AddressCode = IFNULL(ESSO.carrier,'1') AND DBAB1.DataSourceKey <> 0
		AND DBAB1.DataSourceKey = ESSO.DataSourceKey;
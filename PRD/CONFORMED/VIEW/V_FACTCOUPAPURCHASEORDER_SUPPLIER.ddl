create or replace view V_FACTCOUPAPURCHASEORDER_SUPPLIER(
	PURCHASEORDERID,
	PURCHASEORDERNUMBER,
	PURCHASEORDERLINEID,
	PURCHASEORDERLINENUMBER,
	ACCOUNTLINEID,
	ACCOUNTLINENUMBER,
	DATASOURCEKEY,
	SUPPLIERKEY,
	NEWSUPPLIERKEY,
	SUPPLIERCODE,
	NEWSUPPLIERCODE,
	SUPPLIERPLANTKEY,
	NEWSUPPLIERPLANTKEY,
	SUPPLIERNAME,
	NEWSUPPLIERNAME
) as
SELECT 
  PurchaseOrderId,
  PurchaseOrderNumber,
  PurchaseOrderLineId,
  PurchaseOrderLineNumber,
  AccountLineID,
  AccountLineNumber,
  DataSourceKey,
  SupplierKey,
  MAX(SupplierKey) OVER (PARTITION BY purchaseorderid,purchaseordernumber,purchaseorderlineid,purchaseorderlinenumber,AccountLineNumber,DataSourceKey) AS NewSupplierKey , 
  SupplierCode,
  MAX(SupplierCode) OVER (PARTITION BY purchaseorderid,purchaseordernumber,purchaseorderlineid,purchaseorderlinenumber,AccountLineNumber,DataSourceKey) AS NewSupplierCode, 
  SupplierPlantKey,
  MAX(SupplierPlantKey) OVER (PARTITION BY purchaseorderid,purchaseordernumber,purchaseorderlineid,purchaseorderlinenumber,AccountLineNumber,DataSourceKey) AS NewSupplierPlantKey,
  SupplierName,
  MAX(SupplierName) OVER (PARTITION BY purchaseorderid,purchaseordernumber,purchaseorderlineid,purchaseorderlinenumber,AccountLineNumber,DataSourceKey) AS NewSupplierName 
FROM COUPA.FactCoupaPurchaseOrders;
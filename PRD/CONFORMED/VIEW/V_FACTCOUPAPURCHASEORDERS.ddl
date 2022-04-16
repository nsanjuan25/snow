create or replace view V_FACTCOUPAPURCHASEORDERS(
	PURCHASEORDERID,
	PURCHASEORDERNUMBER,
	PURCHASEORDERLINEID,
	PURCHASEORDERLINENUMBER,
	ACCOUNTLINEID,
	ACCOUNTLINENUMBER,
	DATASOURCEKEY,
	SUPPLIERKEY,
	SUPPLIERPLANTKEY,
	PURCHASEORDERCREATEDDATEKEY,
	PUBLISHEDDATEKEY,
	PLANTKEY,
	SPECIALSTOCKSKEY,
	COMPANYORGANIZATIONCODE,
	PURCHASEQUANTITY,
	NETPRICE,
	PRICEUNIT,
	UNITPRICE,
	TOTALPRICE,
	CUMULATIVEQUANTITY,
	ACCOUNTASSIGNMENT,
	DSCREATEUSER,
	DSCREATEDTS,
	PAYMENTTERMKEY,
	SRCLASTMODIFIEDDATE,
	MATERIALGROUP,
	PLANT,
	PLANTNAMELONG,
	SUPPLIERCODE,
	GLOBALSUPPLIERNAME,
	LOCALSUPPLIERNAME,
	SUPPLIERNUMBER,
	SUPPLIERNAME,
	LASTUPDATEDDATE,
	COMMODITY,
	ACCOUNT,
	DELETEFLAG,
	ORDERLINEDESCRIPTION,
	HASHVALUE
) as
/* 
Description             : This is the template for Header Section on Views
Created date            : 2021-05-19
Created By              : Arnel Melchor

Start Revision History            
-----------------------------------------------------------------------------------------------
Date                 Developer           Revision Description
----------           --------------      -----------------------------------------------------------
2021-05-19           Arnel Melchor            Initial Create
-----------------------------------------------------------------------------------------------
End   Revision   History
*/
SELECT
    fin.PurchaseOrderID
  , fin.PurchaseOrderNumber
  , fin.PurchaseOrderLineID
  , fin.PurchaseOrderLineNumber
  , fin.AccountLineID
  , fin.AccountLineNumber
  , fin.Datasourcekey
  , fin.SupplierKey
  , fin.SupplierPlantKey
  , fin.PurchaseOrderCreatedDateKey
  , fin.PublishedDateKey
  , fin.PlantKey
  , fin.SpecialStocksKey
  , fin.CompanyOrganizationCode
  , fin.PurchaseQuantity
  , fin.NetPrice
  , fin.PriceUnit
  , fin.UnitPrice
  , fin.TotalPrice
  , fin.CumulativeQuantity
  , fin.AccountAssignment
  , fin.DSCreateUser
  , fin.DSCreateDTS
  , fin.PaymentTermKey
  , fin.SrcLastModifiedDate
  , fin.MaterialGroup
  , fin.Plant
  , fin.PlantNameLong
  , fin.SupplierCode
  , fin.Globalsuppliername
  , fin.Localsuppliername
  , fin.SupplierNumber
  , fin.SupplierName
  , fin.LastUpdatedDate
  , fin.Commodity
  , fin.Account
  , fin.DeleteFlag
  , fin.OrderLineDescription
  , HASH(
      fin.SupplierKey,
      fin.SupplierPlantKey,
      fin.PurchaseOrderCreatedDateKey,
      fin.PublishedDateKey,
      fin.PlantKey,
      fin.SpecialStocksKey,
      fin.CompanyOrganizationCode,
      fin.PurchaseQuantity,
      fin.NetPrice,
      fin.PriceUnit,
      fin.UnitPrice,
      fin.TotalPrice,
      fin.CumulativeQuantity,
      fin.AccountAssignment,
      fin.PaymentTermKey,
      fin.MaterialGroup,
      fin.Plant,
      fin.PlantNameLong,
      fin.SupplierCode,
      fin.Globalsuppliername,
      fin.Localsuppliername,
      fin.SupplierNumber,
      fin.Commodity,
      fin.SupplierName,
      fin.Account,
      fin.DeleteFlag,
      fin.OrderLineDescription
      ) AS HashValue
FROM
(
  SELECT
      ROW_NUMBER() OVER ( PARTITION BY PurchaseOrderID,PurchaseOrderNumber,PurchaseOrderLineID,AccountLineID,AccountLineNumber ORDER BY SrcLastModifiedDate DESC) AS RowID
    , dups.PurchaseOrderID
    , dups.PurchaseOrderNumber
    , dups.PurchaseOrderLineID
    , dups.PurchaseOrderLineNumber
    , dups.AccountLineID
    , dups.AccountLineNumber
    , dups.Datasourcekey
    , dups.SupplierKey
    , dups.SupplierPlantKey
    , dups.PurchaseOrderCreatedDateKey
    , dups.PublishedDateKey
    , dups.PlantKey
    , dups.SpecialStocksKey
    , dups.CompanyOrganizationCode
    , dups.PurchaseQuantity
    , dups.NetPrice
    , dups.PriceUnit
    , dups.UnitPrice
    , dups.TotalPrice
    , dups.CumulativeQuantity
    , dups.AccountAssignment
    , dups.DSCreateUser
    , dups.DSCreateDTS
    , dups.PaymentTermKey
    , dups.SrcLastModifiedDate
    , dups.MaterialGroup
    , dups.Plant
    , dups.PlantNameLong
    , dups.SupplierCode
    , dups.Globalsuppliername
    , dups.Localsuppliername
    , dups.SupplierNumber
    , dups.SupplierName
    , dups.LastUpdatedDate
    , dups.Commodity
    , dups.Account
    , dups.DeleteFlag
    , dups.OrderLineDescription
  FROM
      (
        SELECT
           po.poid								    AS PurchaseOrderID
          ,po.Ponumber							    AS PurchaseOrderNumber
          ,CAST(IFNULL(po.orderlineid,0) AS INT)	AS PurchaseOrderLineID
          ,CAST(IFNULL(po.orderlinenumber,0) AS INT) AS PurchaseOrderLineNumber
          ,CAST(IFNULL(po.accountlineid,0) AS INT)	AS AccountLineID
          ,CAST(IFNULL(po.accountlinenumber,0) AS INT)	AS AccountLineNumber
          ,DSource.Datasourcekey				    AS Datasourcekey
          ,IFNULL(SupplierKey,0)					AS SupplierKey
          ,IFNULL(SupplierKey,0)					AS SupplierPlantKey
          ,TO_DATE(IFNULL(SUBSTRING(po.orderlinecreationdate,1,10),'1900-01-01'))	AS PurchaseOrderCreatedDateKey
          ,TO_DATE(IFNULL(SUBSTRING(po.orderlinecreationdate,1,10),'1900-01-01'))	AS PublishedDateKey
          ,IFNULL(dp.PlantKey,0)					AS PlantKey
          ,'1'									    AS SpecialStocksKey
          ,IFNULL(po.Companycode,'')				AS CompanyOrganizationCode
          ,po.quantity								AS PurchaseQuantity
          ,po.price									AS NetPrice
          ,po.price									AS PriceUnit
          ,po.price									AS UnitPrice
          ,po.price									AS TotalPrice
          ,po.quantity								AS CumulativeQuantity
          ,CASE WHEN po.ChartOfAccounts = 'NRE Internal Orders' THEN 'NRE IO'
            ELSE IFNULL(LEFT(po.ChartOfAccounts,10),'')
          END										AS AccountAssignment
          ,IFNULL(po.orderlinecreatedby,'')		    AS DSCreateUser
          ,TO_DATE(IFNULL(SUBSTRING(po.orderlinecreationdate,1,10),'1900-01-01'))	AS DSCreateDTS
          ,IFNULL(dpt.PaymentTermKey,0)			    AS PaymentTermKey
          ,IFNULL(CAST(CAST( po.lastupdateddate AS TIMESTAMP_TZ) AS DATETIME),'1900-01-01 00:00:00.000')	AS SrcLastModifiedDate
          ,'UNDF'								    AS MaterialGroup
          ,IFNULL(po.Plant,'')					    AS Plant
          ,IFNULL(dp.PlantNameLong,'')			    AS PlantNameLong
          ,IFNULL(CASE WHEN 
                    CHARINDEX(char(32),po.SupplierCode) > 0 THEN RTRIM(LEFT(po.SupplierCode,(CHARINDEX(char(32),po.SupplierCode))))
                ELSE po.SupplierCode END,'')	    AS SupplierCode
          ,IFNULL(s.Globalsuppliername,'')		    AS Globalsuppliername
          ,IFNULL(s.Localsuppliername,'')		    AS Localsuppliername
          ,IFNULL(po.Suppliernumber,'')			    AS SupplierNumber
          ,IFNULL(po.Suppliername,'')			    AS SupplierName
          ,IFNULL(gl.ECC,'')					    AS GLAccountNumber
          ,IFNULL(coa.txt50,'')					    AS GLDescription
          ,IFNULL(po.CostCenter,'')				    AS CostCenter
          ,IFNULL(CAST(CAST( po.lastupdateddate AS TIMESTAMP_TZ) AS DATETIME),'1900-01-01 00:00:00.000')	AS LastUpdatedDate
          ,IFNULL(po.orderlinecommodity,'')		    AS Commodity
          ,po.accountcode						    AS Account
          ,IFNULL(po.orderlinedescription,'')	    AS OrderLineDescription
          ,'0'									    AS DeleteFlag
        FROM
        (
          SELECT 
              ROW_NUMBER() OVER ( PARTITION BY poid,orderlineid,accountlineid,accountlinenumber ORDER BY LASTUPDATEDDATE DESC) rn
            , poid
            , ponumber
            , orderlineid
            , orderlinenumber
            , accountlineid
            , accountlinenumber
            , LEFT(LTRIM(RTRIM(
              CASE 
                     WHEN ChartOfAccounts LIKE '%Expense%' THEN segment1 
                     WHEN ChartOfAccounts LIKE '%NRE%Internal%Order%' THEN segment2 
                     WHEN ChartOfAccounts LIKE '%Capital%' THEN segment3 
                     WHEN ChartOfAccounts LIKE '%Network%Order%' THEN segment2 
                     ELSE NULL 
                 END)),4) AS companycode
            , CAST(price AS NUMERIC(23,6)) AS price
            , ChartOfAccounts
            , orderlinecreatedby
            , orderlinecreationdate
            , CASE 
                   WHEN ChartOfAccounts LIKE '%Expense%' THEN NULL 
                   WHEN ChartOfAccounts LIKE '%NRE%Internal%Order%' THEN segment3 
                   WHEN ChartOfAccounts LIKE '%Capital%' THEN segment4 
                   WHEN ChartOfAccounts LIKE '%Network%Order%' THEN segment3 
                   ELSE NULL 
               END AS profitcenter
            , LTRIM(RTRIM(LEFT(shiptoaddressname,4))) AS Plant
            , LEFT(suppliernumber,10) AS SupplierCode
            , Suppliernumber
            , Suppliername
            , CASE 
                     WHEN ChartOfAccounts LIKE '%Expense%' THEN segment3 
                     WHEN ChartOfAccounts LIKE '%NRE%Internal%Order%' THEN segment4 
                     WHEN ChartOfAccounts LIKE '%Capital%' THEN segment5 
                     WHEN ChartOfAccounts LIKE '%Network%Order%' THEN segment4 
                     ELSE NULL 
                 END AS costcenter
            , orderlinecommodity
            , accountcode
            , orderlinedescription
            , CASE 
                     WHEN ChartOfAccounts LIKE '%Expense%' THEN lpad(regexp_replace(segment5, '[^[:digit:]]', ''), 10, '0') 
                     WHEN ChartOfAccounts LIKE '%NRE%Internal%Order%' THEN lpad(regexp_replace(segment6, '[^[:digit:]]', ''), 10, '0') 
                     WHEN ChartOfAccounts LIKE '%Capital%' THEN lpad(regexp_replace(segment7, '[^[:digit:]]', ''), 10, '0') 
                     WHEN ChartOfAccounts LIKE '%Network%Order%' THEN lpad(regexp_replace(segment5, '[^[:digit:]]', ''), 10, '0') 
                     ELSE '0000000000' 
                 END AS CoupaGlAccount
            , paymentterm
            , CAST( CASE WHEN quantity IS NULL THEN 0
                    WHEN quantity = 'NULL' THEN 0
                    WHEN quantity = '' THEN 0
                ELSE quantity
               END AS NUMERIC(18, 6)) 										AS quantity
            , LASTUPDATEDDATE
          FROM CONFORMED.COUPA_PURCHASEORDERS
          WHERE ChartOfAccounts IN('NRE Internal Orders','Expense','Capital')
        ) po
        LEFT OUTER JOIN SAP.DimPlants DP ON po.Plant = DP.PlantCode
             AND DP.DataSourceKey = 1
        LEFT OUTER JOIN CONFORMED.COUPA_GLACCOUNTS gl ON gl.Controller = po.CoupaGlAccount
        LEFT OUTER JOIN SAP.Dimsuppliers s ON s.SupplierCode = CASE WHEN CHARINDEX(char(32),po.SupplierCode) > 0 THEN RTRIM(LEFT(po.SupplierCode,(CHARINDEX(char(32),po.SupplierCode)))) ELSE po.SupplierCode END
             AND s.DataSourceKey = 1
        LEFT OUTER JOIN SAP.DimPaymentTerms dpt ON po.paymentterm = dpt.PaymentTerms
        LEFT OUTER JOIN CONFORMED.ECC_HA_SKAT coa ON coa.SAKNR = gl.Ecc
             AND coa.KTOPL = '0010'
             AND coa.SPRAS = 'E'
        LEFT OUTER JOIN CONFORMED.ECC_HA_CSKS ccm ON ccm.KOSTL = po.costcenter
        LEFT OUTER JOIN (SELECT MAX(DataSourceKey) AS DataSourceKey,DataSourceName FROM PUBLIC.DimDataSources GROUP BY DataSourceName) DSource ON DSource.DataSourceName = 'Coupa'
        WHERE po.rn = 1
     ) dups
 ) fin
 WHERE fin.ROWID = 1;
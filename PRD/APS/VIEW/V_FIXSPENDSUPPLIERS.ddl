create or replace view V_FIXSPENDSUPPLIERS(
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	MATERIALDOCUMENTNUMBER,
	MATERIALDOCUMENTITEM,
	MATERIALDOCUMENTYEAR,
	DATASOURCEKEY,
	CURRENTSUPPLIER,
	NEWSUPPLIERKEY,
	SUPPLIERCODE
) as
/*
    View to fix historical spend laoded data from aps for invalid suppliers
    view created on Nov24 2021
*/
select 
         S.PurchaseDocumentNumber
        ,S.PurchaseDocumentItem
        ,s.MaterialDocumentNumber
        ,s.MaterialDocumentItem
        ,s.materialdocumentyear
        ,s.DataSourceKey              
        , S.SUPPLIERKEY AS CURRENTSUPPLIER
        , SUP.SUPPLIERKEY AS NEWSUPPLIERKEY 
        , SUP.SUPPLIERCODE
FROM
    APS.SPEND FHS 
    inner join sap.FactHistoricalSpend S
        on FHS.PurchaseDocumentNumber = S.PurchaseDocumentNumber
        and FHS.PurchaseDocumentItem = S.PurchaseDocumentItem
        and fhs.MaterialDocumentNumber = s.MaterialDocumentNumber
        and fhs.MaterialDocumentItem = s.MaterialDocumentItem
        and fhs.materialdocumentyear =  s.materialdocumentyear
        and fhs.datasourcekey = s.datasourcekey

    --LEFT OUTER JOIN 
      INNER JOIN 
              (
                SELECT 
                      SUPPLIERKEY , SUPPLIERCODE, DATASOURCEKEY, ROW_NUMBER() OVER (PARTITION BY SUPPLIERCODE, DATASOURCEKEY ORDER BY DELETEFLAG ASC, CREATEDON DESC)RN
                FROM
                    SAP.DIMSUPPLIERS             
              ) SUP ON FHS.SUPPLIERCODE = SUP.SUPPLIERCODE
              AND FHS.DATASOURCEKEY = SUP.DATASOURCEKEY
              AND SUP.RN = 1
WHERE 
    S.cREATEDbY = 'APS GAP HISTORY'
    AND S.SUPPLIERKEY = 0 
    AND FHS.SUPPLIERKEY <> 0;
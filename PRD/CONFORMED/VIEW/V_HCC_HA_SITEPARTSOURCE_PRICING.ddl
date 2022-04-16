create or replace view V_HCC_HA_SITEPARTSOURCE_PRICING(
	DATASOURCEKEY,
	SITECODE,
	SITEPARTCODE,
	SUPPLIERCORPORATIONDSCODE,
	SITEPARTSOURCETYPECODE,
	PURCHASINGORGANIZATIONCODE,
	EFFECTIVEFROMDATE,
	EFFECTIVETODATE,
	SITEPARTSOURCEPRICINGREFERENCE,
	UNITPRICE,
	PRICEUNIT,
	UNITOFMEASUREDSCODE,
	CURRENCYCODE,
	STATUSCODE,
	DELETEFLAG,
	CORPORATIONDSTYPECODE
) as
/*--------------------------------------------------------------------

This view is used to spend_analytics 
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-02-24      Noel San Juan          Initial Revision
*/
SELECT * 
FROM 
(
	SELECT
		2 AS DataSourceKey,
		a.werks SiteCode, 
        a.matnr SitePartCode, 
        a.lifnr SupplierCorporationDSCode, 
        a.esokz SitePartSourceTypeCode, 
        a.ekorg PurchasingOrganizationCode, 
        IFNULL ( TRY_TO_DATE( a.datab, 'YYYYMMDD' ), '1900-01-01') EffectiveFromDate, 
        IFNULL ( TRY_TO_DATE( a.datbi, 'YYYYMMDD' ), '1900-01-01') EffectiveToDate,
        concat(k.knumh, k.kopos) SitePartSourcePricingReference, 
        k.kbetr UnitPrice, 
        k.kpein PriceUnit, 
        k.kmein UnitOfMeasureDSCode, 
        k.konwa CurrencyCode, 
        CASE 
            WHEN upper(k.kfrst) = 'A' THEN 'BLOCKED' 
            WHEN upper(k.kfrst) = 'B' THEN 'PRICESIMULATION' 
            WHEN upper(k.kfrst) = 'C' THEN 'PRICEPLANSIMULATION' 
            ELSE '' 
        END StatusCode, 
        CASE 
            WHEN k.loevm_ko IS NOT NULL THEN '1' 
            ELSE '0' 
        END DeleteFlag, 
        l.ktokk CorporationDSTypeCode 
	FROM 
		CONFORMED.HCC_HA_A017 a 
		LEFT OUTER JOIN CONFORMED.HCC_HA_KONP k ON a.knumh = k.knumh 
			AND a.kappl = k.kappl 
			AND a.kschl = k.kschl 
	   LEFT OUTER JOIN CONFORMED.HCC_HA_LFA1 l ON a.lifnr = l.lifnr
) a;
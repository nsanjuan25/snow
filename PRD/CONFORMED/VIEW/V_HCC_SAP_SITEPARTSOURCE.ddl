create or replace view V_HCC_SAP_SITEPARTSOURCE(
	DATASOURCEKEY,
	PLANTCODE,
	MATERIALCODE,
	SUPPLIERCORPORATIONDSCODE,
	MATERIALSOURCETYPECODE,
	MATERIALSOURCECATEGORYCODE,
	SEQUENCENUMBER,
	MATERIALSOURCEREFERENCE,
	EFFECTIVEFROMDATE,
	EFFECTIVETODATE,
	MRPINDICATOR,
	FIXEDLEADTIME,
	CANCELLATIONLEADTIME,
	YIELD,
	ORDERUNITOFMEASUREDSCODE,
	MAXIMUMLOTSIZE,
	MINIMUMLOTSIZE,
	MULTIPLEQTY,
	NUMBEROFDAYSSUPPLY,
	PLANNINGTIMEFENCE,
	PRIORITY,
	TARGETRATIO,
	TODATEQTY,
	TRANSFERSITECODE,
	TRANSFERSITEPARTCODE,
	AMLREFERENCE,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	STATUSCODE,
	DSCREATEUSER,
	DSCREATEDTS,
	DELETEFLAG,
	CORPORATIONDSTYPECODE,
	PURCHASINGORGANIZATIONCODE,
	ROWNUM
) as
/*--------------------------------------------------------------------

This view is used to ADD data into CONFORMED.SAP_SITEPARTSOURCE table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-22      Noel San Juan          Initial Revision
*/
SELECT * 
FROM 
(
	SELECT
        2 AS DataSourceKey,
		A.sitecode AS PlantCode, 
		A.sitepartcode AS MaterialCode, 
		A.suppliercorporationdscode, 
		A.sitepartsourcetypecode AS MaterialSourceTypeCode, 
		A.sitepartsourcecategorycode AS MaterialSourceCategoryCode, 
		A.sequencenumber, 
		A.sitepartsourcereference AS MaterialSourceReference, 
		A.effectivefromdate, 
		A.effectivetodate, 
		A.mrpindicator, 
		A.fixedleadtime, 
		A.cancellationleadtime, 
		A.yield, 
		A.orderunitofmeasuredscode, 
		A.maximumlotsize, 
		A.minimumlotsize, 
		A.multipleqty, 
		A.numberofdayssupply, 
		A.planningtimefence, 
		A.priority, 
		A.targetratio, 
		A.todateqty, 
		A.transfersitecode, 
		A.transfersitepartcode, 
		A.amlreference, 
		A.purchasedocumentnumber, 
		A.purchasedocumentitem, 
		A.statuscode, 
		A.dscreateuser, 
		A.dscreatedts, 
		A.deleteflag, 
		A.corporationdstypecode, 
		A.purchasingorganizationcode, 
		A.rownum 
   FROM 
	(
		SELECT 
			a.werks Sitecode, 
			a.matnr sitepartcode, 
			a.lifnr SupplierCorporationDSCode, 
			CASE 
				WHEN c.sobsl = '10' THEN '2' 
				WHEN c.sobsl = '20' THEN '3' 
				ELSE '0' 
			END SitePartSourceTypeCode, 
			'SL' SitePartSourceCategoryCode, 
			a.zeord SequenceNumber, 
			concat(a.werks, '+', a.lifnr, '+', a.zeord, '+', a.matnr) SitePartSourceReference, 
			a.vdatu EffectiveFromDate, 
			a.bdatu EffectiveToDate, 
			a.autet MRPIndicator, 
			CAST('000.0' AS DECIMAL(3,0)) FixedLeadTime, 
			'0' CancellationLeadTime, 
			'0' Yield, 
			d.meins OrderUnitOfMeasureDSCode, 
			CAST('0.0' AS DECIMAL(15,0)) MaximumLotSize, 
			CAST('0.0' AS DECIMAL(15,0)) MinimumLotSize, 
			CAST('0.0' AS DECIMAL(15,0)) MultipleQty, 
			'0' NumberOfDaysSupply, 
			'0' PlanningTimeFence, 
			'0' Priority, 
			CAST('000.0' AS DECIMAL(3,0)) TargetRatio, 
			CAST('000.0' AS DECIMAL(3,0)) ToDateQty, 
			a.reswk TransferSiteCode, 
			CASE 
				WHEN a.reswk IS NOT NULL THEN a.matnr 
				ELSE ' ' 
			END TransferSitePARTCode, 
			a.ematn AMLReference, 
			a.ebeln PurchaseDocumentNumber, 
			a.ebelp PurchaseDocumentItem, 
			CASE 
				WHEN a.notkz > ' ' AND a.notkz IS NOT NULL THEN 'BLOCKED' 
				WHEN a.flifn IS NOT NULL AND a.flifn > ' ' THEN 'FIXED' 
				ELSE 'RELEASED' 
			END StatusCode, 
			a.ernam DSCreateUser, 
			a.erdat DSCreateDTS, 
			CASE 
				WHEN a.bdatu IS NOT NULL THEN 
				(
					CASE 
						WHEN a.bdatu < REPLACE(CURRENT_DATE,'-','') THEN '1' 
						WHEN a.bdatu > REPLACE(CURRENT_DATE,'-','') THEN '0' 
					END
				) 
				WHEN a.bdatu IS NULL THEN '1' 
			END DeleteFlag, 
			r.ktokk CorporationDSTypeCode, 
			a.ekorg PurchasingOrganizationCode, 
			CAST(null AS BIGINT) rownum 
      FROM 
		CONFORMED.HCC_HA_EORD a 
		INNER JOIN CONFORMED.HCC_HA_LFA1 r ON a.lifnr = r.lifnr 
		LEFT OUTER JOIN CONFORMED.HCC_HA_MARC c ON a.matnr = c.matnr 
			AND a.werks = c.werks 
		 LEFT OUTER JOIN CONFORMED.HCC_HA_MARA d ON a.matnr = d.matnr 
      WHERE 
		a.lifnr IS NOT NULL 
      
	  UNION ALL 
	  
	  SELECT 
		Sitecode Sitecode, 
        sitepartcode sitepartcode, 
        lifnr SupplierCorporationDSCode, 
        sobes SitePartSourceTypeCode, 
        fld05 SitePartSourceCategoryCode, 
        SitePartSourceReference SequenceNumber, 
        fld07 SitePartSourceReference, 
        vdatu EffectiveFromDate, 
        bdatu EffectiveToDate, 
        fld10 MRPIndicator, 
        plifz FixedLeadTime, 
        fld12 CancellationLeadTime, 
        fld13 Yield, 
        fld14 OrderUnitOfMeasureDSCode, 
        fld15 MaximumLotSize, 
        fld16 MinimumLotSize, 
        fld17 MultipleQty, 
        fld18 NumberOfDaysSupply, 
        abanz PlanningTimeFence, 
        preih Priority, 
        quote TargetRatio, 
        fld22 ToDateQty, 
        bewrk TransferSiteCode, 
        matnr TransferSitePARTCode, 
        ematn AMLReference, 
        fld26 PurchaseDocumentNumber, 
        fld27 PurchaseDocumentItem, 
        fld28 StatusCode, 
        ernam DSCreateUser, 
        erdat DSCreateDTS, 
        fld31 DeleteFlag, 
        ktokk CorporationDSTypeCode, 
        fld33 PurchasingOrganizationCode, rownum rownum 
    FROM 
	(
		SELECT 
			p.werks Sitecode, 
			p.matnr sitepartcode, 
			q.lifnr, 
			q.sobes, 
			'QA' fld05, 
			p.vdatu SitePartSourceReference, 
			concat(q.qunum, '-', q.qupos) fld07, 
			p.vdatu, 
			p.bdatu, 
			'2' fld10, 
			q.plifz, 
			'0' fld12, 
			'0' fld13, 
			' ' fld14, 
			CASE 
				WHEN q.maxls >= 0 THEN CAST(q.maxls AS DECIMAL(15,0)) 
				WHEN q.maxls IS NULL THEN CAST('0.0' AS DECIMAL(15,0)) 
			END fld15, 
			CASE 
				WHEN q.minls >= 0 THEN CAST(q.minls AS DECIMAL(15,0)) 
				WHEN q.minls IS NULL THEN CAST('0.0' AS DECIMAL(15,0)) 
			END fld16, 
			CASE 
				WHEN t.vormg >= 0 THEN CAST(t.vormg AS DECIMAL(15,0)) 
				WHEN t.vormg IS NULL THEN CAST('0.0' AS DECIMAL(15,0)) 
			END fld17, 
			'0' fld18, 
			q.abanz, 
			q.preih, 
			q.quote, 
			CASE 
				WHEN s.gsmng IS NULL THEN q.qumng 
				WHEN s.gsmng IS NOT NULL THEN (q.qumng - CAST(s.gsmng AS DECIMAL(15,3))) 
			END fld22, 
			q.bewrk, 
			p.matnr, 
			q.ematn, 
			' ' fld26, 
			' ' fld27, 
			'0' fld28, 
			p.ernam, 
			p.erdat, 
			'0' fld31, 
			r.ktokk, 
			a.ekorg fld33, 
			row_number() OVER 
			(
				PARTITION BY 
					p.werks, 
					p.matnr, 
					q.qunum, 
					q.qupos 
				ORDER BY 
					p.werks ASC, 
					p.werks ASC, 
					p.matnr ASC, 
					q.qunum ASC, 
					q.qupos ASC
			) rownum 
		FROM 
			 CONFORMED.HCC_HA_EQUK p 
			 INNER JOIN CONFORMED.HCC_HA_EQUP q ON p.qunum = q.qunum 
			 LEFT OUTER JOIN CONFORMED.HCC_HA_EORD a ON p.werks = a.werks 
				AND p.matnr = a.matnr 
			 INNER JOIN CONFORMED.HCC_HA_LFA1 r ON q.lifnr = r.lifnr 
			 LEFT OUTER JOIN CONFORMED.HCC_HA_PLAF s ON p.matnr = s.matnr 
				AND p.werks = s.plwrk 
				AND q.lifnr = s.flief 
				AND p.qunum = s.qunum 
			 LEFT OUTER JOIN CONFORMED.HCC_HA_RDPR t ON p.werks = t.werks 
				AND q.rdprf = t.rdprf 
         WHERE 
			q.lifnr IS NOT NULL
        ) query2 
    WHERE 
	    query2.rownum = 1
    ) a
) a;
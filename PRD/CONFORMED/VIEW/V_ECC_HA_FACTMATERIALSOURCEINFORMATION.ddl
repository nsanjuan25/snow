create or replace view V_ECC_HA_FACTMATERIALSOURCEINFORMATION(
	DATASOURCEKEY,
	SITECODE,
	SITEPARTCODE,
	SUPPLIERCORPORATIONDSCODE,
	SITEPARTSOURCETYPECODE,
	SITEPARTSOURCEINFORMATIONREFERENCE,
	PURCHASINGORGANIZATIONCODE,
	FIXEDLEADTIME,
	CANCELLATIONLEADTIME,
	YIELD,
	ORDERUNITOFMEASUREDSCODE,
	MAXIMUMLOTSIZE,
	MINIMUMLOTSIZE,
	MULTIPLEQTY,
	AMLREFERENCE,
	MFRCORPORATIONDSCODE,
	SUPPLIERPARTCODE,
	CURRENCYCODE,
	PRICEUNIT,
	UNITPRICECURRENT,
	UNITPRICEFUTURE,
	UNITPRICEFUTUREEFFECTIVEFROMDATE,
	UNITPRICEFUTUREEFFECTIVETODATE,
	DSCREATEUSER,
	DSCREATEDTS,
	DELETEFLAG,
	CORPORATIONDSTYPECODE,
	BASEUNITOFMEASURE,
	SHIPPINGINSTRUCTIONS,
	INCOTERMS1,
	INCOTERMS2,
	NODAYSREMINDER1,
	NODAYSREMINDER2,
	CERTIFICATEORIGIN,
	RETURNAGREEMENT,
	UPDATED_ON
) as
/*--------------------------------------------------------------------

This view is used in SAP.FactMaterialSourceInformation
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-03      Noel San Juan          Initial Revision
*/
SELECT
    1                         as DataSourceKey,
	ifnull(eina_res.werks,'') as SiteCode, 
	ifnull(eina_res.matnr,'') as SitePartCode, 
	ifnull(eina_res.lifnr,'') as SupplierCorporationDSCode, 
	ifnull(eina_res.esokz,'') as SitePartSourceTypeCode, 
	ifnull(eina_res.infnr,'') as SitePartSourceInformationReference, 
	ifnull(eina_res.ekorg,'') as PurchasingOrganizationCode, 
	ifnull(eina_res.aplfz,0)  as FixedLeadTime, 
	ifnull(eina_res.mahn3,0)  as CancellationLeadTime, 
	0					      as Yield, 
	ifnull(eina_res.bprme,'') as OrderUnitOfMeasureDSCode, 
	ifnull(eina_res.Bstma,0) as MaximumLotSize, 
	ifnull(eina_res.Minbm,0) as MinimumLotSize, 
	ifnull(eina_res.norbm,0) as MultipleQty, 
	0					      as AMLReference, 
	ifnull(eina_res.Mfrnr,'') as MfrCorporationDSCode, 
	ifnull(eina_res.Idnlf,'') as SupplierPartCode, 
	--if(isnull(pricing.konp_konwa),eina_res.waers, pricing.konp_konwa) as CurrencyCode, 
	ifnull(pricing.konp_konwa,eina_res.waers) as CurrencyCode, 
	--if(isnull(pricing.konp_kpein),eina_res.peinh, pricing.konp_kpein) as PriceUnit, 
	ifnull(pricing.konp_kpein,eina_res.peinh) as PriceUnit,
	--case when ( if(isnull(pricing.konp_konwa),eina_res.waers, pricing.konp_konwa) = if(isnull(pricing.tcurx_currkey),eina_res.currkey, pricing.tcurx_currkey) ) 
	--		then ( if(isnull(pricing.konp_kbetr),eina_res.netpr, pricing.konp_kbetr) ) * power(10, (2 - (if(isnull(pricing.tcurx_currdec),eina_res.currdec, pricing.tcurx_currdec)) )) 
	--		else if(isnull(pricing.konp_kbetr),eina_res.netpr, pricing.konp_kbetr) 
	--		end as UnitPriceCurrent, 
	case 
		when ( ifnull(pricing.konp_konwa,eina_res.waers) = ifnull(pricing.tcurx_currkey,eina_res.currkey) ) 
			then ( ifnull(pricing.konp_kbetr,eina_res.netpr) ) * power(10, (2 - (ifnull(pricing.tcurx_currdec,eina_res.currdec)) )) 
		else ifnull(pricing.konp_kbetr,eina_res.netpr) 
	end as UnitPriceCurrent, 
	case 
		when ( ifnull(pricing.konp_konwa,eina_res.waers) = ifnull(pricing.tcurx_currkey,eina_res.currkey) ) 
			then ifnull(pricing.KONP_Kbetr_future,eina_res.effpr) * power(10, (2 - (ifnull(pricing.tcurx_currdec,eina_res.currdec)) )) 
		else ifnull(pricing.KONP_Kbetr_future,eina_res.effpr) 
	end as UnitPriceFuture, 
	ifnull(pricing.a017_datab,'00000000') as UnitPriceFutureEffectiveFromDate, 
	ifnull(PRICING.A017_datbI,eina_res.prdat) as UnitPriceFutureEffectiveToDate, 
	eina_res.Ernam as DSCreateUser, 
	eina_res.Erdat as DSCreateDTS,     
	--if(eina_res.eina_loekz is not null and length(trim(eina_res.eina_loekz))>0, eina_res.eina_loekz, eina_res.eine_loekz) as DeleteFlag, 
	case 
		when eina_res.eina_loekz is not null and length(trim(eina_res.eina_loekz))>0 then eina_res.eina_loekz
		else eina_res.eine_loekz
	end as DeleteFlag,
	ifnull(Lfa1.Ktokk,'') as CorporationDSTypeCode, 
	ifnull(eina_res.Lmein,'') as BaseUnitOfMeasure, 
	ifnull(eina_res.Evers,'') as ShippingInstructions, 
	ifnull(eina_res.inco1,'') as IncoTerms1, 
	ifnull(eina_res.inco2,'') as IncoTerms2, 
	ifnull(eina_res.mahn1,0) as NoDaysReminder1, 
	ifnull(eina_res.mahn2,0) as NoDaysReminder2, 
	ifnull(eina_res.Urzla,'') as CertificateOrigin, 
	ifnull(eina_res.Rueck,'') as ReturnAgreement, 
	CURRENT_DATE as updated_on 
FROM 
( 
	SELECT 
		eina_eine.* 
    FROM
	( 
		SELECT 
			eine.werks, 
			eina.matnr, 
			eina.lifnr, 
			eine.esokz, 
			eine.infnr, 
			eine.ekorg, 
			eine.aplfz, 
			eina.mahn3, 
			eine.bprme, 
			eine.Bstma, 
			eine.Minbm, 
			eine.norbm, 
			eina.Mfrnr, 
			eina.Idnlf, 
			eina.Lmein, 
			eina.mahn1, 
			eina.mahn2, 
			eina.Urzla, 
			eina.Rueck, 
			eina.loekz as eina_loekz, 
			eine.waers, 
			eine.peinh, 
			eine.netpr, 
			eine.effpr, 
			eine.prdat, 
			eine.Ernam, 
			eine.Erdat, 
			eine.loekz as eine_loekz, 
			eine.Evers, 
			eine.inco1, 
			eine.inco2, 
			tcurx.currkey, 
			tcurx.currdec, 
			row_number() over 
			(
				partition by  
					eine.werks,
					eina.matnr,
					eina.lifnr,
					eine.esokz,
					eine.ekorg 
				order by 
					eina.loekz,
					eine.loekz asc,
					eine.Erdat desc
			) as rownum 
			FROM 
				CONFORMED.ECC_HA_EINE EINE 
				LEFT JOIN CONFORMED.ECC_HA_EINA EINA ON eine.infnr = EINA.infnr 
				LEFT JOIN CONFORMED.ECC_HA_TCURX tcurx ON eine.waers = tcurx.currkey 
			WHERE 
				eina.matnr IS NOT NULL
				and ifnull(eina.matnr,'') <> '' 
				
	) as eina_eine 
	WHERE 
		eina_eine.rownum = 1 
) as eina_res 
LEFT JOIN CONFORMED.ECC_HA_LFA1 LFA1 ON EINA_res.LIFNR = LFA1.LIFNR 
LEFT JOIN
( --> Comment convert the 2 rows to columns using MAX and Group BY 
	SELECT 
		a017_knop.a017_lifnr,
		a017_knop.a017_matnr,
		a017_knop.a017_ekorg,
		a017_knop.a017_werks,
		a017_knop.a017_esokz,
		MAX( CASE WHEN a017_knop.rownum2 = 1 THEN a017_knop.konp_kbetr END ) konp_kbetr,
		MAX( CASE WHEN a017_knop.rownum2 = 1 THEN a017_knop.konp_konwa END ) konp_konwa,
		MAX( CASE WHEN a017_knop.rownum2 = 1 THEN a017_knop.konp_kpein END ) konp_kpein,
		MAX( CASE WHEN a017_knop.rownum2 = 2 THEN a017_knop.konp_kbetr END ) konp_kbetr_future,
		MAX( CASE WHEN a017_knop.rownum2 = 2 THEN a017_knop.a017_datab END ) a017_datab,
		MAX( CASE WHEN a017_knop.rownum2 = 2 THEN a017_knop.a017_datbi END ) a017_datbi,
		a017_knop.tcurx_currkey,
		a017_knop.tcurx_currdec 
	FROM
	( 
		SELECT 
			a017.lifnr as a017_lifnr, 
			a017.matnr as a017_matnr, 
			a017.ekorg as a017_ekorg, 
			a017.werks as a017_werks, 
			a017.esokz as a017_esokz, 
			konp.kbetr as konp_kbetr, 
			konp.konwa as konp_konwa, 
			konp.kpein as konp_kpein, 
			a017.datab as a017_datab, 
			a017.datbi as a017_datbi, 
			tcurx.currkey as tcurx_currkey, 
			tcurx.currdec as tcurx_currdec, 
			ROW_NUMBER() OVER 
			(
				partition by 
					konp.knumh 
				order by 
					konp.knumh asc,
					konp.kopos desc
			) as rownum, 
			ROW_NUMBER() OVER 
			(
				partition by 
					A017.WERKS,
					A017.MATNR,
					A017.LIFNR,
					A017.ESOKZ 
				order by A017.DATAB
			) as rownum2 
			--> Comment use 2 row_number, first to get unique row from KONP 
			--> Comment second to get the 2 records from A017 
		FROM 
			CONFORMED.ECC_HA_A017 A017 
			INNER JOIN CONFORMED.ECC_HA_KONP KONP ON A017.knumh = konp.knumh 
				AND A017.kappl = konp.kappl 
				AND A017.Kschl = konp.kschl 
				AND A017.kappl = 'M'
				AND A017.knumh > '0' 
				AND ifnull(konp.loevm_ko,'') = ''  --> comment Is initial 
			LEFT JOIN CONFORMED.ECC_HA_TCURX tcurx ON konp.konwa = tcurx.currkey 
		WHERE 
			A017.DATBI >= replace(current_date,'-','')   --> Comment THAN CURRENT DATE 
	) a017_knop 
	WHERE
		a017_knop.rownum = 1        --> comment Get correct row from KONP 
		AND a017_knop.rownum2 <= 2  --> comment Get only current and future row 
	GROUP BY
		a017_knop.a017_lifnr,
		a017_knop.a017_matnr,
		a017_knop.a017_ekorg,
		a017_knop.a017_werks, 
		a017_knop.a017_esokz, 
		a017_knop.tcurx_currkey,
		a017_knop.tcurx_currdec 
	) as pricing ON 
		eina_res.Werks  = pricing.a017_werks
		AND eina_res.Matnr  = pricing.a017_matnr 
		AND eina_res.Lifnr  = pricing.a017_lifnr 
		AND eina_res.ekorg  = pricing.a017_ekorg 
		AND eina_res.Esokz  = pricing.a017_esokz;
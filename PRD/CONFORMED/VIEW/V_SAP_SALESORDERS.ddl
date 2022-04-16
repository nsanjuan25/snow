create or replace view V_SAP_SALESORDERS(
	DATASOURCEKEY,
	CUSTOMER,
	EFFECTIVEFROMDATE,
	EFFECTIVETODATE,
	REQUESTDELIVERYDATE,
	RECEIPTDATE,
	PLANT,
	MATERIAL,
	SALESDOCUMENTTYPE,
	SALESDOCUMENTCATEGORY,
	SALESITEMTYPE,
	SALESITEMCATEGORY,
	SPECIALSTOCKS,
	SALESDOCUMENTNUMBER,
	SALESDOCUMENTITEM,
	COMPANYORGANIZATIONCODE,
	SALESORGANIZATIONCODE,
	CUSTOMERORDERNUMBER,
	REJECTIONFLAG,
	DELIVERYBLOCKINDICATOR,
	DSCREATEDTIME,
	DSCREATEDBY,
	DSCREATEDONDATE,
	DSLASTCHANGEDDATE,
	DSITEMCREATEDONDATE,
	DSITEMLASTCHANGEDDATE,
	CUSTOMERPURCHASEORDERDATE,
	ROUTE,
	NCFLAG,
	DESTINATIONCODE,
	PRIORITY,
	COUNTRYCODE,
	CUSTOMERORDERTYPE,
	SHIPPINGTYPE,
	TOTALNETVALUE,
	NETVALUE,
	UNITPRICE,
	PRICEUNIT,
	TARGETQUANTITY,
	CUMULATIVEORDERQUANTITY,
	CUMULATIVEOPENQUANTITY,
	CUMULATIVECONFIRMEDQUANTITY,
	ADDRESSCODE,
	ISHPVENRAY,
	REQUIREMENTDATE,
	UPDATED_ON_VBAK,
	UPDATED_ON_VBAP,
	UPDATED_ON_VBKD,
	UPDATED_ON_ATTR,
	UPDATED_ON_VBPA,
	UPDATED_ON_VBEP,
	WCS_ORDERDATE,
	WCS_ORDERNUMBER,
	WCS_ORDERLINENUMBER,
	CUSTOMERMATERIAL,
	CUSTOMERMATERIALDESCRIPTION,
	PO_LINENUMBER,
	SALESUNITSORDERQTY,
	CONFIRMEDQTY,
	MATERIALSTAGINGDATE,
	SALESORDERCOMPLETEDELIVERY,
	STATUS,
	SHIPSERVICELEVEL,
	DESIGNID,
	BILLTOADDRESSCODE,
	UPDATED_ON_STXL_OL,
	UPDATED_ON_STXL_SSL,
	UPDATED_ON_ATTR_D,
	UPDATED_ON_LIPS,
	UPDATED_ON_VBUK,
	ORDERQTY,
	CONFIRMEDSHIPDATE,
	DELIVERY,
	BILLOFLANDING,
	ACTUALDELIVEREDQTY,
	GOODSMOVEMENTDATE,
	CARRIER,
	TRACEABILITYNUMBER,
	INVOICENUMBER,
	DUEDATE,
	DELIVERYSTATUS,
	DOCUMENTDATE,
	MANDT,
	OBKNR
) as
/*--------------------------------------------------------------------

This view is used to ADD data into CONFORMED.SAP_SALESORDERS table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision	
2022-01-21      Noel San Juan          use LIKP to get BOLNR-Tracking Number	
*/
SELECT
    1                                               AS DataSourceKey,
	VBAP.MATKL                                      AS Customer,
	VBAK.ANGDT                                      AS EffectiveFromDate,
	VBAK.BNDDT                                      AS EffectiveToDate,
	VBAK.VDATU                                      AS RequestDeliveryDate,
	IFNULL(VBKD.BSTDK,IFNULL(VBKD_2.BSTDK,'00000000')) AS ReceiptDate,
	VBAP.WERKS                                      AS Plant,
	VBAP.MATNR                                      AS Material,
	VBAK.AUART                                      AS SalesDocumentType,
	VBAK.VBTYP                                      AS SalesDocumentCategory,
	VBAP.POSAR                                      AS SalesItemType,
	VBAP.PSTYV                                      AS SalesItemCategory,
	VBAP.SOBKZ                                      AS SpecialStocks,
	VBAK.VBELN                                      AS SalesDocumentNumber,
	VBAP.POSNR                                      AS SalesDocumentItem,
	VBAK.BUKRS_VF                                   AS CompanyOrganizationCode,
	VBAK.VKORG                                      AS SalesOrganizationCode,
	IFNULL(VBKD.BSTKD,IFNULL(VBKD_2.BSTKD, ''))     AS CustomerOrderNumber,
	VBAP.ABGRU                                      AS RejectionFlag,
	VBAK.LIFSK                                      AS DeliveryBlockIndicator,
	VBAK.ERZET                                      AS DSCreatedTime,
	VBAK.ERNAM                                      AS DSCreatedBy,
	VBAK.ERDAT                                      AS DSCreatedOnDate,
	VBAK.AEDAT                                      AS DSLastChangedDate,
	VBAP.ERDAT                                      AS DSItemCreatedOnDate,
	VBAP.AEDAT                                      AS DSItemLastChangedDate,
	IFNULL(VBKD.BSTDK, IFNULL(VBKD_2.BSTDK,'00000000')) AS CustomerPurchaseOrderDate,
	VBAP.ROUTE                                      AS Route,
	VBAP.MVGR4                                      AS NCFlag,
	ATTR.Plant_No									AS DestinationCode,
	ATTR.Priority									AS Priority,
	''												AS CountryCode,			-- will be updated
	IFNULL(VBKD.BSARK_E ,IFNULL(VBKD_2.BSARK_E,'')) AS CustomerOrderType,
	IFNULL(VBKD.VSART,IFNULL(VBKD_2.VSART,''))		AS ShippingType,
	VBAK.NETWR                                      AS TotalNetValue,
	VBAP.NETWR                                      AS NetValue,
	VBAP.NETPR                                      AS UnitPrice,
	VBAP.KPEIN                                      AS PriceUnit,
	VBAP.ZMENG                                      AS TargetQuantity,
	VBAP.KWMENG                                     AS CumulativeOrderQuantity,
	VBAP.KBMENG                                     AS CumulativeOpenQuantity,
	VBAP.KLMENG                                     AS CumulativeConfirmedQuantity,
	''												AS AddressCode,			-- will be updated
	0									            AS IsHPVenray,
	'19990101'							            AS RequirementDate,		-- will be updated
	IFNULL(VBAK.UPDATEDON,'2000-01-01')				AS updated_on_VBAK,
	IFNULL(VBAP.UPDATEDON,'2000-01-01')				AS updated_on_VBAP,
	IFNULL(VBKD.UPDATEDON,'2000-01-01')				AS updated_on_VBKD,
	IFNULL(ATTR.updated_on,'2000-01-01')			AS updated_on_ATTR,
	'2000-01-01'									AS updated_on_VBPA,		-- will be updated
	'1999-01-01'									AS updated_on_VBEP,		-- will be updated
	VBKD.BSTDK_E						            AS WCS_OrderDate,
	VBKD.BSTKD_E						            AS WCS_OrderNumber,
	IFNULL(STXL_OL.sdata, '')			            AS WCS_OrderLineNumber,
	VBAP.KDMAT		                                AS CustomerMaterial,
	VBAP.ARKTX		                                AS CustomerMaterialDescription,
	VBAP.POSEX		                                AS PO_LineNumber,
	0												AS SalesUnitsOrderQty,		-- will be updated
	0												AS ConfirmedQty,			-- will be updated
	'19990101'										AS MaterialStagingDate,		-- will be updated
	VBAK.AUTLF		                                AS SalesOrderCompleteDelivery,
	CASE 
		WHEN IFNULL(VBFA1.VBELV, '') = '' THEN  'Open'
		WHEN VBFA1.VBTYP_N  = 'R' THEN 'Closed'
		ELSE 'Open'
	 END										    AS Status,
	IFNULL(STXL_SSL.sdata, '')					    AS ShipServiceLevel,
	IFNULL(ATTR_D.attribute_value, '')				AS DesignID,
	''											    AS BillToAddressCode,	-- will be updated
	IFNULL(STXL_OL.SNFLK_UPDATEDON,'2000-01-01')	AS updated_on_STXL_OL,
	IFNULL(STXL_SSL.SNFLK_UPDATEDON,'2000-01-01')	AS updated_on_STXL_SSL,
	IFNULL(ATTR_D.SNFLK_UPDATEDON,'2000-01-01')		AS updated_on_ATTR_D,
	IFNULL(LIPS.UPDATEDON,'2000-01-01')				AS updated_on_LIPS,
	IFNULL(VBUK.SNFLK_UPDATEDON,'2000-01-01')		AS updated_on_VBUK,
	0												AS OrderQty,			-- will be updated
	'19990101'										AS ConfirmedShipDate,	-- will be updated
	LIPS.VBELN		                                AS Delivery,
	IFNULL(LIPS.BOLNR2,right(LIPS.BOLNR,35)::varchar)AS BillOfLanding,
	LIPS.LFIMG		                                AS ActualDeliveredQty,
	LIPS.WADAT_IST                                  AS GoodsMovementDate,
	''												AS Carrier,				-- will be updated
	''												AS TraceabilityNumber,  -- will be updated
	VBFA.VBELN		                                AS InvoiceNumber,
	'1900-01-01'	                                AS DueDate,
	''				                                AS DeliveryStatus,
	VBAK.AUDAT		                                AS DocumentDate,
	VBAK.MANDT										AS MANDT,
	SER06.OBKNR										AS OBKNR
FROM 
	CONFORMED.ECC_HA_VBAK AS VBAK 
	INNER JOIN CONFORMED.ECC_HA_VBAP AS VBAP ON VBAK.MANDT = VBAP.MANDT
		AND VBAP.VBELN = VBAK.VBELN
	LEFT OUTER JOIN CONFORMED.ECC_HA_VBKD VBKD ON VBKD.MANDT = VBAK.MANDT
        AND VBAK.VBELN = VBKD.VBELN
        AND VBAP.POSNR = VBKD.POSNR
    LEFT OUTER JOIN 
    (
        SELECT  
            V.VBELN,
            V.BSTDK,
            V.BSTKD,
            V.BSARK_E,
            V.VSART,
            row_number() OVER
			(
				PARTITION BY 
					V.VBELN  
				ORDER BY 
					V.POSNR
			) AS RN
        FROM
            CONFORMED.ECC_HA_VBKD V
    ) VBKD_2 ON VBKD_2.VBELN = VBAK.VBELN
        AND VBKD_2.RN = 1    
	LEFT OUTER JOIN 
	(
        SELECT
            att.objectid  AS vbeln,
            att.MANDT,
            IFNULL(MAX(CASE WHEN att.field_name = 'DELIVERY_PRIORITY' THEN att.attribute_value END),'') AS Priority,
            IFNULL(MAX(CASE WHEN att.field_name = 'DESTINATION_CODE'  THEN att.attribute_value END),'') AS Plant_No,
            IFNULL(MAX(CASE WHEN att.field_name = 'COUNTRY_LABEL'     THEN att.attribute_value END),'') AS CountryCode,
            MIN(ATT.SNFLK_UPDATEDON) AS Updated_On
        FROM
            CONFORMED.ECC_HA_ZMM_GOF_ATTRIBUT att
        WHERE 
            att.objectclas = 'VERKBELEG'
            AND att.field_name IN
            (
                'DELIVERY_PRIORITY',
				'DESTINATION_CODE',
				'COUNTRY_LABEL'
			)
		GROUP BY
			att.objectid,
			att.MANDT
	) ATTR ON  ATTR.MANDT = VBAK.MANDT
        AND VBAK.vbeln = ATTR.vbeln
	LEFT OUTER JOIN   
    (
        SELECT
			VBFA_Int1.vbelv,
            VBFA_Int1.posnv,
            VBFA_Int1.VBTYP_N,
            VBFA_Int1.ERDAT,
            VBFA_Int1.ERZET,
            VBFA_Int1.vbeln,
            ROW_NUMBER() OVER
			(
				PARTITION by 
					VBFA_Int1.vbelv,
					VBFA_Int1.posnv 
				ORDER BY 
					VBFA_Int1.ERDAT DESC,
					VBFA_Int1.ERZET DESC
			) AS RN1
        FROM 
            CONFORMED.BW_HA_VBFA VBFA_Int1
        WHERE                         
            VBFA_Int1.vbtyp_n = 'M'
    ) VBFA ON VBFA.vbelv = VBAP.VBELN
        AND VBFA.posnv = VBAP.POSNR 
        AND VBFA.RN1 = 1  
   
	LEFT OUTER JOIN
	(
		SELECT 
			sdata,
			tdname,
			SNFLK_UPDATEDON
		FROM 
			CONFORMED.BW_HA_STXL STXL
		WHERE
			 tdobject = 'VBBP' 
			 AND tdid = '0004'
			 AND tdspras = 'E'
	) STXL_OL ON STXL_OL.tdname = LPAD(VBAP.VBELN, 10, '0000000000')||LPAD(VBAP.POSNR, 6, '000000')
	LEFT OUTER JOIN
	(
		SELECT 
			sdata,
			tdname,
			SNFLK_UPDATEDON
		FROM 
			CONFORMED.BW_HA_STXL STXL
		WHERE
			tdobject = 'VBBK'
			AND tdid = 'ZOSL'
			AND tdspras = 'E'
	) STXL_SSL ON STXL_SSL.tdname = LPAD(VBAP.VBELN, 10, '0000000000')
	LEFT OUTER JOIN 
    (
        SELECT
            att.objectid,
			att.attribute_value,
			att.SNFLK_UPDATEDON
        FROM
            CONFORMED.ECC_HA_ZMM_GOF_ATTRIBUT att
        WHERE 
            att.objectclas = 'VERKBELEG'
            AND att.field_name = 'DESIGN_ID'
    ) ATTR_D ON ATTR_D.objectid = LPAD(VBAP.VBELN, 10, '0000000000')||LPAD(VBAP.POSNR, 6, '000000')
	LEFT OUTER JOIN 
	(
		SELECT
			lips.vgbel,
			lips.vgpos,
			lips.vbelv,
			lips.posnv,
			lips.vbeln,
			lips.posnr,
			lips.wbstk,
			lips.lfimg,
			lips.bolnr,
			likp.bolnr as bolnr2,	-- added to retrieve data from LIKP
			likp.wadat_ist,
			lips.UPDATEDON,
			ROW_NUMBER() OVER
			(
				PARTITION by 
					lips.vgbel, 
					lips.vgpos 
				ORDER BY 
					lips.vdatu DESC
			) AS RN
		FROM
			CONFORMED.BW_HA_LIPS lips
			INNER JOIN CONFORMED.ECC_HA_LIKP likp on likp.vbeln = lips.vbeln  -- added to get wadat_ist in LIKP
	)LIPS ON LIPS.vgbel = VBAK.vbeln 
		AND LIPS.vgpos = VBAP.posnr
		AND LIPS.RN = 1
	LEFT OUTER JOIN CONFORMED.BW_HA_VBUK VBUK ON VBUK.vbeln = LIPS.vbeln
	LEFT OUTER JOIN --CONFORMED.BW_HA_VEPO VEPO ON VEPO.VBELN = LIPS.VBELN -- code changed to pick up latest VENUM
	(
		SELECT 
			VENUM,
			VBELN,
            POSNR,
			ROW_NUMBER() OVER
			(
				PARTITION BY 
					VBELN,
					POSNR 
				ORDER BY 
					SEQGEN DESC
			) AS RN
		FROM 
			CONFORMED.BW_HA_VEPO
	)VEPO ON VEPO.VBELN = LIPS.VBELN
		 AND VEPO.POSNR = LIPS.POSNR
		 AND VEPO.RN = 1
		 AND VBAP.PSTYV = 'ZTA1'		
	--LEFT OUTER JOIN CONFORMED.BW_HA_SER06 AS SER06 ON SER06.VENUM = VEPO.VENUM 
	LEFT OUTER JOIN 
    (
        SELECT
            VENUM,
            OBKNR,
            row_number() OVER
            (
                PARTITION BY 
                    VENUM
                ORDER BY 
                    SEQGEN desc
            ) AS RN
        FROM
            CONFORMED.BW_HA_SER06
    ) SER06 ON SER06.VENUM = VEPO.VENUM
         AND SER06.RN = 1
	LEFT OUTER JOIN   
    (
        SELECT
			VBFA_Int.vbelv,
            VBFA_Int.posnv,
            VBFA_Int.VBTYP_N,
            VBFA_Int.ERDAT,
            VBFA_Int.ERZET,
            ROW_NUMBER() OVER
			(
				PARTITION by 
					VBFA_Int.vbelv, 
					VBFA_Int.posnv 
				ORDER BY 
					VBFA_Int.ERDAT DESC,
					VBFA_Int.ERZET DESC
			) AS RN
        FROM 
            CONFORMED.BW_HA_VBFA VBFA_Int
        WHERE                         
            VBFA_Int.vbtyp_n in ('R', 'HL')
    ) VBFA1 ON
        VBFA1.vbelv = VBAP.VBELN AND 
        VBFA1.posnv = VBAP.POSNR 
        AND VBFA1.RN = 1;
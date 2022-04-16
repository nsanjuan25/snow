create or replace view V_ECC_HA_PURCHASEITEM(
	DATASOURCEKEY,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	SITEPARTCODE,
	COMPANYCODE,
	SITECODE,
	MFRCORPORATIONDSCODE,
	PURCHASEQUANTITY,
	NUMBEROFINFORECORD,
	RECEIVINGSTORAGELOCATION,
	MFRSITEPARTCODE,
	NETPRICE,
	PRICEUNIT,
	DELIVERYCOMPLETEFLAG,
	CUMULATIVEQUANTITY,
	CUMULATIVEQUANTITYRECONCILEDTS,
	FIRMZONE,
	TRADEOFFZONE,
	PURCHASEITEMCATEGORY,
	ACCOUNTASSIGNMENT,
	NONVALUEDFLAG,
	SHIPPINGINSTRUCTIONS,
	INCOTERMS1,
	INCOTERMS2,
	SPECIALSTOCKSCODE,
	LASTTRANSMISSIONDTS,
	LASTTRANSMISSIONNUMBER,
	MAXIMUMFIRMQUANTITY,
	MAXIMUMTRADEOFFQUANTITY,
	CANCELLATIONLEADTIME,
	DELETEFLAG,
	DSUPDATEDTS,
	ITEMCOMMENT,
	AMLREFERENCE,
	ORDERUNITOFMEASUREDSCODE,
	BASEUNITOFMEASURE,
	POBLOCKED,
	POREMINDER1,
	POREMINDER2,
	CROSSREFDOCNUMBER,
	CROSSREFDOCITEM,
	UPDATED_ON,
	REQUIREMENTNUMBER,
	REQUESTEDBY,
	CUSTOMER,
	PROFITCENTER,
	NETORDERVALUEINPOCURRENCY
) as
/*--------------------------------------------------------------------

This view is used in SAP.FACTPURCHASEORDERS
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-01      Noel San Juan          Initial Revision
*/
SELECT 
	1				      as DataSourceKey,
	IFNULL(ekpo.ebeln,'') as PurchaseDocumentNumber,
	IFNULL(ekpo.ebelp,0)  as PurchaseDocumentItem,
	IFNULL(ekpo.matnr,'') as SitePartCode,
	IFNULL(ekpo.bukrs,'') as CompanyCode,
	IFNULL(ekpo.werks,'') as SiteCode,
	IFNULL(ekpo.mfrnr,'') as MfrCorporationDSCode,
	IFNULL(ekpo.menge,0)  as PurchaseQuantity,
	case
		when IFNULL(ekpo.infnr, '') = '' then eko.infnr
		else ekpo.infnr
	end as NumberOfInfoRecord,
	--if(ekpo.infnr is Null or ekpo.infnr = '',eko.infnr,ekpo.infnr) as NumberOfInfoRecord,
	IFNULL(ekpo.lgort,'') as ReceivingStorageLocation,
	IFNULL(ekpo.mfrpn,'') as MfrSitePartCode,
	case 
		when TCURX.currkey = ekko.waers then ekpo.netpr * power(10, (2 - currdec)) 
		else ekpo.netpr 
	end as NetPrice,
	case
		when ekpo.pstyp='2' then '0'
		else IFNULL(ekpo.peinh,0)
	end as PriceUnit,
	--if(ekpo.pstyp='2','0',ekpo.peinh) as PriceUnit,
	case
		when ekpo.elikz='X' OR ekpo.loekz='S' then 'TRUE'
		else 'FALSE'
	end as DeliveryCompleteFlag,
	--if(ekpo.elikz='X' or ekpo.loekz='S','1','0') as DeliveryCompleteFlag,
	IFNULL(ekpo.abftz,0) as CumulativeQuantity,
    case
        when ekpo.abdat = '00000000' THEN '1900-01-01'
        else to_date(ekpo.abdat, 'YYYYMMDD')
    end as CumulativeQuantityReconcileDTS,
	IFNULL(ekpo.etfz1,0)  as FirmZone,
	IFNULL(ekpo.etfz2,0)  as TradeOffZone,
	IFNULL(ekpo.pstyp,'') as PurchaseItemCategory,
	IFNULL(ekpo.knttp,'') as AccountAssignment,
	case
		when ekpo.weunb='X' then 'TRUE'
		else 'FALSE'
	end as NonValuedFlag,
	--if(ekpo.weunb='X',1,0) as NonValuedFlag,
	IFNULL(ekpo.evers,'') as ShippingInstructions,
	IFNULL(ekpo.inco1,'') as INCOTerms1,
	IFNULL(ekpo.inco2,'') as INCOTerms2,
	case 
		when ekpo.pstyp='2' then 'K'
		when ekpo.pstyp='3' then 'O' 
		Else '' 
	end as SpecialStocksCode,
	cast(cast(ekpo.drdat as int) as String) as LastTransmissionDTS,
	IFNULL(ekpo.Druhr,0) as LastTransmissionNumber,
	IFNULL(ekpo.Ffzhi,0) as MaximumFirmQuantity,
	IFNULL(ekpo.Mfzhi,0) as MaximumTradeOffQuantity,
	IFNULL(ekpo.mahn3,0) as CancellationLeadTime,
	case
		when ekpo.loekz='L' or ekpo.loekz='X' then 'TRUE'
		else 'FALSE'
	end as DeleteFlag,
	--if(ekpo.loekz='L' or ekpo.loekz='X',1,0) as DeleteFlag,
    case
        when ekpo.aedat = '00000000' THEN '1900-01-01'
        else to_date(ekpo.aedat, 'YYYYMMDD')
    end as DSUpdateDTS,
	IFNULL(ekpo.txz01,'') as ItemComment,
	IFNULL(ekpo.ematn,'') as AMLReference,
	IFNULL(ekpo.meins,'') as OrderUnitOfMeasureDSCode,
	IFNULL(ekpo.lmein,'') as BaseUnitOfMeasure,
	case
		when EKPO.loekz='S' then 'TRUE'
		else 'FALSE'
	end as POBlocked,
	--IF(EKPO.loekz='S',1,0) as POBlocked,
	IFNULL(ekpo.mahn1,0) as POReminder1,
	IFNULL(ekpo.mahn2,0) as POReminder2,
	case
		when IFNULL(zz.ebeln1, '') = '' then zz1.ebeln2 
		else zz.ebeln1 
	end as CrossRefDocNumber,
	case 
		when IFNULL(zz.ebelp1, '') = '' then zz1.ebelp2 
		else zz.ebelp1 
	end as CrossRefDocItem,
	current_timestamp as updated_on,
	IFNULL(ekpo.bednr,'') as RequirementNumber,
	IFNULL(ekpo.afnam,'') as RequestedBy,
	IFNULL(ekpo.matkl,'') as Customer,
	IFNULL(ekpo.ko_prctr,'') as ProfitCenter,
	IFNULL(ekpo.netwr,0) as netordervalueinpocurrency
FROM 
	CONFORMED.ECC_HA_EKPO ekpo
	INNER JOIN CONFORMED.ECC_HA_EKKO ekko on ekpo.ebeln = ekko.ebeln
	LEFT JOIN CONFORMED.ECC_HA_TCURX TCURX on ekko.waers = TCURX.currkey
	LEFT OUTER JOIN
	(
		SELECT * 
		FROM
			( 
				SELECT 
					p.ekorg, 
					p.werks, 
					p.esokz, 
					p.infnr, 
					i.matnr,
					i.lifnr, 
					row_number() over 
                    (
                        partition by 
                            i.lifnr,
                            p.ekorg,
                            p.werks,
                            p.esokz,
                            i.matnr 
                        order by 
                            p.erdat desc
                    ) rn
                FROM 
					CONFORMED.ECC_HA_EINE p 
					INNER JOIN CONFORMED.ECC_HA_EINA i on i.infnr = p.infnr 
			) ein
				where ein.rn = 1
	)  eko on ekko.lifnr = eko.lifnr
		and ekko.ekorg = eko.ekorg
		and ekpo.matnr = eko.matnr
		and ekpo.werks = eko.werks
		and ekpo.pstyp = eko.esokz
	LEFT OUTER JOIN CONFORMED.ECC_HA_ZMIMAC_POXREF zz on ekpo.ebeln = zz.ebeln1
		and ekpo.ebelp = zz.ebelp1
	LEFT OUTER JOIN 
	(
		SELECT * 
		FROM 
		(
			SELECT 
				ebeln2, 
				ebelp2, 
				row_number() over 
                (
                    partition by 
                        ebeln2,
                        ebelp2 
                    order by 
                        CHDAT desc
                ) as rownum
			FROM 
				CONFORMED.ECC_HA_ZMIMAC_POXREF
		) as a 
		WHERE 
            rownum=1
	) as zz1 on ekpo.ebeln = zz1.ebeln2
		and ekpo.ebelp = zz1.ebelp2;
create or replace view V_HCC_HA_FACTPURCHASEORDERS(
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	PURCHASEDOCUMENTTYPEKEY,
	PURCHASEDOCUMENTCATEGORYKEY,
	SUPPLIERKEY,
	SUPPLIERPLANTKEY,
	SELLERKEY,
	EFFECTIVEFROMDATEKEY,
	EFFECTIVETODATEKEY,
	PURCHASEORDERCREATEDDATEKEY,
	PUBLISHEDDATEKEY,
	PLANTKEY,
	MATERIALKEY,
	CUMULATIVEQTYRECONCILEDATEKEY,
	PURCHASEITEMCATEGORYKEY,
	SPECIALSTOCKSKEY,
	MANUFACTURERKEY,
	AMLKEY,
	BUYERKEY,
	EXCHANGERATEKEY,
	COMPANYORGANIZATIONCODE,
	PURCHASINGORGANIZATIONCODE,
	CURRENCYCODE,
	DELETEFLAG,
	SISEDIFLAG,
	PURCHASEQUANTITY,
	NETPRICE,
	PRICEUNIT,
	UNITPRICE,
	DELIVERYCOMPLETEFLAG,
	CUMULATIVEQUANTITY,
	ACCOUNTASSIGNMENT,
	NONVALUEDFLAG,
	LASTTRANSMISSIONDATEKEY,
	LASTTRANSMISSIONNUMBER,
	ORDERUNITOFMEASURECODE,
	BASEUNITOFMEASURE,
	PURCHASEORDERBLOCKED,
	NUMBEROFINFORMATIONRECORD,
	UNITPRICEBASEUOM,
	CANCELLATIONLEADTIME,
	PAYMENTTERMKEY,
	FIRMZONE,
	TRADEOFFZONE,
	DUNSNUMBER,
	CONDITIONRECORD,
	PROCEDURERECORD,
	INCOTERMS1,
	INCOTERMS2,
	ITEMCOMMENT,
	RECEIVINGSTORAGELOCATION,
	MATERIALGROUP,
	PROFITCENTER,
	NETORDER,
	EXCHANGERATE,
	PROFITCENTER2,
	POREMINDER1,
	POREMINDER2,
	MANUFACTURERPARTKEY
) as
SELECT
	  PurchaseDocumentNumber
    , PurchaseDocumentItem
    , ifnull( PURCHASEDOCUMENTTYPEKEY , 0 ) PURCHASEDOCUMENTTYPEKEY 
	, ifnull(PURCHASEDOCUMENTCATEGORYKEY, 0 ) as PURCHASEDOCUMENTCATEGORYKEY
	, ifnull(SUPPLIERKEY ,0) as SUPPLIERKEY
	, ifnull(Sp.PlantKey,0) as SUPPLIERPLANTKEY 
	, ifnull(SELLERKEY , 0 ) AS SELLERKEY
	, pos.EFFECTIVEFROMDATEKEY
	, pos.EFFECTIVETODATEKEY 
	, pos.PURCHASEORDERCREATEDDATEKEY
	, pos.PUBLISHEDDATEKEY
	, ifnull( P.PLANTKEY , 0 ) as PLANTKEY 
	, ifnull( PP.MATERIALKEY , 0 ) as MATERIALKEY 
	, pos.CUMULATIVEQTYRECONCILEDATEKEY
	, ifnull( PURCHASEITEMCATEGORYKEY , 0  ) PURCHASEITEMCATEGORYKEY
	, ifnull( SPECIALSTOCKSKEY , 0 ) SPECIALSTOCKSKEY
	, ifnull(M.MANUFACTURERKEY , 0 ) As MANUFACTURERKEY
	, ifnull(AML.AMLKEY ,0) as AMLKEY
	, ifnull(B.BUYERKEY,0) as BUYERKEY
	, ifnull( DER.EXCHANGERATEKEY , 0) as EXCHANGERATEKEY
    , pos.COMPANYORGANIZATIONCODE
    , pos.PURCHASINGORGANIZATIONCODE
    , pos.CURRENCYCODE
    , pos.DELETEFLAG 
    , 'FALSE' as SISEDIFLAG --, iff( E.rcvprn is null , 'FALSE', 'TRUE' ) as SISEDIFLAG 
    , pos.PURCHASEQUANTITY
    , ( pos.NETPRICE *  ifnull(DCDP.ExponentFactor , 1 ) ) as NETPRICE
    , case when pos.PRICEUNIT = 0  then 1 else pos.PRICEUNIT end as PRICEUNIT
    , case when pos.PRICEUNIT = 0  then 0 else ( pos.NetPrice / pos.PriceUnit ) *  ifnull(DCDP.ExponentFactor , 1 ) END UnitPrice
    , pos.DELIVERYCOMPLETEFLAG
    , pos.CUMULATIVEQUANTITY 
    , pos.ACCOUNTASSIGNMENT 
    , pos.NONVALUEDFLAG 
    , LASTTRANSMISSIONDATEKEY
    , LASTTRANSMISSIONNUMBER 
    , pos.ORDERUNITOFMEASURECODE   
    , pos.BASEUNITOFMEASURE 
    , pos.PURCHASEORDERBLOCKED

    , pos.NUMBEROFINFORMATIONRECORD    
    , IFNULL(   CAST(pos.NetPrice AS DECIMAL(18,6) )  / NULLIF(MM.AlternatetoBaseConversionRate,0) , pos.NetPrice )   UNITPRICEBASEUOM -- UNITPRICEBASEUOM    
    --, IFNULL(   CAST(pos.NetPrice AS DECIMAL(18,6) )  / NULLIF(MM.AlternatetoBaseConversionRate,0) , cast(pos.NetPrice as decimal(18,6) ))   UNITPRICEBASEUOM -- UNITPRICEBASEUOM    
    , pos.CANCELLATIONLEADTIME
    , ifnull( DPT.PAYMENTTERMKEY , 0 ) As PAYMENTTERMKEY
    , pos.FIRMZONE 
    , pos.TRADEOFFZONE
    , '' as DUNSNUMBER      -- duns number was hardcoded in APS as empty
    , pos.CONDITIONRECORD
    , pos.PROCEDURERECORD
    , pos.INCOTERMS1        
    , pos.INCOTERMS2
    , pos.ITEMCOMMENT
    , pos.RECEIVINGSTORAGELOCATION
    , pos.MATERIALGROUP
    , pos.PROFITCENTER
    
    , pos.NETORDER 
    , pos.EXCHANGERATE
    , '' as PROFITCENTER2    --**** missing tables for PROFITCENTER2 this should be added in coupa project
    , pos.POReminder1
    , pos.POReminder2
    , IFNULL(AML.ManufacturerPartKey, 0 ) AS ManufacturerPartKey

FROM
    (
      SELECT 
      --Header
          ifnull(ekko.ebeln,'') as PurchaseDocumentNumber,
          ifnull(ekko.bsart,'') as PurchaseDocumentTypeCode,
          ifnull(ekko.bstyp,'') as PurchaseDocumentCategoryCode,
          ifnull(ekko.bukrs,'') as CompanyOrganizationCode,
          ifnull(ekko.ekorg,'') as PurchasingOrganizationCode,
          ifnull(ekko.lifnr,'') as SupplierCorporationDSCode,
          ifnull(ekko.zterm,'') as PaymentTerms,
          IFNULL ( TRY_TO_DATE( ekko.kdatb, 'YYYYMMDD' ), '1900-01-01')    as EFFECTIVEFROMDATEKEY,
          IFNULL ( TRY_TO_DATE( ekko.kdate, 'YYYYMMDD' ), '1900-01-01')    as EFFECTIVETODATEKEY,
          ifnull(ekko.verkf,'') as SupplierContact,
          ifnull(ekko.telf1,'') as SupplierPhoneNumber,
          ifnull(ekko.reswk,'') as SupplierSiteCode,
          ifnull(ekko.knumv,'') as ConditionRecord,
          ifnull(ekko.kalsm,'') as ProcedureRecord,
          ifnull(ekko.inco1,'') as INCOTERMS1,
          ifnull(ekko.inco2,'') as INCOTERMS2,
          ifnull(ekko.ekgrp,'') as BuyerCode,
          ifnull(ekko.waers,'') as CurrencyCode,
          ifnull(ekko.wkurs,1) as ExchangeRate,
          iff(ekko.loekz is NULL or ekko.loekz='', 0 , 1 ) as  HeaderDeleteFlag,
          ifnull(ekko.ernam,'') as DSCreateUser,
          IFNULL ( TRY_TO_DATE( ekko.aedat, 'YYYYMMDD' ), '1900-01-01')    as PURCHASEORDERCREATEDDATEKEY,
          IFNULL ( TRY_TO_DATE( ekko.bedat, 'YYYYMMDD' ), '1900-01-01')    as PUBLISHEDDATEKEY ,
      --Detail
        ifnull( try_to_number(ekpo.ebelp ) , 0 )  as PurchaseDocumentItem,
        ifnull(trim(ekpo.matnr),'') as SitePartCode,
        ifnull(ekpo.bukrs, '') as CompanyCode,
        ifnull(ekpo.werks, '') as SiteCode,
        ifnull(ekpo.mfrnr,'') as MfrCorporationDSCode,
        ifnull(ekpo.menge, 0)  as PurchaseQuantity,
        iff(ekpo.infnr is Null or ekpo.infnr = '', ifnull(eko.infnr,''),ekpo.infnr) as NUMBEROFINFORMATIONRECORD,
        ifnull(ekpo.lgort,'') as ReceivingStorageLocation,
        ifnull(ekpo.mfrpn,'') as MfrSitePartCode,
        ifnull( case when TCURX.currkey = ekko.waers then ekpo.netpr * power(10, (2 - currdec)) else ekpo.netpr end, 0)  as NetPrice,
        iff(ekpo.pstyp='2','0',ifnull(ekpo.peinh,0) ) as PriceUnit,
        iff(ekpo.elikz='X' or ekpo.loekz='S','1','0') as DeliveryCompleteFlag,
        ifnull(ekpo.abftz,0) as CumulativeQuantity,
        IFNULL ( TRY_TO_DATE( ekpo.abdat, 'YYYYMMDD' ), '1900-01-01') as CUMULATIVEQTYRECONCILEDATEKEY,
        ifnull(ekpo.etfz1,0) as FirmZone,
        ifnull(ekpo.etfz2,0) as TradeOffZone,
        ifnull(ekpo.pstyp,'') as PurchaseItemCategory,
        ifnull(ekpo.knttp,'') as AccountAssignment,
        iff(ekpo.weunb='X',1,0) as NonValuedFlag,
        ifnull(ekpo.evers,'') as ShippingInstructions,
        ifnull(ekpo.inco1,'') as itemINCOTerms1,
        ifnull(ekpo.inco2,'') as itemINCOTerms2,
        case when ekpo.pstyp='2' then 'K' when ekpo.pstyp='3' then 'O' Else '' end as SpecialStocksCode,
        IFNULL ( TRY_TO_DATE( ekpo.drdat, 'YYYYMMDD' ), '1900-01-01') as LASTTRANSMISSIONDATEKEY,
        ifnull(try_to_number(ekpo.Druhr), 0) as LastTransmissionNumber,
        ifnull(ekpo.Ffzhi,0) as MaximumFirmQuantity,
        ifnull(ekpo.Mfzhi,0) as MaximumTradeOffQuantity,
        ifnull(ekpo.mahn3,0) as CancellationLeadTime,
        iff(ekpo.loekz='L' or ekpo.loekz='X',1,0) as DeleteFlag,
        IFNULL ( TRY_TO_DATE( ekpo.aedat, 'YYYYMMDD' ), '1900-01-01') as DSUpdateDTS,

        ifnull(ekpo.txz01,'') as ItemComment,
        ifnull(ekpo.ematn,'') as AMLReference,
        ifnull(ekpo.meins,'') as ORDERUNITOFMEASURECODE,
        ifnull(ekpo.lmein,'') as BaseUnitOfMeasure,
        Iff(EKPO.loekz='S',1,0) as PurchaseOrderBlocked,
        ifnull(ekpo.mahn1,0) as POReminder1,
        ifnull(ekpo.mahn2,0) as POReminder2,
        //ifnull(case when zz.ebeln1 is null or zz.ebeln1='' then zz1.ebeln2 else zz.ebeln1 end,'') as CrossRefDocNumber,
        //ifnull(case when zz.ebelp1 is null or zz.ebelp1='' then zz1.ebelp2 else zz.ebelp1 end,'') as CrossRefDocItem,
        '' CrossRefDocNumber,
        '' CrossRefDocItem,      
        ifnull(ekpo.bednr,'') as RequirementNumber,
        ifnull(ekpo.afnam,'') as RequestedBy,
        ifnull(ekpo.matkl,'') as MATERIALGROUP,
        ifnull(ekpo.ko_prctr,'') as ProfitCenter,
        ifnull(ekpo.netwr,0) as NETORDER      
      FROM
          conformed.hcc_ha_ekko ekko
          INNER JOIN conformed.hcc_ha_ekpo ekpo 
              on ekpo.ebeln = ekko.ebeln 
          LEFT OUTER JOIN
              (
                  Select * 
                  from 
                      (
                          Select 
                              p.ekorg, p.werks , p.esokz , p.infnr , i.matnr ,i.lifnr , 
                              row_number() over (partition by i.lifnr,p.ekorg,p.werks,p.esokz,i.matnr order by p.erdat desc) rn
                          from 
                              conformed.hcc_ha_eine p 
                              inner join conformed.hcc_ha_eina i
                              on i.infnr = p.infnr ) ein
                          where ein.rn = 1 
              )  eko
              on ekko.lifnr = eko.lifnr
              and ekko.ekorg = eko.ekorg
              and ekpo.matnr = eko.matnr
              and ekpo.werks = eko.werks
              and ekpo.pstyp = eko.esokz
          LEFT JOIN conformed.hcc_ha_tcurx TCURX 
              on ekko.waers = TCURX.currkey        

        /*
          LEFT OUTER JOIN conformed.hcc_ha_zmimac_poxref zz
              on ekpo.ebeln = zz.ebeln1
              and ekpo.ebelp = zz.ebelp1

          LEFT OUTER JOIN  
              (
                  select * from 
                  (
                      SELECT 
                          ebeln2, ebelp2, row_number() over (partition by ebeln2, ebelp2 order by CHDAT desc) as rownum
                      from 
                          conformed.hcc_ha_zmimac_poxref
                  ) as a where rownum=1
              ) as zz1
            on ekpo.ebeln = zz1.ebeln2
            and ekpo.ebelp = zz1.ebelp2  
      */
    )pos
    
    
    LEFT OUTER JOIN sap.DimPurchaseDocumentTypes dt
      ON trim(pos.PurchaseDocumentTypeCode) = dt.PurchaseDocumentTypeCode
      AND dt.DataSourceKey = 2
      
    LEFT OUTER JOIN SAP.DimPurchaseDocumentCategories dc 
        ON TRIM(pos.PurchaseDocumentCategoryCode) = dc.PurchaseDocumentCategoryCode
        AND dc.DataSourceKey = 2
        
    LEFT OUTER JOIN 
        (	
            SELECT 
                  *	
                , ROW_NUMBER() OVER ( PARTITION BY DS.SupplierCode, DS.DataSourceKey ORDER BY DS.deleteflag DESC,DS.SupplierKey ASC ) rn
            FROM 
                sap.DimSuppliers DS                        
        ) s 
            ON TRIM(pos.SupplierCorporationDSCode) = s.SupplierCode
            AND S.DataSourceKey = 2
			AND s.rn = 1
            
    LEFT OUTER JOIN sap.DimPlants Sp ON TRIM(pos.SupplierSiteCode) = Sp.PlantCode
                AND SP.DataSourceKey = 2

    LEFT OUTER JOIN sap.DimPlants P ON TRIM(pos.SiteCode) = P.PlantCode
        AND P.DataSourceKey = 2

    LEFT OUTER JOIN sap.DimMaterials PP 
        ON  TRIM(pos.sitepartcode) = PP.MaterialCode 
        AND TRIM(pos.sitecode) = p.PlantCode 
        AND P.PlantKey = PP.PlantKey
        AND PP.DataSourceKey = 2
        AND P.DataSourceKey = PP.DataSourceKey

    LEFT OUTER JOIN sap.DimPurchaseItemCategories PIC 
        ON  TRIM(pos.PurchaseItemCategory) = PIC.PurchaseItemCategoryCode
        AND PIC.DataSourceKey = 2
        
    LEFT OUTER JOIN sap.DimSpecialStocks SS 
        on LTRIM(RTRIM(pos.SpecialStocksCode)) = TRIM(SS.SpecialStocksCode)
        AND SS.DataSourceKey = 2
        
    LEFT OUTER JOIN sap.DimManufacturers M 
        on LTRIM(RTRIM(pos.MfrCorporationDSCode)) = M.ManufacturerCode
        AND M.DataSourceKey = 2

    LEFT OUTER JOIN sap.DimPaymentTerms AS DPT ON upper(trim(pos.PaymentTerms)) = upper(trim(DPT.PaymentTerms))
        and DPT.datasourcekey = 2

    LEFT OUTER JOIN sap.DimAML AS AML 
        ON upper(TRIM(pos.AMLReference)) = upper(TRIM(AML.AMLReference ))
        AND AML.PlantKey = P.PlantKey        
        AND AML.DataSourceKey = P.DataSourceKey
        and aml.datasourcekey = 2

    LEFT OUTER JOIN sap.DimBuyers B 
        On upper(TRIM(pos.BuyerCode)) = upper(TRIM(B.BuyerCode))
        AND B.DataSourceKey = 2
            
    LEFT OUTER JOIN sap.DimSellers DS 
        ON upper(TRIM(pos.SupplierContact)) = upper(TRIM(ds.sellerName ))
        AND upper(TRIM(pos.SupplierPhoneNumber)) = upper(TRIM(ds.Phone1))
        AND DS.DataSourceKey = 2

    LEFT OUTER JOIN 
        (   
            SELECT 
                  DR1.ExchangeRateKey
                , DR1.CurrencyCode
                , DR1.ToCurrencyCode
                , DR1.EffectiveFromDateKey
                , DR1.DataSourceKey
                , ROW_NUMBER() OVER (PARTITION BY DR1.CurrencyCode, DR1.ToCurrencyCode , DR1.DataSourceKey
                            ORDER BY DR1.EffectiveFromDateKey DESC, DR1.ExchangeRateKey DESC ) as rn 
            FROM 
                sap.DimExchangeRates DR1
            WHERE
                ToCurrencyCode = 'USD'
        ) DER 
        ON   DER.CurrencyCode = TRIM(pos.CurrencyCode)
        AND  DER.ToCurrencyCode = 'USD' 
        AND DER.EffectiveFromDateKey = TRIM(pos.PURCHASEORDERCREATEDDATEKEY)
        AND DER.DataSourceKey = 2
    
    LEFT OUTER JOIN sap.DimCurrencyDecimalPlaces AS DCDP 
        ON   DCDP.CurrencyCode = pos.CurrencyCode 
	    AND DCDP.ExponentFactor > 0         
        AND DCDP.DataSourceKey = 2

    //LEFT OUTER JOIN (select  DISTINCT rcvprn from  conformed.hcc_ha_EDP13 WHERE mestyp IN ('DELINS', 'ORDCHG', 'ORDERS', 'ZSM') ) e ON pos.SupplierCorporationDSCode = e.rcvprn
    
    LEFT OUTER JOIN sap.DIMMATERIALSUNITOFMEASURES MM
        on PP.MaterialKey = MM.MaterialKey
        AND pos.ORDERUNITOFMEASURECODE = MM.alternateunitofmeasuredscode        ;
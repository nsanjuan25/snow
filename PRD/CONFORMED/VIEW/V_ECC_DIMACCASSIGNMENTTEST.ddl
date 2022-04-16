create or replace view V_ECC_DIMACCASSIGNMENTTEST(
	ROW_ID,
	DATASOURCEKEY,
	CLIENT,
	PURCHASINGDOCUMENTNUMBER,
	ITEMNUMBER,
	SEQUENTIALNUMBER,
	DELETIONINDICATOR,
	CREATIONDATE,
	PURCHASINGCHANGEFLAG,
	QUANTITY,
	DISTRIBUTIONPERCENTAGE,
	NETORDERVALUE,
	GLACCOUNTNUMBER,
	BUSINESSAREA,
	COSTCENTER,
	PROJECTNUMBER,
	SALESANDDISTRIBUTIONDOCNO,
	SALESDOCUMENTITEM,
	SCHEDULELINE,
	GROSSREQUIREMENTSINDICATOR,
	MAINASSETNUMBER,
	ASSETSUBNUMBER,
	ORDERNUMBER,
	GOODSRECEPIENT,
	UNLOADINGPOINT,
	CONTROLLINGAREA,
	POSTTOCOSTCENTER,
	POSTTOORDER,
	POSTTOPROJECT,
	FINALINVOICEINDICATOR,
	COSTOBJECT,
	PROFITABILITYSEGMENTNUMBER,
	PROFITCENTER,
	WBSELEMENT,
	NETWORKNUMBER,
	ROUTINGNUMBER,
	INTERNALKEY,
	INTERNALCOUNTER,
	PARTNERACCOUNTNUMBER,
	COMMITMENTITEM,
	RECOVERYINDICATOR,
	FUNDSCENTER,
	FUND,
	FUNCTIONALAREA,
	REFERENCEDATE,
	ROUTINGNO,
	ORDERCOUNTER,
	SALESTAX,
	TAXJURISDICTION,
	NONDEDUCTABLEINPUTTAX,
	DOCNOEARMARKEDFUNDS,
	DOCITEMEARMARKEDFUNDS,
	PS_PSP_PNR,
	GLDESCRIPTION
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into V_ECC_DimAccAssignment
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-09     SRIDHAR                 Initial Revision  
2021-12-01     Noel San Juan           Change DataSourceKey to 1 since this is ECC
2021-12-03     Noel San Juan           Modify the view to include APS logic
  */
SELECT
	*
FROM
(
	SELECT
		ROW_NUMBER() OVER 
		(
			PARTITION BY 
			ekkn.MANDT,
			ekkn.EBELN,
			ekkn.EBELP,
			ZEKKN
			ORDER BY ekkn.EBELN,ekkn.EBELP
		)							AS Row_Id,
		1							AS Datasourcekey,
		IFNULL(ekkn.MANDT,' ')		AS Client,
		IFNULL(ekkn.EBELN,' ')		AS PurchasingDocumentNumber,
		IFNULL(ekkn.EBELP,' ')		AS ItemNumber,
		IFNULL(ZEKKN,' ')			AS SequentialNumber,
		IFNULL(ekkn.LOEKZ,' ')		AS DeletionIndicator,
		IFNULL(ekkn.AEDAT,' ')		AS CreationDate,
		IFNULL(KFLAG,' ')			AS PurchasingChangeFlag,
		ekkn.MENGE					AS Quantity,
		VPROZ						AS DistributionPercentage,
		ekkn.NETWR					AS NetOrderValue,
		IFNULL(SAKTO,' ')			AS GLAccountNumber,
		IFNULL(GSBER,' ')			AS BusinessArea,
		IFNULL(ekkn.KOSTL,' ')		AS CostCenter,
		IFNULL(PROJN,' ')			AS ProjectNumber,
		IFNULL(VBELN,' ')			AS SalesandDistributionDocNo,
		IFNULL(VBELP,' ')			AS SalesDocumentItem,
		IFNULL(VETEN,' ')			AS ScheduleLine,
		IFNULL(KZBRB,' ')			AS GrossRequirementsIndicator,
		IFNULL(ANLN1,' ')			AS MainAssetNumber,
		IFNULL(ANLN2,' ')			AS AssetSubnumber,
		IFNULL(AUFNR,' ')			AS OrderNumber,
		IFNULL(WEMPF,' ')			AS GoodsRecepient,
		IFNULL(ABLAD,' ')			AS UnloadingPoint,
		IFNULL(KOKRS,' ')			AS ControllingArea,
		IFNULL(XBKST,' ')			AS PostToCostCenter,
		IFNULL(XBAUF,' ')			AS PostToOrder,
		IFNULL(XBPRO,' ')			AS PostToProject,
		IFNULL(ekkn.EREKZ,' ')		AS FinalInvoiceIndicator,
		IFNULL(KSTRG,' ')			AS CostObject,
		IFNULL(PAOBJNR,' ')			AS ProfitabilitySegmentNumber,
		IFNULL(ekkn.PRCTR,' ')		AS ProfitCenter,
        IFNULL(WBS.posid ,' ')	    AS WBSElement,
		IFNULL(NPLNR,' ')			AS NetworkNumber,
		IFNULL(AUFPL,' ')			AS RoutingNumber,
		IFNULL(IMKey,' ')			AS InternalKey,
		IFNULL(APLZL,' ')			AS InternalCounter,
		IFNULL(VPTNR,' ')			AS PartnerAccountNumber,
		IFNULL(ekkn.FIPOS,' ')		AS CommitmentItem,
		IFNULL(ekkn.RECID,' ')		AS RecoveryIndicator,
		IFNULL(ekkn.FISTL,' ')		AS FundsCenter,
		IFNULL(ekkn.GEBER,' ')		AS Fund,
		IFNULL(ekkn.FKBER,' ')		AS FunctionalArea,
		IFNULL(DABRZ,' ')			AS ReferenceDate,
		IFNULL(AUFPL_ORD,' ')		AS RoutingNo,
		IFNULL(APLZL_ORD,' ')		AS OrderCounter,
		IFNULL(ekkn.MWSKZ,' ')		AS SalesTax,
		IFNULL(ekkn.TXJCD,' ')		AS TaxJurisdiction,
		ekkn.NAVNW					AS NonDeductableInputTax,
		ekkn.KBLNR					AS DocNoEarmarkedFunds,
		ekkn.KBLPOS					AS DocItemEarmarkedFunds,
        ekkn.PS_PSP_PNR,
        IFNULL(COA.TXT50,' ')	    AS GLDescription
	FROM
		conformed.ecc_ha_ekkn  ekkn	-- AccountAssignment
		INNER JOIN  conformed.ecc_ha_ekpo ekpo ON  ekpo.EBELN = ekkn.EBELN
			AND ekpo.EBELP= ekkn. EBELP
		LEFT OUTER JOIN CONFORMED.ECC_HA_SKAT COA ON ekkn.SAKTO = COA.SAKNR -- GLAccount 
			AND COA.SPRAS = 'E'     -- LanguageKey
			AND COA.KTOPL = '0010'  -- ChartOfAccounts
		LEFT OUTER JOIN CONFORMED.ECC_HA_PRPS WBS ON WBS.pspnr = ekkn.PS_PSP_PNR	   -- WBSMaster
) A 
WHERE A.Row_Id = 1;
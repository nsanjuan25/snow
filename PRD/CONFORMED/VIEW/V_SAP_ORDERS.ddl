create or replace view V_SAP_ORDERS(
	DATASOURCEKEY,
	ORDERNUMBER,
	ORDERITEM,
	ORDERTYPE,
	DSCREATEDBY,
	DSCREATEDON,
	PLANTCODE,
	TECHNICALCOMPLETIONDATE,
	REFERENCEORDERNUMBER,
	COMPANYCODE,
	CURRENCYCODE,
	ORDERSTATUS,
	CURRENTSTATUS,
	DELETIONFLAG,
	PROCESSCATEGORY,
	ORDERCATEGORY,
	PROFITCENTER,
	SALESDOCUMENTNUMBER,
	SALESDOCUMENTITEM,
	ISHPVENRAY,
	RESERVATIONNUMBER,
	MATERIALNUMBER,
	PRODUCTIONSUPERVISOR,
	PLANNERCODE,
	BASICSTARTDATE,
	BASICFINISHDATE,
	TOTALORDERQUANTITY,
	CONFIRMEDYIELD,
	UNITOFMEASURE,
	SCHEDULEFINISHDATE,
	ACTUALSTARTDATE,
	SCHEDULESTARTDATE,
	RECEIVEDQUANTITY,
	PRODUCTIONVERSION,
	STORAGELOCATION,
	UNLOADINGPOINT,
	GOODRECIPIENT,
	PLANNEDORDERQUANTITY,
	OVERDELIVERYTOLERANCELIMIT,
	UNLIMITEDOVERDELIVERY,
	UNDERDELIVERYTOLERANCELIMIT,
	PLANNEDORDERNUMBER,
	ORDERITEMQUANTITY,
	GOODSRECEIVEDQUANTITY,
	SCRAPFIXEDQUANTITY,
	DELIVERYDATE,
	PLANNEDDELIVERYDATE,
	STOCKTYPE,
	ISDELIVERYCOMPLETED,
	DELETED,
	PRODUCTIONORDERSTATUS,
	UPDATED_ON_AFKO,
	UPDATED_ON_AUFK,
	UPDATED_ON_AFPO,
	FULLORDERSTATUS
) as
/*--------------------------------------------------------------------

This view is used to ADD data into CONFORMED.SAP_ORDERS table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision
*/
SELECT
    1          AS DataSourceKey,
	aufk.aufnr AS OrderNumber,
	afpo.posnr AS OrderItem,
	afpo.dauat AS OrderType,
	aufk.ernam AS DSCreatedBy,
	aufk.erdat AS DSCreatedOn,
	aufk.werks AS PlantCode,
	aufk.idat2 AS TechnicalCompletionDate,
	aufk.refnr AS ReferenceOrderNumber,
	aufk.bukrs AS CompanyCode,
	aufk.waers AS CurrencyCode,
	aufk.astnr AS OrderStatus,
	aufk.estnr AS CurrentStatus,
	aufk.loekz AS DeletionFlag,
	aufk.proty AS ProcessCategory,
	aufk.autyp AS OrderCategory,
	aufk.prctr AS ProfitCenter,
	aufk.KDAUF AS SalesDocumentNumber,
	aufk.KDPOS AS SalesDocumentItem,
	0		   AS IsHPVenray,
	afko.rsnum AS ReservationNumber,
	afko.plnbez AS MaterialNumber,
	afko.fevor AS ProductionSupervisor,
	afko.dispo AS PlannerCode,
	afko.gstrp AS BasicStartDate,
	afko.gltrp AS BasicFinishDate,
	afko.gamng AS TotalOrderQuantity,
	afko.igmng AS ConfirmedYield,
	afko.gmein AS UnitofMeasure,
	afko.gltrs AS ScheduleFinishDate,
	afko.gstri AS ActualStartDate,
	afko.gstrs AS ScheduleStartDate,
	afpo.wemng AS ReceivedQuantity,
	afpo.verid AS ProductionVersion,
	afpo.lgort AS StorageLocation,
	afpo.ablad AS UnloadingPoint,
	afpo.wempf AS GoodRecipient,
	afpo.pgmng AS PlannedOrderQuantity,
	afpo.uebto AS OverdeliveryToleranceLimit,
	CASE 
		WHEN afpo.uebtk='X' THEN 'Allowed'
		ELSE 'Not Allowed'
	END AS UnlimitedOverdelivery,
	afpo.untto AS UnderdeliveryToleranceLimit,
	afpo.plnum AS PlannedOrderNumber,
	afpo.psmng AS OrderItemQuantity,
	afpo.wemng AS GoodsReceivedQuantity,
	afpo.pamng AS ScrapFixedQuantity,
	afpo.ltrmi AS DeliveryDate,
	afpo.ltrmp AS PlannedDeliveryDate,
	afpo.insmk AS StockType,
	afpo.elikz AS IsDeliveryCompleted,
	afpo.xloek AS Deleted,
	ifnull(POS.txt04, '')  AS ProductionOrderStatus,
	afko.SNFLK_UPDATEDON AS Updated_On_afko,
	aufk.SNFLK_UPDATEDON AS Updated_On_aufk,
	afpo.SNFLK_UPDATEDON AS Updated_On_afpo,
	ifnull(POS1.FullOrder, '') AS FullOrderStatus
FROM 
    CONFORMED.ECC_HA_AFKO afko
    INNER JOIN CONFORMED.ECC_HA_AUFK aufk on afko.mandt = aufk.mandt
        AND afko.aufnr = aufk.aufnr 
    INNER JOIN CONFORMED.ECC_HA_AFPO afpo on aufk.mandt = afpo.mandt
        AND aufk.aufnr = afpo.aufnr
    LEFT OUTER JOIN 
    ( 
		SELECT 
			JEST.OBJNR,
			CASE 
				WHEN TJ02T.txt04 ='CNF' THEN 'TECO' 
				ELSE TJ02T.txt04 
			END AS txt04,
			row_number() OVER
			(
				PARTITION BY 
					JEST.OBJNR 
				ORDER BY 
					JEST.seqgen DESC
			) RN
		FROM  
			CONFORMED.ECC_HA_JEST JEST 
			INNER JOIN CONFORMED.ECC_HA_TJ02T TJ02T ON JEST.STAT = TJ02T.ISTAT
		WHERE
			JEST.INACT <> 'X' 
			AND SPRAS = 'E'
			AND TJ02T.txt04 IN ('TECO', 'REL', 'PLN', 'CNF' )
    ) POS ON aufk.OBJNR = POS.OBJNR
        AND POS.RN = 1
	LEFT OUTER JOIN 
    ( 
		SELECT 
			JEST1.OBJNR,
			LISTAGG(IFNULL(TJ02T1.txt04,'')) WITHIN GROUP (ORDER BY TJ02T1.txt04) AS FullOrder
		FROM  
			CONFORMED.ECC_HA_JEST JEST1 
			INNER JOIN CONFORMED.ECC_HA_TJ02T TJ02T1 ON JEST1.STAT = TJ02T1.ISTAT
		WHERE
			JEST1.INACT <> 'X' 
			AND SPRAS = 'E'
		GROUP BY JEST1.OBJNR
    ) POS1 ON aufk.OBJNR = POS1.OBJNR;
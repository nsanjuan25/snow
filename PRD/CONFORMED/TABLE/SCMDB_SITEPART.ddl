create or replace TABLE SCMDB_SITEPART (
	SITEPARTID NUMBER(38,0),
	SITEID NUMBER(38,0),
	SITEPARTCODE VARCHAR(18),
	SITEPARTTYPEID NUMBER(38,0),
	DATASOURCEID NUMBER(38,0),
	ABCCODE VARCHAR(1),
	MATERIALGROUPCORPORATIONDSID NUMBER(38,0),
	MATERIALGROUPCODE VARCHAR(10),
	PRODUCTGROUPCODE VARCHAR(20),
	CUSTOMERPARTID NUMBER(38,0),
	ROUTINGID NUMBER(38,0),
	PLANNINGCALENDARCODE VARCHAR(4),
	ORDERPOLICYCODE VARCHAR(4),
	SITEPARTDESCRIPTION VARCHAR(50),
	PLANNERCODE VARCHAR(10),
	BUYERCODE VARCHAR(10),
	NEWQUOTEAVAILABLEFLAG BOOLEAN,
	UNITOFMEASUREDSCODE VARCHAR(6),
	YIELD NUMBER(38,2),
	MINIMUMLOTSIZE NUMBER(38,0),
	MAXIMUMLOTSIZE NUMBER(38,0),
	MULTIPLEQTY NUMBER(38,0),
	SAFETYSTOCKQTY NUMBER(38,0),
	REORDERPOINTQTY NUMBER(38,0),
	MAXIMUMSTOCKQTY NUMBER(38,0),
	AVERAGEQTY NUMBER(38,0),
	NUMBEROFDAYSSUPPLY NUMBER(38,0),
	PLANNINGTIMEFENCE NUMBER(38,0),
	DEMANDTIMEFENCE NUMBER(38,0),
	SAFETYLEADTIME NUMBER(38,0),
	DOCKTOSTOCKLEADTIME NUMBER(38,0),
	FIXEDLEADTIME NUMBER(38,0),
	BATCHMANAGEDFLAG BOOLEAN,
	VARLEADTIME NUMBER(38,6),
	AVERAGESELLINGPRICE NUMBER(38,6),
	BEFOREFORECASTINTERVAL NUMBER(38,0),
	AFTERFORECASTINTERVAL NUMBER(38,0),
	PRICEUNIT NUMBER(38,6),
	STDUNITCOSTP0 NUMBER(38,6),
	STDUNITCOSTP1 NUMBER(38,6),
	SELLUNITPRICEP0 NUMBER(38,6),
	SELLUNITPRICEP1 NUMBER(38,6),
	P1EFFECTIVEFROMDATE TIMESTAMP_NTZ(9),
	CARRYINGCOSTRATE NUMBER(38,4),
	LABORCOST NUMBER(38,6),
	MATERIALCOST NUMBER(38,6),
	OVERHEADCOST NUMBER(38,6),
	ASSEMBLYSCRAPPCT NUMBER(38,2),
	COMPONENTSCRAPPCT NUMBER(38,2),
	PROFITCENTER VARCHAR(12),
	MRPIMPORTJOBID NUMBER(38,0),
	MRPCURRENTASOFDTS TIMESTAMP_NTZ(9),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	PLANNINGSTRATEGYGROUP VARCHAR(2),
	DSCREATEDTS TIMESTAMP_NTZ(9),
	DSUPDATEDTS TIMESTAMP_NTZ(9),
	PARTGROUPCODE VARCHAR(10),
	LOCALCURRENCYTOUSDEXCHANGERATE NUMBER(38,6),
	USESPSINFOLEADTIME BOOLEAN,
	INVENTORYCURRENTASOFDTS TIMESTAMP_NTZ(9),
	P2EFFECTIVEFROMDATE TIMESTAMP_NTZ(9),
	P3EFFECTIVEFROMDATE TIMESTAMP_NTZ(9),
	P0EFFECTIVEFROMDATE TIMESTAMP_NTZ(9),
	MATERIALLEDGERACTIVEFLAG NUMBER(38,0),
	RANGEOFCOVERAGEPROFILEID NUMBER(38,0),
	SAFETYTIMEINDICATOR VARCHAR(1),
	MRPPROFILE VARCHAR(4),
	MRPGROUP VARCHAR(4),
	DISCONTINUATIONINDICATOR VARCHAR(1),
	EFFECTIVEOUTDATE TIMESTAMP_NTZ(9),
	FOLLOWUPMATERIAL VARCHAR(18),
	MATERIALGROUP4 VARCHAR(3),
	COMMODITYIMPORTCODE VARCHAR(17),
	LOTSIZECODE VARCHAR(10),
	INDUSTRYSTDDESC VARCHAR(18),
	SAFETYINSTOCK NUMBER(38,0),
	FIXEDLOTSIZE NUMBER(38,0),
	PRICECONTROLINDICATOR VARCHAR(1),
	STDUNITCOSTPLANNEDCURRENT NUMBER(38,3),
	MOVINGAVGUNITCOST NUMBER(38,3),
	STKVALUEDQTY NUMBER(38,3),
	STKVALUECURRENT NUMBER(38,3),
	STKVALUEMOVINGAVGWHENSTDPRICECONTROL NUMBER(38,3),
	STDUNITCOSTPLANNEDNEXT NUMBER(38,3),
	MLPRICECONTROLINDICATOR VARCHAR(1),
	MLMOVINGAVGUNITCOSTUSD NUMBER(38,3),
	MLCURRENCYCODE VARCHAR(5),
	MLSTKVALUECURRENTUSD NUMBER(38,3),
	MLSTKVALUEMOVINGAVGWHENSTDPRICECONTROLUSD NUMBER(38,3),
	MLSTDUNITCOSTUSD NUMBER(38,3),
	MLPRICEUNIT NUMBER(38,3),
	STKVALUEATSTDUNITCOST NUMBER(38,3),
	STKVALUEATMOVINGAVGCOST NUMBER(38,3),
	MLSTKVALUEATSTDUNITCOSTUSD NUMBER(38,3),
	MLSTKVALUEATMOVINGAVGCOSTUSD NUMBER(38,3),
	MLPERIODCURRENTSTDCOSTESTIMATE VARCHAR(3),
	MLFISCALYEARCURRENTSTDCOSTESTIMATE VARCHAR(4),
	AUTOPORESCHEDULESTRATEGY VARCHAR(5),
	GENERALITEMCATEGORY VARCHAR(5),
	ITEMCATEGORYGROUP VARCHAR(5),
	DISTRIBUTIONCHANNEL VARCHAR(3),
	QAUSAGE VARCHAR(2),
	PROFITCENTERID NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);
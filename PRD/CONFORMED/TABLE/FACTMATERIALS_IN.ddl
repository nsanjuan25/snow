create or replace TABLE FACTMATERIALS_IN (
	SNAPSHOTDATEKEY DATE,
	DATASOURCEKEY NUMBER(38,0),
	MATERIALKEY NUMBER(38,0),
	PLANNERKEY NUMBER(38,0),
	BUYERKEY NUMBER(38,0),
	MATERIALGROUPKEY NUMBER(38,0),
	PLANTKEY NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	PROFITCENTERCODE VARCHAR(12),
	CURRENCYCODE VARCHAR(5),
	PRICEUNIT NUMBER(18,6),
	LOCALCURRENCYTOUSDEXCHANGERATE NUMBER(18,6),
	STANDARDUNITCOSTP0 NUMBER(18,6),
	STANDARDUNITCOSTP0USD NUMBER(36,12),
	STANDARDCOSTUSD NUMBER(38,12),
	STANDARDUNITCOSTP1 NUMBER(18,6),
	STANDARDUNITCOSTP1USD NUMBER(36,12),
	STANDARDCOSTP1USD NUMBER(38,12),
	SELLUNITPRICEP0 NUMBER(18,6),
	SELLUNITPRICEP0USD NUMBER(36,12),
	SELLPRICEUSD NUMBER(38,12),
	SELLUNITPRICEP1 NUMBER(18,6),
	SELLUNITPRICEP1USD NUMBER(36,12),
	SELLPRICEP1USD NUMBER(38,12),
	CARRYINGCOSTRATE NUMBER(1,0),
	LABORCOST NUMBER(1,0),
	MATERIALCOST NUMBER(1,0),
	SAFETYTIMEINDICATOR VARCHAR(1),
	SAFETYINSTOCK NUMBER(38,0),
	FIXEDLOTSIZE NUMBER(38,0),
	REORDERPOINTQTY NUMBER(38,0),
	SAFETYLEADTIME NUMBER(38,0),
	FIXEDLEADTIME NUMBER(38,0),
	MULTIPLEQTY NUMBER(38,0),
	SAFETYSTOCKQTY NUMBER(38,0),
	MAXIMUMSTOCKQTY NUMBER(38,0),
	MINIMUMLOTSIZE NUMBER(38,0),
	SPENDQUANTITY NUMBER(38,6),
	SPENDAMOUNTINUSD NUMBER(38,12),
	MRPONHANDQUANTITY NUMBER(31,5),
	MRPONORDERQUANTITY NUMBER(31,5),
	INVENTORYONHANDQUANTITY NUMBER(30,6),
	INVENTORYONHANDNONNETTABLEQUANTITY NUMBER(30,6),
	INVENTORYCONSIGNEDQUANTITY NUMBER(30,6),
	INVENTORYCONSIGNEDNONNETTABLEQUANTITY NUMBER(30,6),
	DEMANDQUANTITY NUMBER(31,5),
	DEMANDQUANTITY90DAYS NUMBER(31,5),
	MASTERSCHEDULEQUANTITY NUMBER(31,5),
	INVENTORYSNAPSHOTDATEKEY DATE,
	MRPSNAPSHOTDATEKEY DATE,
	CREATEDON VARCHAR(16777216),
	UPDATEDON VARCHAR(16777216)
);
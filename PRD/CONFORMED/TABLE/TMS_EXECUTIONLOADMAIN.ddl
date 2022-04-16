create or replace TABLE TMS_EXECUTIONLOADMAIN (
	OID VARCHAR(16777216),
	PRIMARYREFERENCE VARCHAR(16777216),
	CREATEDATE VARCHAR(16777216),
	CREATEBY VARCHAR(16777216),
	UPDATEDATE VARCHAR(16777216),
	UPDATEBY VARCHAR(16777216),
	ACTUALDELIVERY VARCHAR(16777216),
	ACTUALSHIP VARCHAR(16777216),
	ACTUALTRANSITTIME VARCHAR(16777216),
	ASSIGNEDTO VARCHAR(16777216),
	AUTOTENDERING VARCHAR(16777216),
	BIDREQUESTBOARD VARCHAR(16777216),
	BIDREQUESTEXPIRATION VARCHAR(16777216),
	BIDREQUESTSTATUS VARCHAR(16777216),
	BILLTOADDRESS1 VARCHAR(16777216),
	BILLTOADDRESS2 VARCHAR(16777216),
	BILLTOCITY VARCHAR(16777216),
	BILLTOCODE VARCHAR(16777216),
	BILLTOCTRY VARCHAR(16777216),
	BILLTONAME VARCHAR(16777216),
	BILLTOSTATE VARCHAR(16777216),
	BILLTOZIP VARCHAR(16777216),
	CARRIERCHARGE VARCHAR(16777216),
	CARRIERCURRENCY VARCHAR(16777216),
	CARRIERDISTANCE VARCHAR(16777216),
	CARRIERMODE VARCHAR(16777216),
	CARRIERNAME VARCHAR(16777216),
	CARRIERNORMCHARGE VARCHAR(16777216),
	CARRIERNORMCURRENCY VARCHAR(16777216),
	CARRIERREASON VARCHAR(16777216),
	CARRIERSCAC VARCHAR(16777216),
	CARRIERSERVICE VARCHAR(16777216),
	CARRIERTOTALDETENTION VARCHAR(16777216),
	CARRIERTOTALFUEL VARCHAR(16777216),
	CARRIERTOTALLINEHAUL VARCHAR(16777216),
	CARRIERTOTALOTHER VARCHAR(16777216),
	CARRIERTOTALTAX VARCHAR(16777216),
	COMPLETEDACTIVITYDATE VARCHAR(16777216),
	COMPLETEDACTIVITYID VARCHAR(16777216),
	COMPLETEDACTIVITYTYPE VARCHAR(16777216),
	COST VARCHAR(16777216),
	CUBE VARCHAR(16777216),
	CUSTOMERCHARGE VARCHAR(16777216),
	CUSTOMERCURRENCY VARCHAR(16777216),
	CUSTOMERDISTANCE VARCHAR(16777216),
	CUSTOMERMODE VARCHAR(16777216),
	CUSTOMERNAME VARCHAR(16777216),
	CUSTOMERNORMCHARGE VARCHAR(16777216),
	CUSTOMERNORMCURRENCY VARCHAR(16777216),
	CUSTOMERREASON VARCHAR(16777216),
	CUSTOMERSERVICE VARCHAR(16777216),
	CUSTOMERTOTALDETENTION VARCHAR(16777216),
	CUSTOMERTOTALFUEL VARCHAR(16777216),
	CUSTOMERTOTALLINEHAUL VARCHAR(16777216),
	CUSTOMERTOTALOTHER VARCHAR(16777216),
	CUSTOMERTOTALTAX VARCHAR(16777216),
	DESTADDR1 VARCHAR(16777216),
	DESTADDR2 VARCHAR(16777216),
	DESTCITY VARCHAR(16777216),
	DESTCODE VARCHAR(16777216),
	DESTCTRY VARCHAR(16777216),
	DESTNAME VARCHAR(16777216),
	DESTSTATE VARCHAR(16777216),
	DESTZIP VARCHAR(16777216),
	DESTVALID VARCHAR(16777216),
	OIDREPEAT VARCHAR(16777216),
	EVENTSDROP VARCHAR(16777216),
	EVENTSPICKUP VARCHAR(16777216),
	EVENTSTOTAL VARCHAR(16777216),
	EXTRACTDATE VARCHAR(16777216),
	EXTRACTNUMBER VARCHAR(16777216),
	INVESTIGATE VARCHAR(16777216),
	INVOICECOST VARCHAR(16777216),
	INVOICEMARGIN VARCHAR(16777216),
	INVOICEREVENUE VARCHAR(16777216),
	INVOICES VARCHAR(16777216),
	INVOICESALL VARCHAR(16777216),
	INVOICESCARRIER VARCHAR(16777216),
	INVOICESVENDOR VARCHAR(16777216),
	LATEDAYS VARCHAR(16777216),
	LINEARFEET VARCHAR(16777216),
	MARGIN VARCHAR(16777216),
	NEXTACTIVITYDATE VARCHAR(16777216),
	NEXTACTIVITYID VARCHAR(16777216),
	NEXTACTIVITYTYPE VARCHAR(16777216),
	ORIGINADDR1 VARCHAR(16777216),
	ORIGINADDR2 VARCHAR(16777216),
	ORIGINCITY VARCHAR(16777216),
	ORIGINCODE VARCHAR(16777216),
	ORIGINCTRY VARCHAR(16777216),
	ORIGINNAME VARCHAR(16777216),
	ORIGINSTATE VARCHAR(16777216),
	ORIGINVALID VARCHAR(16777216),
	ORIGINZIP VARCHAR(16777216),
	OWNER VARCHAR(16777216),
	PALLET VARCHAR(16777216),
	PAYMENTSTATUS VARCHAR(16777216),
	PAYMENTTERMS VARCHAR(16777216),
	PICKUPNUMBER VARCHAR(16777216),
	PODRECEIVED VARCHAR(16777216),
	PRONUMBER VARCHAR(16777216),
	QUANTITY VARCHAR(16777216),
	QUANTITYSHIPUNIT VARCHAR(16777216),
	RERATEFLAG VARCHAR(16777216),
	REVENUE VARCHAR(16777216),
	RUNID VARCHAR(16777216),
	SALESMARGIN VARCHAR(16777216),
	SHIPMENTS VARCHAR(16777216),
	STATUS VARCHAR(16777216),
	TARGETDELIVERYEARLY VARCHAR(16777216),
	TARGETDELIVERYLATE VARCHAR(16777216),
	TARGETDELIVERYRANGE VARCHAR(16777216),
	TARGETSHIPEARLY VARCHAR(16777216),
	TARGETSHIPLATE VARCHAR(16777216),
	TARGETSHIPRANGE VARCHAR(16777216),
	TENDEREXP VARCHAR(16777216),
	TENDERUSER VARCHAR(16777216),
	UPDATEBYREPEAT VARCHAR(16777216),
	UPDATEDATEREPEAT VARCHAR(16777216),
	WEIGHT VARCHAR(16777216),
	WEIGHTSHIPUNIT VARCHAR(16777216),
	WEIGHTUOM VARCHAR(16777216),
	WEIGHTUOMSHIPUNIT VARCHAR(16777216),
	ORIGINGEO VARCHAR(16777216),
	DESTGEO VARCHAR(16777216),
	ENTERPRISENAME VARCHAR(16777216),
	PRIMARYREFERENCEREPEAT VARCHAR(16777216),
	MARGINREPEAT VARCHAR(16777216),
	MARGINCURRENCYCODE VARCHAR(16777216),
	INCOME VARCHAR(16777216),
	COSTREPEAT VARCHAR(16777216),
	PRIMARYREFERENCEREPEAT1 VARCHAR(16777216),
	MOVETYPE VARCHAR(16777216),
	VESSELAIRLINENAME VARCHAR(16777216),
	VESSELAIRLINECUTOFF VARCHAR(16777216),
	VOYAGEAIRLINENUMBER VARCHAR(16777216),
	LLOYDSCODE VARCHAR(16777216),
	LETTEROFCREDITNUMBER VARCHAR(16777216),
	LETTEROFCREDITISSUEDATE VARCHAR(16777216),
	LETTEROFCREDITEXPIRYDATE VARCHAR(16777216),
	POINTOFORIGINNAME VARCHAR(16777216),
	POINTOFORIGINCODE VARCHAR(16777216),
	POINTOFORIGINADDRESS VARCHAR(16777216),
	POINTOFORIGINCITY VARCHAR(16777216),
	POINTOFORIGINSTATE VARCHAR(16777216),
	POINTOFORIGINPOSTAL VARCHAR(16777216),
	POINTOFORIGINCOUNTRY VARCHAR(16777216),
	CONTAINERSTUFFINGLOCATIONNAME VARCHAR(16777216),
	CONTAINERSTUFFINGLOCATIONCODE VARCHAR(16777216),
	CONTAINERSTUFFINGLOCATIONADDRESS VARCHAR(16777216),
	CONTAINERSTUFFINGLOCATIONCITY VARCHAR(16777216),
	CONTAINERSTUFFINGLOCATIONSTATE VARCHAR(16777216),
	CONTAINERSTUFFINGLOCATIONPOSTAL VARCHAR(16777216),
	CONTAINERSTUFFINGLOCATIONCOUNTRY VARCHAR(16777216),
	CONTAINERSTUFFERLOCATIONNAME VARCHAR(16777216),
	CONTAINERSTUFFERLOCATIONCODE VARCHAR(16777216),
	CONTAINERSTUFFERLOCATIONADDRESS VARCHAR(16777216),
	CONTAINERSTUFFERLOCATIONCITY VARCHAR(16777216),
	CONTAINERSTUFFERLOCATIONSTATE VARCHAR(16777216),
	CONTAINERSTUFFERLOCATIONPOSTAL VARCHAR(16777216),
	CONTAINERSTUFFERLOCATIONCOUNTRY VARCHAR(16777216),
	PORTOFEXPORTNAME VARCHAR(16777216),
	PORTOFEXPORTCODE VARCHAR(16777216),
	PORTOFEXPORTADDRESS VARCHAR(16777216),
	PORTOFEXPORTCITY VARCHAR(16777216),
	PORTOFEXPORTSTATE VARCHAR(16777216),
	PORTOFEXPORTPOSTAL VARCHAR(16777216),
	PORTOFEXPORTCOUNTRY VARCHAR(16777216),
	PORTOFENTRYNAME VARCHAR(16777216),
	PORTOFENTRYCODE VARCHAR(16777216),
	PORTOFENTRYADDRESS VARCHAR(16777216),
	PORTOFENTRYCITY VARCHAR(16777216),
	PORTOFENTRYSTATE VARCHAR(16777216),
	PORTOFENTRYPOSTAL VARCHAR(16777216),
	PORTOFENTRYCOUNTRY VARCHAR(16777216),
	FIRSTPORTOFUNLOADINGNAME VARCHAR(16777216),
	FIRSTPORTOFUNLOADINGCODE VARCHAR(16777216),
	FIRSTPORTOFUNLOADINGADDRESS VARCHAR(16777216),
	FIRSTPORTOFUNLOADINGCITY VARCHAR(16777216),
	FIRSTPORTOFUNLOADINGSTATE VARCHAR(16777216),
	FIRSTPORTOFUNLOADINGPOSTAL VARCHAR(16777216),
	FIRSTPORTOFUNLOADINGCOUNTRY VARCHAR(16777216),
	FINALDESTPORTNAME VARCHAR(16777216),
	FINALDESTPORTCODE VARCHAR(16777216),
	FINALDESTPORTADDRESS VARCHAR(16777216),
	FINALDESTPORTCITY VARCHAR(16777216),
	FINALDESTPORTSTATE VARCHAR(16777216),
	FINALDESTPORTPOSTAL VARCHAR(16777216),
	FINALDESTPORTCOUNTRY VARCHAR(16777216),
	FINALDESTNAME VARCHAR(16777216),
	FINALDESTCODE VARCHAR(16777216),
	FINALDESTADDRESS VARCHAR(16777216),
	FINALDESTCITY VARCHAR(16777216),
	FINALDESTSTATE VARCHAR(16777216),
	FINALDESTPOSTAL VARCHAR(16777216),
	FINALDESTCOUNTRY VARCHAR(16777216),
	ELECEXPORTINFOEEI VARCHAR(16777216),
	EXPORTERREFERENCENUMBER VARCHAR(16777216),
	EXPORTERLICENSENUMBER VARCHAR(16777216),
	EXPORTLICENSEDATE VARCHAR(16777216),
	FMCNUMBER VARCHAR(16777216),
	IMMEDIATETRANSPORTATIONNOIT VARCHAR(16777216),
	IMMEDIATETRANSPORTATIONDATE VARCHAR(16777216),
	TRANSPORTATIONEXPORTNOTE VARCHAR(16777216),
	IMMEDIATEEXPORTNOIE VARCHAR(16777216),
	INTERNALTRANSACTIONNOITN VARCHAR(16777216),
	USAMSNO VARCHAR(16777216),
	DESTCONTROLSTMNTDCS VARCHAR(16777216),
	ECCN VARCHAR(16777216),
	REASONFOREXPORT VARCHAR(16777216),
	BLANKETPERIODBEGINDATE VARCHAR(16777216),
	BLANKETPERIODENDDATE VARCHAR(16777216),
	ISFSHIPMENTTYPE VARCHAR(16777216),
	ISFBONDNUMBER VARCHAR(16777216),
	ISFBONDHOLDER VARCHAR(16777216),
	SURETYNUMBER VARCHAR(16777216),
	AESVESSELFLAG VARCHAR(16777216),
	AESRELATEDCOMPANIES VARCHAR(16777216),
	AESROUTEDTRANSACTION VARCHAR(16777216),
	IMPORTENTRYNUMBER VARCHAR(16777216),
	AESINBONDTYPE VARCHAR(16777216),
	GENERIC1LABEL VARCHAR(16777216),
	GENERIC1VALUE VARCHAR(16777216),
	LANECALC VARCHAR(16777216),
	FRMW_EXTRACTED_ON VARCHAR(16777216),
	UPDATEDON TIMESTAMP_NTZ(9)
);
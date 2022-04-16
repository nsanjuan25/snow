create or replace view V_FACTLTPSPACE(
	SNAPSHOTDATEKEY,
	LTPVERSIONKEY,
	PERIODCALENDARDATEKEY,
	LTPPLANT,
	LTPCUSTOMER,
	ASSEMBLYSQFT,
	CNCSQFT,
	DECORATIONSQFT,
	DFSQFT,
	MOULDINGSQFT,
	PAINTINGSQFT,
	ROUTINGLENSSQFT,
	SMTSQFT,
	STAMPINGSQFT,
	STAMPINGTOOLINGSQFT,
	TOOLINGSQFT,
	FRMW_EXTRACTED_ON
) as
SELECT 
      cast  ( I.frmw_extracted_on as date) as SnapShotDateKey     
    , DV.LTPVersionKey
    , IFNULL( D.DateKey , '1900-01-01' ) AS PeriodCalendarDateKey
    , TRIM( UPPER( I.ltpplant    ) ) AS ltpplant    
    , TRIM( UPPER( I.ltpcustomer ) ) AS ltpcustomer
    , CASE WHEN I.ltpmeasure = 'Assembly Sq. Ft.'       THEN I.value ELSE 0 END  AS AssemblySqFt
    , CASE WHEN I.ltpmeasure = 'CNC Sq Ft'              THEN I.value ELSE 0 END  AS CNCSqFt 
    , CASE WHEN I.ltpmeasure = 'Decoration Sq Ft'       THEN I.value ELSE 0 END  AS DecorationSqFt
    , CASE WHEN I.ltpmeasure = 'DF Sq. Ft.'             THEN I.value ELSE 0 END  AS DFSqFt
    , CASE WHEN I.ltpmeasure = 'Moulding Sq Ft'         THEN I.value ELSE 0 END  AS MouldingSqFt
    , CASE WHEN I.ltpmeasure = 'Painting Sq Ft'         THEN I.value ELSE 0 END  AS PaintingSqFt
    , CASE WHEN I.ltpmeasure = 'Routing Lens Sq Ft'     THEN I.value ELSE 0 END  AS RoutingLensSqFt
    , CASE WHEN I.ltpmeasure = 'SMT Sq. Ft.'            THEN I.value ELSE 0 END  AS SMTSqFt
    , CASE WHEN I.ltpmeasure = 'Stamping Sq Ft'         THEN I.value ELSE 0 END  AS StampingSqFt
    , CASE WHEN I.ltpmeasure = 'Stamping Tooling Sq Ft' THEN I.value ELSE 0 END  AS StampingToolingSqFt
    , CASE WHEN I.ltpmeasure = 'Tooling Sq. Ft.'        THEN I.value ELSE 0 END  AS ToolingSqFt
    , I.frmw_extracted_on
FROM 
    conformed.TM1_LTP_SQFDTData I
    inner JOIN tm1.DimTM1LTPVersions  DV 
    ON Upper(I.ltpversion) = DV.LTPVersion
    LEFT OUTER JOIN conformed.v_StartDateByFiscalYearQuarter D
    ON TRIM( I.ltpperiod ) = D.FiscalQuarterPeriod;
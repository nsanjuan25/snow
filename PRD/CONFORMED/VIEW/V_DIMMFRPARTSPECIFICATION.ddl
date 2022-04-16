create or replace view V_DIMMFRPARTSPECIFICATION(
	MANUFACTURERPARTKEY,
	SRCMFRPARTID,
	MANUFACTURERPARTCODE,
	DATASOURCEKEY,
	CLASSMAPCODE,
	CLASSMAPVALUECODE,
	CLASSNAME,
	CATEGORYNAME,
	CHARACTERNAME,
	VALUE,
	CLASSMAPUPDATED_ON,
	CLASSUPDATED_ON,
	CLASSMAPVALUEUPDATED_ON,
	CHARACTERISTICUPDATED_ON,
	MFRPARTCLASSUPDATED_ON,
	UOM,
	UOMDESC,
	UOMBASE,
	CONVERSIONVALUE,
	OPERATOR
) as
  
       SELECT DISTINCT
              MP.ManufacturerPartKey
            , MP.srcMfrPartID
            , trim( MP.ManufacturerPartCode )  AS ManufacturerPartCode
            , (SELECT DataSourceKey FROM PUBLIC.DIMDATASOURCES WHERE DataSourceName = 'SAP') AS DataSourceKey
            , IFNULL(TO_VARCHAR(CM.ClassMapID),'') AS ClassMapCode
            , IFNULL(TO_VARCHAR(CMV.ClassMapValueID),'UNDEFINED') AS ClassMapValueCode
            , IFNULL(MP.Commodity, '') AS ClassName
            , IFNULL(MP.CommodityCategory, '') AS CategoryName
            , IFNULL(CHR.CharacterName, '') AS CharacterName
            , COALESCE(CMV.Value, TO_VARCHAR(V.ValueNumeric),'' ) AS Value
             , IFNULL(CM.SNFLK_UPDATEDON, '1900-01-01') AS ClassMapUpdated_On
            , IFNULL(C.SNFLK_UPDATEDON, '1900-01-01') AS ClassUpdated_On
            , COALESCE(CMV.SNFLK_UPDATEDON, V.SNFLK_UPDATEDON, '1900-01-01')  AS ClassMapValueUpdated_On
            , IFNULL(CHR.SNFLK_UPDATEDON, '1900-01-01') AS CharacteristicUpdated_On
            , IFNULL(V.SNFLK_UPDATEDON, '1900-01-01') AS MFrpartClassUpdated_On
            , IFNULL(  UPPER(EJU.uom )            , ' ' )  AS UOM
            , IFNULL( UPPER( EJU.uomdesc         ) , '' )  AS UOMDESC
            , IFNULL( EJU.uombase          , 0 )  AS UOMBASE
            , IFNULL(  UPPER(EJU.conversionvalue) , 0 )  AS CONVERSIONVALUE
            , IFNULL( UPPER( EJU.operator        ) , '' )  AS OPERATOR                
        FROM
            SAP.DimManufacturerParts AS MP
            INNER JOIN CONFORMED.SCMDB_Class AS C ON MP.Commodity = C.ClassName        
            LEFT OUTER JOIN CONFORMED.SCMDB_ClassMap AS CM ON C.ClassID = CM.ClassID
            LEFT OUTER JOIN CONFORMED.SCMDB_Characteristic AS CHR ON CM.CharacterID = CHR.CharacterID
            LEFT OUTER JOIN CONFORMED.SCMDB_MFRPartClassMap AS V ON MP.srcMfrPartID = V.MfrPartID
                AND CM.ClassMapID = V.ClassMapID
            LEFT OUTER JOIN CONFORMED.SCMDB_UOM AS EJU ON EJU.uomid = V.UOMID
            LEFT OUTER JOIN CONFORMED.SCMDB_ClassMapValue AS CMV ON V.ClassMapValueID = CMV.ClassMapValueID;
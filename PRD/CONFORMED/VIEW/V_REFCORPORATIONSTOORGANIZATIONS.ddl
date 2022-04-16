create or replace view V_REFCORPORATIONSTOORGANIZATIONS(
	MATERIALGROUPKEY,
	MANUFACTURERKEY,
	SUPPLIERKEY,
	SHIPTOPARTYKEY,
	PAYTOPARTYKEY,
	ORGANIZATIONCODE,
	ORGANIZATIONNAME,
	ORGANIZATIONTYPECODE,
	INCOTERM1,
	INCOTERM2,
	DELETEFLAG,
	MINORITYINDICATOR,
	MINORITYTEXT,
	SRCLASTMODIFIEDDATE,
	DATASOURCEKEY
) as
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into v_RefCorporationsToOrganizations
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-04     SRIDHAR                 Initial Revision            
*/       
	SELECT
    IFNULL(DC.MaterialGroupKey, 0)   AS  MaterialGroupKey
  , IFNULL(DM.ManufacturerKey, 0)    AS  ManufacturerKey 
  , IFNULL(DS.SupplierKey, 0)        AS  SupplierKey 
  , IFNULL(DST.ShipToPartyKey, 0)    AS  ShipToPartyKey 
  , IFNULL(DPT.PayToPartyKey, 0)     AS  PayToPartyKey 
  , TRIM ( IFNULL(CDTO.OrganizationCode,'') )  As OrganizationCode
  , trim( O.OrganizationName ) as OrganizationName
  , trim( ot.OrganizationTypeCode ) as OrganizationTypeCode
  , IFNULL(CDTO.IncoTerm1, '') AS  IncoTerm1 
  , IFNULL(CDTO.IncoTerm2, '') AS  IncoTerm2 
  , CDTO.DeleteFlag
  , IFNULL(CDTO.MinorityIndicator, '') AS  MinorityIndicator 
  , IFNULL(CDTO.MinorityText, '') AS  MinorityText 
  , IFNULL(CDTO.UpdateDTS, '1900-01-01') AS  SrcLastModifiedDate 
  , (SELECT DataSourceKey FROM PUBLIC.DimDataSources WHERE DataSourceName = 'SAP') AS  DataSourceKey 
FROM 
	CONFORMED.SCMDB_CORPORATIONDSTOORGANIZATION AS CDTO
    LEFT OUTER JOIN CONFORMED.SCMDB_Organization AS O ON O.DataSourceID = CDTO.DataSourceID AND O.OrganizationCode = CDTO.OrganizationCode AND O.OrganizationTypeId = CDTO.OrganizationTypeID
    LEFT OUTER JOIN CONFORMED.SCMDB_OrganizationType AS OT ON OT.OrganizationTypeID = CDTO.OrganizationTypeID
    
	INNER JOIN CONFORMED.SCMDB_CORPORATIONDS AS CD ON CD.CorporationDSID = CDTO.CorporationDSID
		AND CD.DataSourceID = CDTO.DataSourceID
	INNER JOIN CONFORMED.SCMDB_CORPORATIONDSTYPE AS CDT ON CDT.CorporationDSTypeID = CD.CorporationDSTypeID
		AND CDT.DataSourceID = CD.DataSourceID
	INNER JOIN CONFORMED.SCMDB_CORPORATIONDSTYPESTD AS CDTS ON CDTS.CorporationDSTypeStdID = CDT.CorporationDSTypeStdID
		AND CDTS.CorporationDSTypeStdCode IN ('Manufacturer', 'MaterialGroup', 'Supplier', 'Ship-To-Party', 'Pay-To-Party')
	LEFT OUTER JOIN SAP.DimMaterialGroups AS DC ON trim(CD.CorporationDSCode ) =trim( DC.MaterialGroupCode)
		AND trim(CDTS.CorporationDSTypeStdCode) = 'MaterialGroup'        
        AND DC.DataSourceKey = 1    --Hardcode for Nyrpo
	LEFT OUTER JOIN SAP.DimManufacturers AS DM ON trim(CD.CorporationDSCode) = trim(DM.ManufacturerCode)
		AND trim(CDTS.CorporationDSTypeStdCode) = 'Manufacturer'
        AND DM.DataSourceKey = 1    --Hardcode for Nyrpo
	LEFT OUTER JOIN SAP.DimSuppliers AS DS ON trim(CD.CorporationDSCode) = trim(DS.SupplierCode)
		AND trim(DS.SupplierTypeCode) = trim(CDT.CorporationDSTypeCode)
		AND CDTS.CorporationDSTypeStdCode = 'Supplier'
        AND DS.DataSourceKey = 1    --Hardcode for Nyrpo
	LEFT OUTER JOIN SAP.DimPayToParties AS DPT ON trim(CD.CorporationDSCode) = trim(DPT.PayToPartyCode)
		AND trim(CDTS.CorporationDSTypeStdCode) = 'Pay-To-Party'
            AND DPT.DataSourceKey = 1 --Hardcode for Nyrpo
	LEFT OUTER JOIN SAP.DimShipToParties AS DST ON trim(CD.CorporationDSCode) = trim(DST.ShipToPartyCode)
		AND trim(CDTS.CorporationDSTypeStdCode) = 'Ship-To-Party'
        AND DST.DataSourceKey = 1   --Hardcode for Nyrpo
WHERE 
    CD.DataSourceID = 6;
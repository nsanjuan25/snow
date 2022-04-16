create or replace view V_FACTSFPROJECTREQUESTS(
	ID,
	SYSTEMMODSTAMP,
	RECORDTYPENAME,
	OWNERNAME,
	NAME,
	LASTMODIFIEDDATE,
	LASTMODIFIEDBYNAME,
	CREATEDDATE,
	CREATEDBYNAME,
	X3CS,
	WINLOSSPRIMARYREASON,
	WINLOSSNOTES,
	TRAVELEXTERNAL,
	TRAVEL,
	TOTALUNIQUELINEITEMSMC,
	TOTALUNIQUELINEITEMSEL,
	TOTALPROJECTCOSTSUPPORTINGSITE,
	TOTALPROJECTCOSTEXTERNAL,
	TOTALPROJECTCOST,
	TOTALPARTSINTERNALLYPRICED,
	TOTALLINES,
	TOTALINVESTMENTAMOUNT,
	TECHNOLOGYINVOLVED,
	TARGETPRODUCTIONSTART,
	TARGETPRODUCTCOST,
	TARGETBOMCOST,
	SUPPORTINGSITETRAVEL,
	SUPPORTINGSITEMATERIALS,
	SUPPORTINGSITELABOR,
	SUPPLYCHAINPROJECTPROGRESS,
	SUBJECTTOEXPORTCONTROL,
	SUBSECTOR,
	STATUS,
	STAGE,
	SPVPERCENTAGEQUOTED,
	SITES,
	SEGMENTLEVEL,
	SEGMENT,
	SECTORINVESTMENTAMOUNT,
	SECTOR,
	SCDMNAME,
	ROISUMMARY,
	RISKSUMMARY,
	RFXRESPONSESCOPE,
	RFQRECEIVED,
	RESPONSEDUE,
	RESPONSEDELIVERED,
	REQUESTEDBYNAME,
	REQUESTED,
	REGULATORYCLASSIFICATION,
	QUALIFIEDSTATUS,
	QUALIFIEDBY,
	QUALIFIED,
	PROPOSALTYPE,
	PROPOSALSCOPE,
	PROPOSALPRIORITY,
	PROPOSALOUTCOME,
	PROJECTSCOPEOFWORK,
	PROJECTOWNERNAME,
	PROJECTNAME,
	PROJECTKICKOFF,
	PROJECTDURATION,
	PROJECTDESCRIPTION,
	PROJECTCOMPLETIONDATE,
	PRODUCTIONSTART,
	PRODUCTSTAGE,
	PRODUCTDESTINATIONSTATE,
	PRODUCTDESTINATIONCOUNTRY,
	PRODUCTDESTINATIONCITY,
	PRIMARYSOURCINGDECISION,
	PPMCOMMITDATE,
	PPMCOMMENTS,
	PEAKREVENUE,
	PCBABUILDSITE,
	PARENTDESIGNOPPORTUNITY,
	OTHERINVESTMENTAMOUNT,
	OPPORTUNITYTYPE,
	OPPORTUNITYSTATUS,
	OPPORTUNITYREFERENCENUMBER,
	OPPORTUNITYNAME,
	OPPORTUNITYCLOSED,
	OPPORTUNITY,
	NEXTDELIVERABLEDUEDATE,
	NEXTDELIVERABLE,
	MEETSJABILDOC00FI1000004FORRD,
	MECHANICALBUILDSITE,
	MATERIALSEXTERNAL,
	MATERIALS,
	MATERIALSUBMITTALTOBU,
	MAINACEPILLAR,
	LOSSPRIMARYREASON,
	LEADSITE,
	LASTACTIVITYDATE,
	LABOREXTERNAL,
	LABOR,
	JHETSALESSPONSOR,
	INVESTMENTTYPE,
	INVESTMENTSTARTS,
	INVESTMENTENDS,
	HOURSTOQUOTE,
	FUNCTIONALSAFETYLEVEL,
	EXPORTCONTROLCLASSIFICATIONNUMBER,
	EXPECTEDPRODUCTLIFE,
	EXECUTIVESPONSORNAME,
	ESTIMATEDMANUFACTURINGREVENUEYEAR3,
	ESTIMATEDMANUFACTURINGREVENUEYEAR2,
	ESTIMATEDMANUFACTURINGREVENUEYEAR1,
	ESTIMATEDMANUFACTURINGREVENUEY4PLUS,
	ENGAGEMENTMODEL,
	EAUREMAININGYEARS,
	EARLYACCESSPARTNER,
	DIVISIONINVESTMENTAMOUNT,
	DIVISION,
	DIIQUOTED,
	DESIGNWINPROBABILITY,
	DESIGNRESPONSETYPE,
	DESIGNRESPONSEDETAILS,
	CUSTOMERRANDDLOCATION,
	CUSTOMERRANDDCITY,
	CUSTOMERNAME,
	CUSTOMERCONFIDENTIAL,
	CUSTOMERBILLABLE,
	CSDSCORE,
	COREPRIORITY,
	CONFIRMEDMATERIALREVENUE,
	CONFIDENTIALITYLEVEL,
	COMMITDATE,
	CLOSEDATE,
	BUSINESSLEADCONTACTNAME,
	BUINVESTMENTAMOUNT,
	BENEFITINGSITES,
	ALTERNATESOURCING,
	ACCOUNTPARENTACCOUNTNAME,
	ACCOUNTNAME,
	ACCOUNT,
	FRMWEXTRACTEDON,
	HASHVALUE
) as
SELECT
   Id
  ,SystemModStamp
  ,RecordTypeName
  ,OwnerName
  ,Name
  ,LastModifiedDate
  ,LastModifiedByName
  ,CreatedDate
  ,CreatedByName
  ,X3Cs
  ,WinLossPrimaryReason
  ,WinLossNotes
  ,TravelExternal
  ,Travel
  ,TotalUniqueLineItemsMC
  ,TotalUniqueLineItemsEL
  ,TotalProjectCostSupportingSite
  ,TotalProjectCostExternal
  ,TotalProjectCost
  ,TotalPartsInternallyPriced
  ,TotalLines
  ,TotalInvestmentAmount
  ,TechnologyInvolved
  ,TargetProductionStart
  ,TargetProductCost
  ,TargetBOMCost
  ,SupportingSiteTravel
  ,SupportingSiteMaterials
  ,SupportingSiteLabor
  ,SupplyChainProjectProgress
  ,SubjecttoExportControl
  ,SubSector
  ,Status
  ,Stage
  ,SPVPercentageQuoted
  ,Sites
  ,SegmentLevel
  ,Segment
  ,SectorInvestmentAmount
  ,Sector
  ,SCDMName
  ,ROISummary
  ,RiskSummary
  ,RFxResponseScope
  ,RFQReceived
  ,ResponseDue
  ,ResponseDelivered
  ,RequestedByName
  ,Requested
  ,RegulatoryClassification
  ,QualifiedStatus
  ,QualifiedBy
  ,Qualified
  ,ProposalType
  ,ProposalScope
  ,ProposalPriority
  ,ProposalOutcome
  ,ProjectScopeofWork
  ,ProjectOwnerName
  ,ProjectName
  ,ProjectKickoff
  ,ProjectDuration
  ,ProjectDescription
  ,ProjectCompletionDate
  ,ProductionStart
  ,ProductStage
  ,ProductDestinationState
  ,ProductDestinationCountry
  ,ProductDestinationCity
  ,PrimarySourcingDecision
  ,PPMCommitDate
  ,PPMComments
  ,PeakRevenue
  ,PCBABuildSite
  ,ParentDesignOpportunity
  ,OtherInvestmentAmount
  ,OpportunityType
  ,OpportunityStatus
  ,OpportunityReferenceNumber
  ,OpportunityName
  ,OpportunityClosed
  ,Opportunity
  ,NextDeliverableDueDate
  ,NextDeliverable
  ,MeetsJabilDoc00FI1000004forRD
  ,MechanicalBuildSite
  ,MaterialsExternal
  ,Materials
  ,MaterialSubmittaltoBU
  ,MainACEPillar
  ,LossPrimaryReason
  ,LeadSite
  ,LastActivityDate
  ,LaborExternal
  ,Labor
  ,JHETSalesSponsor
  ,InvestmentType
  ,InvestmentStarts
  ,InvestmentEnds
  ,HourstoQuote
  ,FunctionalSafetyLevel
  ,ExportControlClassificationNumber
  ,ExpectedProductLife
  ,ExecutiveSponsorName
  ,EstimatedManufacturingRevenueYear3
  ,EstimatedManufacturingRevenueYear2
  ,EstimatedManufacturingRevenueYear1
  ,EstimatedManufacturingRevenueY4Plus
  ,EngagementModel
  ,EAURemainingYears
  ,EarlyAccessPartner
  ,DivisionInvestmentAmount
  ,Division
  ,DIIQuoted
  ,DesignWinProbability
  ,DesignResponseType
  ,DesignResponseDetails
  ,CustomerRandDLocation
  ,CustomerRandDCity
  ,CustomerName
  ,CustomerConfidential
  ,CustomerBillable
  ,CSDScore
  ,CorePriority
  ,ConfirmedMaterialRevenue
  ,ConfidentialityLevel
  ,CommitDate
  ,CloseDate
  ,BusinessLeadContactName
  ,BUInvestmentAmount
  ,BenefitingSites
  ,AlternateSourcing
  ,AccountParentAccountName
  ,AccountName
  ,Account
  ,FRMWEXTRACTEDON
  ,HASH(
         SystemModStamp
        ,RecordTypeName
        ,OwnerName
        ,Name
        ,LastModifiedDate
        ,LastModifiedByName
        ,CreatedDate
        ,CreatedByName
        ,X3Cs
        ,WinLossPrimaryReason
        ,WinLossNotes
        ,TravelExternal
        ,Travel
        ,TotalUniqueLineItemsMC
        ,TotalUniqueLineItemsEL
        ,TotalProjectCostSupportingSite
        ,TotalProjectCostExternal
        ,TotalProjectCost
        ,TotalPartsInternallyPriced
        ,TotalLines
        ,TotalInvestmentAmount
        ,TechnologyInvolved
        ,TargetProductionStart
        ,TargetProductCost
        ,TargetBOMCost
        ,SupportingSiteTravel
        ,SupportingSiteMaterials
        ,SupportingSiteLabor
        ,SupplyChainProjectProgress
        ,SubjecttoExportControl
        ,SubSector
        ,Status
        ,Stage
        ,SPVPercentageQuoted
        ,Sites
        ,SegmentLevel
        ,Segment
        ,SectorInvestmentAmount
        ,Sector
        ,SCDMName
        ,ROISummary
        ,RiskSummary
        ,RFxResponseScope
        ,RFQReceived
        ,ResponseDue
        ,ResponseDelivered
        ,RequestedByName
        ,Requested
        ,RegulatoryClassification
        ,QualifiedStatus
        ,QualifiedBy
        ,Qualified
        ,ProposalType
        ,ProposalScope
        ,ProposalPriority
        ,ProposalOutcome
        ,ProjectScopeofWork
        ,ProjectOwnerName
        ,ProjectName
        ,ProjectKickoff
        ,ProjectDuration
        ,ProjectDescription
        ,ProjectCompletionDate
        ,ProductionStart
        ,ProductStage
        ,ProductDestinationState
        ,ProductDestinationCountry
        ,ProductDestinationCity
        ,PrimarySourcingDecision
        ,PPMCommitDate
        ,PPMComments
        ,PeakRevenue
        ,PCBABuildSite
        ,ParentDesignOpportunity
        ,OtherInvestmentAmount
        ,OpportunityType
        ,OpportunityStatus
        ,OpportunityReferenceNumber
        ,OpportunityName
        ,OpportunityClosed
        ,Opportunity
        ,NextDeliverableDueDate
        ,NextDeliverable
        ,MeetsJabilDoc00FI1000004forRD
        ,MechanicalBuildSite
        ,MaterialsExternal
        ,Materials
        ,MaterialSubmittaltoBU
        ,MainACEPillar
        ,LossPrimaryReason
        ,LeadSite
        ,LastActivityDate
        ,LaborExternal
        ,Labor
        ,JHETSalesSponsor
        ,InvestmentType
        ,InvestmentStarts
        ,InvestmentEnds
        ,HourstoQuote
        ,FunctionalSafetyLevel
        ,ExportControlClassificationNumber
        ,ExpectedProductLife
        ,ExecutiveSponsorName
        ,EstimatedManufacturingRevenueYear3
        ,EstimatedManufacturingRevenueYear2
        ,EstimatedManufacturingRevenueYear1
        ,EstimatedManufacturingRevenueY4Plus
        ,EngagementModel
        ,EAURemainingYears
        ,EarlyAccessPartner
        ,DivisionInvestmentAmount
        ,Division
        ,DIIQuoted
        ,DesignWinProbability
        ,DesignResponseType
        ,DesignResponseDetails
        ,CustomerRandDLocation
        ,CustomerRandDCity
        ,CustomerName
        ,CustomerConfidential
        ,CustomerBillable
        ,CSDScore
        ,CorePriority
        ,ConfirmedMaterialRevenue
        ,ConfidentialityLevel
        ,CommitDate
        ,CloseDate
        ,BusinessLeadContactName
        ,BUInvestmentAmount
        ,BenefitingSites
        ,AlternateSourcing
        ,AccountParentAccountName
        ,AccountName
        ,Account
      ) 					As HashValue
FROM
	(
		SELECT
           RTRIM(id)							        AS ID
          ,CAST(CASE WHEN IFNULL(SYSTEMMODSTAMP,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE SYSTEMMODSTAMP
           END AS TIMESTAMP_NTZ(9))                   AS SystemModStamp
          ,RECORDTYPE_NAME                            AS RecordTypeName
          ,OWNER_NAME                                 AS OwnerName
          ,NAME                                       AS Name
          ,CAST(CASE WHEN IFNULL(LASTMODIFIEDDATE,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE LASTMODIFIEDDATE
           END AS TIMESTAMP_NTZ(9))                   AS LastModifiedDate
          ,LASTMODIFIEDBY_NAME                        AS LastModifiedByName
          ,CAST(CASE WHEN IFNULL(CREATEDDATE,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE CREATEDDATE
           END AS TIMESTAMP_NTZ(9))                   AS CreatedDate
          ,CREATEDBY_NAME                             AS CreatedByName
          ,X3CS                                       AS X3Cs
          ,WIN_LOSS_PRIMARY_REASON                    AS WinLossPrimaryReason
          ,WIN_LOSS_NOTES                             AS WinLossNotes
          ,CAST( CASE WHEN TRAVEL_EXTERNAL IS NULL THEN 0
					WHEN TRAVEL_EXTERNAL = 'NULL' THEN 0
					WHEN TRAVEL_EXTERNAL = '' THEN 0
					ELSE TRAVEL_EXTERNAL
		   END AS DECIMAL(18,2))					  AS TravelExternal
		   ,CAST( CASE WHEN TRAVEL IS NULL THEN 0
					WHEN TRAVEL = 'NULL' THEN 0
					WHEN TRAVEL = '' THEN 0
					ELSE TRAVEL
		   END AS DECIMAL(18,2))					  AS Travel
		  ,CAST( CASE WHEN TOTAL_UNIQUE_LINE_ITEMS_MC IS NULL THEN 0
					WHEN TOTAL_UNIQUE_LINE_ITEMS_MC = 'NULL' THEN 0
					WHEN TOTAL_UNIQUE_LINE_ITEMS_MC = '' THEN 0
					ELSE TOTAL_UNIQUE_LINE_ITEMS_MC
           END AS NUMBER(38,0))					  	  AS TotalUniqueLineItemsMC
		  ,CAST( CASE WHEN TOTAL_UNIQUE_LINE_ITEMS_EL IS NULL THEN 0
					WHEN TOTAL_UNIQUE_LINE_ITEMS_EL = 'NULL' THEN 0
					WHEN TOTAL_UNIQUE_LINE_ITEMS_EL = '' THEN 0
					ELSE TOTAL_UNIQUE_LINE_ITEMS_EL
		   END AS NUMBER(38,0))					  	  AS TotalUniqueLineItemsEL
		  ,CAST( CASE WHEN TOTAL_PROJECT_COST_SUPPORTING_SITE IS NULL THEN 0
					WHEN TOTAL_PROJECT_COST_SUPPORTING_SITE = 'NULL' THEN 0
					WHEN TOTAL_PROJECT_COST_SUPPORTING_SITE = '' THEN 0
					ELSE TOTAL_PROJECT_COST_SUPPORTING_SITE
		   END AS NUMBER(38,0))					  	  AS TotalProjectCostSupportingSite
		  ,CAST( CASE WHEN TOTAL_PROJECT_COST_EXTERNAL IS NULL THEN 0
					WHEN TOTAL_PROJECT_COST_EXTERNAL = 'NULL' THEN 0
					WHEN TOTAL_PROJECT_COST_EXTERNAL = '' THEN 0
					ELSE TOTAL_PROJECT_COST_EXTERNAL
		   END AS DECIMAL(18,2))					  AS TotalProjectCostExternal
		  ,CAST( CASE WHEN TOTAL_PROJECT_COST IS NULL THEN 0
					WHEN TOTAL_PROJECT_COST = 'NULL' THEN 0
					WHEN TOTAL_PROJECT_COST = '' THEN 0
					ELSE TOTAL_PROJECT_COST
		   END AS DECIMAL(18,2))					  AS TotalProjectCost
		  ,CAST( CASE WHEN TOTAL_PARTS_INTERNALLY_PRICED IS NULL THEN 0
					WHEN TOTAL_PARTS_INTERNALLY_PRICED = 'NULL' THEN 0
					WHEN TOTAL_PARTS_INTERNALLY_PRICED = '' THEN 0
					ELSE TOTAL_PARTS_INTERNALLY_PRICED
		   END AS NUMBER(38,0))					  	  AS TotalPartsInternallyPriced
		  ,CAST( CASE WHEN TOTAL_LINES IS NULL THEN 0
					WHEN TOTAL_LINES = 'NULL' THEN 0
					WHEN TOTAL_LINES = '' THEN 0
					ELSE TOTAL_LINES
		   END AS NUMBER(38,0))					  	  AS TotalLines
		  ,CAST( CASE WHEN TOTAL_INVESTMENT_AMOUNT IS NULL THEN 0
					WHEN TOTAL_INVESTMENT_AMOUNT = 'NULL' THEN 0
					WHEN TOTAL_INVESTMENT_AMOUNT = '' THEN 0
					ELSE TOTAL_INVESTMENT_AMOUNT
		   END AS DECIMAL(18,2))					  AS TotalInvestmentAmount
          ,TECHNOLOGY_INVOLVED                        AS TechnologyInvolved
          ,CAST(CASE WHEN IFNULL(TARGET_PRODUCTION_START,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE TARGET_PRODUCTION_START
           END AS TIMESTAMP_NTZ(9))                 AS TargetProductionStart
		  ,CAST( CASE WHEN TARGET_PRODUCT_COST IS NULL THEN 0
					WHEN TARGET_PRODUCT_COST = 'NULL' THEN 0
					WHEN TARGET_PRODUCT_COST = '' THEN 0
					ELSE TARGET_PRODUCT_COST
		   END AS DECIMAL(18,2))					  AS TargetProductCost
		  ,CAST( CASE WHEN TARGET_BOM_COST IS NULL THEN 0
					WHEN TARGET_BOM_COST = 'NULL' THEN 0
					WHEN TARGET_BOM_COST = '' THEN 0
					ELSE TARGET_BOM_COST
		   END AS DECIMAL(18,2))					  AS TargetBOMCost
		  ,CAST( CASE WHEN SUPPORTING_SITE_TRAVEL IS NULL THEN 0
					WHEN SUPPORTING_SITE_TRAVEL = 'NULL' THEN 0
					WHEN SUPPORTING_SITE_TRAVEL = '' THEN 0
					ELSE SUPPORTING_SITE_TRAVEL
		   END AS NUMBER(38,0))					  	  AS SupportingSiteTravel
		  ,CAST( CASE WHEN SUPPORTING_SITE_MATERIALS IS NULL THEN 0
					WHEN SUPPORTING_SITE_MATERIALS = 'NULL' THEN 0
					WHEN SUPPORTING_SITE_MATERIALS = '' THEN 0
					ELSE SUPPORTING_SITE_MATERIALS
		   END AS NUMBER(38,0))					  	  AS SupportingSiteMaterials
		  ,CAST( CASE WHEN SUPPORTING_SITE_LABOR IS NULL THEN 0
					WHEN SUPPORTING_SITE_LABOR = 'NULL' THEN 0
					WHEN SUPPORTING_SITE_LABOR = '' THEN 0
					ELSE SUPPORTING_SITE_LABOR
		   END AS NUMBER(38,0))					  	  AS SupportingSiteLabor
          ,SUPPLY_CHAIN_PROJECT_PROGRESS              AS SupplyChainProjectProgress
          ,SUBJECT_TO_EXPORT_CONTROL                  AS SubjectToExportControl
          ,SUB_SECTOR                                 AS SubSector
          ,STATUS                                     AS Status
          ,STAGE                                      AS Stage
		  ,CAST( CASE WHEN SPV_PERCENTAGE_QUOTED IS NULL THEN 0
					WHEN SPV_PERCENTAGE_QUOTED = 'NULL' THEN 0
					WHEN SPV_PERCENTAGE_QUOTED = '' THEN 0
					ELSE SPV_PERCENTAGE_QUOTED
		   END AS DECIMAL(18,2))					  AS SPVPercentageQuoted
          ,SITES                                      AS Sites
          ,SEGMENT_LEVEL                              AS SegmentLevel
          ,SEGMENT                                    AS Segment
		  ,CAST( CASE WHEN SECTOR_INVESTMENT_AMOUNT IS NULL THEN 0
					WHEN SECTOR_INVESTMENT_AMOUNT = 'NULL' THEN 0
					WHEN SECTOR_INVESTMENT_AMOUNT = '' THEN 0
					ELSE SECTOR_INVESTMENT_AMOUNT
		   END AS DECIMAL(18,2))					  AS SectorInvestmentAmount
          ,SECTOR                                     AS Sector
          ,SCDM_NAME                                  AS SCDMName
          ,ROI_SUMMARY                                AS ROISummary
          ,RISK_SUMMARY                               AS RiskSummary
          ,RFX_RESPONSE_SCOPE                         AS RFxResponseScope
          ,CAST(CASE WHEN IFNULL(RFQ_RECEIVED,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE RFQ_RECEIVED
           END AS TIMESTAMP_NTZ(9))                   AS RFQReceived
          ,CAST(CASE WHEN IFNULL(RESPONSE_DUE,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE RESPONSE_DUE
           END AS TIMESTAMP_NTZ(9))                   AS ResponseDue
          ,CAST(CASE WHEN IFNULL(RESPONSE_DELIVERED,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE RESPONSE_DELIVERED
           END AS TIMESTAMP_NTZ(9))                   AS ResponseDelivered
          ,REQUESTED_BY_NAME                          AS RequestedByName
          ,CAST(CASE WHEN IFNULL(REQUESTED,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE REQUESTED
           END AS TIMESTAMP_NTZ(9))                   AS Requested
          ,REGULATORY_CLASSIFICATION                  AS RegulatoryClassification
          ,QUALIFIED_STATUS                           AS QualifiedStatus
          ,QUALIFIED_BY                               AS QualifiedBy
          ,CAST(CASE WHEN IFNULL(QUALIFIED,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE QUALIFIED
           END AS TIMESTAMP_NTZ(9))                   AS Qualified
          ,PROPOSAL_TYPE                              AS ProposalType
          ,PROPOSAL_SCOPE                             AS ProposalScope
          ,PROPOSAL_PRIORITY                          AS ProposalPriority
          ,PROPOSAL_OUTCOME                           AS ProposalOutcome
          ,PROJECT_SCOPE_OF_WORK                      AS ProjectScopeOfWork
          ,PROJECT_OWNER_NAME                         AS ProjectOwnerName
          ,PROJECT_NAME                               AS ProjectName
          ,CAST(CASE WHEN IFNULL(PROJECT_KICKOFF,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE PROJECT_KICKOFF
           END AS TIMESTAMP_NTZ(9))                   AS ProjectKickoff
		  ,CAST( CASE WHEN PROJECT_DURATION IS NULL THEN 0
					WHEN PROJECT_DURATION = 'NULL' THEN 0
					WHEN PROJECT_DURATION = '' THEN 0
					ELSE PROJECT_DURATION
		   END AS DECIMAL(18,2))					  AS ProjectDuration
          ,PROJECT_DESCRIPTION                        AS ProjectDescription
          ,PROJECT_COMPLETION_DATE                    AS ProjectCompletionDate
          ,CAST(CASE WHEN IFNULL(PRODUCTION_START,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE PRODUCTION_START
           END AS TIMESTAMP_NTZ(9))                   AS ProductionStart
          ,PRODUCT_STAGE                              AS ProductStage
          ,PRODUCT_DESTINATION_STATE                  AS ProductDestinationState
          ,PRODUCT_DESTINATION_COUNTRY                AS ProductDestinationCountry
          ,PRODUCT_DESTINATION_CITY                   AS ProductDestinationCity
          ,PRIMARY_SOURCING_DECISION                  AS PrimarySourcingDecision
          ,CAST(CASE WHEN IFNULL(PPM_COMMIT_DATE,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE PPM_COMMIT_DATE
           END AS TIMESTAMP_NTZ(9))                   AS PPMCommitDate
          ,PPM_COMMENTS                               AS PPMComments
		  ,CAST( CASE WHEN PEAK_REVENUE IS NULL THEN 0
					WHEN PEAK_REVENUE = 'NULL' THEN 0
					WHEN PEAK_REVENUE = '' THEN 0
					ELSE PEAK_REVENUE
		   END AS DECIMAL(18,2))					  AS PeakRevenue
          ,PCBA_BUILD_SITE                            AS PCBABuildSite
          ,PARENT_DESIGN_OPPORTUNITY                  AS ParentDesignOpportunity
		  ,CAST( CASE WHEN OTHER_INVESTMENT_AMOUNT IS NULL THEN 0
					WHEN OTHER_INVESTMENT_AMOUNT = 'NULL' THEN 0
					WHEN OTHER_INVESTMENT_AMOUNT = '' THEN 0
					ELSE OTHER_INVESTMENT_AMOUNT
		   END AS DECIMAL(18,2))					  AS OtherInvestmentAmount
          ,OPPORTUNITY_TYPE                           AS OpportunityType
          ,OPPORTUNITY_STATUS                         AS OpportunityStatus
		  ,CAST( CASE WHEN OPPORTUNITY_REFERENCE_NUMBER IS NULL THEN 0
					WHEN OPPORTUNITY_REFERENCE_NUMBER = 'NULL' THEN 0
					WHEN OPPORTUNITY_REFERENCE_NUMBER = '' THEN 0
					ELSE OPPORTUNITY_REFERENCE_NUMBER
		   END AS NUMBER(38,0))					  	  AS OpportunityReferenceNumber
          ,OPPORTUNITY_NAME                           AS OpportunityName
          ,OPPORTUNITY_CLOSED                         AS OpportunityClosed
          ,OPPORTUNITY                                AS Opportunity
          ,CAST(CASE WHEN IFNULL(NEXT_DELIVERABLE_DUE_DATE,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE NEXT_DELIVERABLE_DUE_DATE
           END AS TIMESTAMP_NTZ(9))                   AS NextDeliverableDueDate
          ,NEXT_DELIVERABLE                           AS NextDeliverable
          ,MEETS_JABIL_DOC_00_FI10_00004_FOR_R_D      AS MeetsJabilDoc00FI1000004forRD
          ,MECHANICAL_BUILD_SITE                      AS MechanicalBuildSite
		  ,CAST( CASE WHEN MATERIALS_EXTERNAL IS NULL THEN 0
					WHEN MATERIALS_EXTERNAL = 'NULL' THEN 0
					WHEN MATERIALS_EXTERNAL = '' THEN 0
					ELSE MATERIALS_EXTERNAL
		   END AS DECIMAL(18,2))					  AS MaterialsExternal
		  ,CAST( CASE WHEN MATERIALS IS NULL THEN 0
					WHEN MATERIALS = 'NULL' THEN 0
					WHEN MATERIALS = '' THEN 0
					ELSE MATERIALS
		   END AS DECIMAL(18,2))					  AS Materials
          ,CAST(CASE WHEN IFNULL(MATERIAL_SUBMITTAL_TO_BU,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE MATERIAL_SUBMITTAL_TO_BU
           END AS TIMESTAMP_NTZ(9))                   AS MaterialSubmittaltoBU
          ,MAIN_ACE_PILLAR                            AS MainACEPillar
          ,LOSS_PRIMARY_REASON                        AS LossPrimaryReason
          ,LEAD_SITE                                  AS LeadSite
          ,CAST(CASE WHEN IFNULL(LASTACTIVITYDATE,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE LASTACTIVITYDATE
           END AS TIMESTAMP_NTZ(9))                   AS LastActivityDate
		  ,CAST( CASE WHEN LABOR_EXTERNAL IS NULL THEN 0
					WHEN LABOR_EXTERNAL = 'NULL' THEN 0
					WHEN LABOR_EXTERNAL = '' THEN 0
					ELSE LABOR_EXTERNAL
		   END AS DECIMAL(18,2))					  AS LaborExternal
		  ,CAST( CASE WHEN LABOR IS NULL THEN 0
					WHEN LABOR = 'NULL' THEN 0
					WHEN LABOR = '' THEN 0
					ELSE LABOR
		   END AS DECIMAL(18,2))					  AS Labor
          ,JHET_SALES_SPONSOR                         AS JHETSalesSponsor
          ,INVESTMENT_TYPE                            AS InvestmentType
          ,CAST(CASE WHEN IFNULL(INVESTMENT_STARTS,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE INVESTMENT_STARTS
           END AS TIMESTAMP_NTZ(9))                   AS InvestmentStarts
          ,CAST(CASE WHEN IFNULL(INVESTMENT_ENDS,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE INVESTMENT_ENDS
           END AS TIMESTAMP_NTZ(9))                   AS InvestmentEnds
		  ,CAST( CASE WHEN HOURS_TO_QUOTE IS NULL THEN 0
					WHEN HOURS_TO_QUOTE = 'NULL' THEN 0
					WHEN HOURS_TO_QUOTE = '' THEN 0
					ELSE HOURS_TO_QUOTE
		   END AS NUMBER(38,0))					  	  AS HoursToQuote
          ,FUNCTIONAL_SAFETY_LEVEL                    AS FunctionalSafetyLevel
          ,EXPORT_CONTROL_CLASSIFICATION_NUMBER       AS ExportControlClassificationNumber
          ,EXPECTED_PRODUCT_LIFE                      AS ExpectedProductLife
          ,EXECUTIVE_SPONSOR_NAME                     AS ExecutiveSponsorName
		  ,CAST( CASE WHEN ESTIMATED_MANUFACTURING_REVENUE_YEAR_3 IS NULL THEN 0
					WHEN ESTIMATED_MANUFACTURING_REVENUE_YEAR_3 = 'NULL' THEN 0
					WHEN ESTIMATED_MANUFACTURING_REVENUE_YEAR_3 = '' THEN 0
					ELSE ESTIMATED_MANUFACTURING_REVENUE_YEAR_3
		   END AS NUMBER(38,0))					  	  AS EstimatedManufacturingRevenueYear3
		  ,CAST( CASE WHEN ESTIMATED_MANUFACTURING_REVENUE_YEAR_2 IS NULL THEN 0
					WHEN ESTIMATED_MANUFACTURING_REVENUE_YEAR_2 = 'NULL' THEN 0
					WHEN ESTIMATED_MANUFACTURING_REVENUE_YEAR_2 = '' THEN 0
					ELSE ESTIMATED_MANUFACTURING_REVENUE_YEAR_2
		   END AS NUMBER(38,0))					  	  AS EstimatedManufacturingRevenueYear2
		  ,CAST( CASE WHEN ESTIMATED_MANUFACTURING_REVENUE_YEAR_1 IS NULL THEN 0
					WHEN ESTIMATED_MANUFACTURING_REVENUE_YEAR_1 = 'NULL' THEN 0
					WHEN ESTIMATED_MANUFACTURING_REVENUE_YEAR_1 = '' THEN 0
					ELSE ESTIMATED_MANUFACTURING_REVENUE_YEAR_1
		   END AS NUMBER(38,0))					  	  AS EstimatedManufacturingRevenueYear1
		  ,CAST( CASE WHEN ESTIMATED_MANUFACTURING_REVENUE_Y4_PLUS IS NULL THEN 0
					WHEN ESTIMATED_MANUFACTURING_REVENUE_Y4_PLUS = 'NULL' THEN 0
					WHEN ESTIMATED_MANUFACTURING_REVENUE_Y4_PLUS = '' THEN 0
					ELSE ESTIMATED_MANUFACTURING_REVENUE_Y4_PLUS
		   END AS NUMBER(38,0))					  	  AS EstimatedManufacturingRevenueY4Plus
          ,ENGAGEMENT_MODEL                           AS EngagementModel
		  ,CAST( CASE WHEN EAU_REMAINING_YEARS IS NULL THEN 0
					WHEN EAU_REMAINING_YEARS = 'NULL' THEN 0
					WHEN EAU_REMAINING_YEARS = '' THEN 0
					ELSE EAU_REMAINING_YEARS
		   END AS NUMBER(38,0))					  	  AS EAURemainingYears
          ,EARLY_ACCESS_PARTNER                       AS EarlyAccessPartner
		  ,CAST( CASE WHEN DIVISION_INVESTMENT_AMOUNT IS NULL THEN 0
					WHEN DIVISION_INVESTMENT_AMOUNT = 'NULL' THEN 0
					WHEN DIVISION_INVESTMENT_AMOUNT = '' THEN 0
					ELSE DIVISION_INVESTMENT_AMOUNT
		   END AS DECIMAL(18,2))					  AS DivisionInvestmentAmount
          ,DIVISION                                   AS Division
		  ,CAST( CASE WHEN DII_QUOTED IS NULL THEN 0
					WHEN DII_QUOTED = 'NULL' THEN 0
					WHEN DII_QUOTED = '' THEN 0
					ELSE DII_QUOTED
		   END AS NUMBER(38,0))					  	  AS DIIQuoted
		  ,CAST( CASE WHEN DESIGN_WIN_PROBABILITY IS NULL THEN 0
					WHEN DESIGN_WIN_PROBABILITY = 'NULL' THEN 0
					WHEN DESIGN_WIN_PROBABILITY = '' THEN 0
					ELSE DESIGN_WIN_PROBABILITY
		   END AS NUMBER(38,0))					  	  AS DesignWinProbability
          ,DESIGN_RESPONSE_TYPE                       AS DesignResponseType
          ,DESIGN_RESPONSE_DETAILS                    AS DesignResponseDetails
          ,CUSTOMER_R_AND_D_LOCATION                  AS CustomerRandDLocation
          ,CUSTOMER_R_AND_D_CITY                      AS CustomerRandDCity
          ,CUSTOMER_NAME                              AS CustomerName
          ,CUSTOMER_CONFIDENTIAL                      AS CustomerConfidential
          ,CUSTOMER_BILLABLE                          AS CustomerBillable
		  ,CAST( CASE WHEN CSD_SCORE IS NULL THEN 0
					WHEN CSD_SCORE = 'NULL' THEN 0
					WHEN CSD_SCORE = '' THEN 0
					ELSE CSD_SCORE
		   END AS NUMBER(38,0))					  	  AS CSDScore
          ,CORE_PRIORITY                              AS CorePriority
		  ,CAST( CASE WHEN CONFIRMED_MATERIAL_REVENUE IS NULL THEN 0
					WHEN CONFIRMED_MATERIAL_REVENUE = 'NULL' THEN 0
					WHEN CONFIRMED_MATERIAL_REVENUE = '' THEN 0
					ELSE CONFIRMED_MATERIAL_REVENUE
		   END AS DECIMAL(18,2))					  AS ConfirmedMaterialRevenue
          ,CONFIDENTIALITY_LEVEL                      AS ConfidentialityLevel
          ,CAST(CASE WHEN IFNULL(COMMIT_DATE,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE COMMIT_DATE
           END AS TIMESTAMP_NTZ(9))                   AS CommitDate    
          ,CAST(CASE WHEN IFNULL(CLOSE_DATE,'') = '' THEN '1900-01-01 00:00:00.000'
                  ELSE CLOSE_DATE
           END AS TIMESTAMP_NTZ(9))                   AS CloseDate
          ,BUSINESS_LEAD_CONTACT_NAME                 AS BusinessLeadContactName
		  ,CAST( CASE WHEN BU_INVESTMENT_AMOUNT IS NULL THEN 0
					WHEN BU_INVESTMENT_AMOUNT = 'NULL' THEN 0
					WHEN BU_INVESTMENT_AMOUNT = '' THEN 0
					ELSE BU_INVESTMENT_AMOUNT
		   END AS DECIMAL(18,2))					  AS BUInvestmentAmount
          ,BENEFITING_SITES                           AS BenefitingSites
          ,ALTERNATE_SOURCING                         AS AlternateSourcing
          ,ACCOUNT_PARENT_ACCOUNT_NAME                AS AccountParentAccountName
          ,ACCOUNT_NAME                               AS AccountName
          ,ACCOUNT                                    AS Account
          ,FRMW_EXTRACTED_ON					      AS FRMWEXTRACTEDON  
          ,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY FRMW_EXTRACTED_ON DESC) AS RowNum
      FROM CONFORMED.SF_PROJECTREQUESTS
) AS A WHERE A.RowNum = 1;
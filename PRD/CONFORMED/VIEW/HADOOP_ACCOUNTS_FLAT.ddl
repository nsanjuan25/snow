create or replace view HADOOP_ACCOUNTS_FLAT(
	ACCOUNT,
	HIERARCHY
) as

/*--------------------------------------------------------------------------------------------

 

This view is used to insert data into TM1.DimTM1Accountflat

----------------------------------------------------------------------------------------------

Revision History

----------------------------------------------------------------------------------------------

Date            Developer               Comments

----------------------------------------------------------------------------------------------

2021-09-24      Lakshman               Initial Revision

*/


WITH Hadoop_Accounts AS (
    SELECT
        Account
        , Hierarchy
    FROM
        TM1.DimTM1AccountHierarchy a
    WHERE
        A.Hierarchy IN (
              'Reporting Hierarchies||Account Analytics||Dollars||Customer Owned BS Line Items||ROIC Total Net Assets (Less Customer Gear)'
            , 'Reporting Hierarchies||Account Analytics||Dollars||Free Cash Flow'
            , 'Reporting Hierarchies||Account Analytics||Dollars||Material Price Variance'
            , 'Reporting Hierarchies||Account Analytics||Dollars||Operational Cash Flow (Less Customer Gear)||Total Capex (Less Customer Gear)'
            , 'Reporting Hierarchies||Account Analytics||Dollars||RapidResponse'
            , 'Reporting Hierarchies||Account Analytics||Dollars||Total Exs and Obs Inventory||Total Inventory Exs'
            , 'Reporting Hierarchies||Account Analytics||Dollars||Total Exs and Obs Inventory||Total Inventory Obs'
            , 'Reporting Hierarchies||Account Analytics||Dollars||Total MFG and SGA'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||Direct Labor Headcount'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||IL Headcount||Workcell Staff Headcount'
            , 'Reporting Hierarchies||Account Analytics||Rates||Total IL Rates||Total Workcell GP Rate||Core Workcell GP Rate||PC Analysts Rate'
            , 'Reporting Hierarchies||Account Analytics||Rates||Total IL Rates||Workcell Staff DF Rate||Materials Management DF Rate||Buyers DF Tier 2 Rate'
            , 'Reporting Hierarchies||Account Analytics||Rates||Total IL Rates||Workcell Staff DF Rate||Materials Management DF Rate||Materials Supervisors DF Tier 1 Rate'
            , 'Reporting Hierarchies||Account Analytics||Rates||Total IL Rates||Workcell Staff DF Rate||Materials Management DF Rate||PC Analysts DF Rate'
            , 'Reporting Hierarchies||Account Analytics||Rates||Total IL Rates||Workcell Staff Mfg Rate||Materials Management Mfg Rate||Buyers Mfg Tier 2 Rate'
            , 'Reporting Hierarchies||Account Analytics||Rates||Total IL Rates||Workcell Staff Mfg Rate||Materials Management Mfg Rate||Materials Supervisors Mfg Tier 1 Rate'
            , 'Reporting Hierarchies||Cash Cycle BI||Total Net Assets||Net Working Capital||Contract Asset'
            , 'Reporting Hierarchies||Cash Cycle BI||Total Net Assets||Net Working Capital||Contract Asset||T127000||127000'
            , 'Reporting Hierarchies||MPV Reporting BI||MPV Material Cost'
            , 'Reporting Hierarchies||Standard P&L Line Items||Accounts Payable'
            , 'Reporting Hierarchies||Standard P&L Line Items||Bill of Materials'
            , 'Reporting Hierarchies||Standard P&L Line Items||Corp Adj Net Core Op Income'
            , 'Reporting Hierarchies||Standard P&L Line Items||Cost of Materials'
            , 'Reporting Hierarchies||Standard P&L Line Items||Fixed Expenses'
            , 'Reporting Hierarchies||Standard P&L Line Items||Manufacturing Cost'
            , 'Reporting Hierarchies||Standard P&L Line Items||Manufacturing Overhead||Change in Inv Labor and OH'
            , 'Reporting Hierarchies||Standard P&L Line Items||Material Margin'
            , 'Reporting Hierarchies||Standard P&L Line Items||Net Inventory'
            , 'Reporting Hierarchies||Standard P&L Line Items||Plant Contribution'
            , 'Reporting Hierarchies||Standard P&L Line Items||Pnl - Gross Margin'
            , 'Reporting Hierarchies||Standard P&L Line Items||Pnl - Gross Margin||Material Margin||Cost of Materials||Scrap Freight-In and Duty||Scrap'
            , 'Reporting Hierarchies||Standard P&L Line Items||Pnl - Gross Margin||Material Margin||Cost of Materials||Scrap Freight-In and Duty||Scrap||Cycle Count Scrap'
            , 'Reporting Hierarchies||Standard P&L Line Items||Pnl - Gross Margin||Material Margin||Cost of Materials||Scrap Freight-In and Duty||Scrap||Excess and Obsolete Scrap'
            , 'Reporting Hierarchies||Standard P&L Line Items||Pnl - Gross Margin||Material Margin||Cost of Materials||Scrap Freight-In and Duty||Scrap||Production Scrap'
            , 'Reporting Hierarchies||Standard P&L Line Items||Pnl - Gross Margin||Material Margin||Revenue'
            , 'Reporting Hierarchies||Standard P&L Line Items||Transformation Cost'
            , 'Reporting Hierarchies||Standard P&L Line Items||Variable Expenses'
            , 'Reporting Hierarchies||Standard P&L Line Items||WI - Current Net Inventory'
            , 'Schedules||Corporate Schedule||Tax Rate - CORE'
            , 'Schedules||Standard P&L Line Items||Direct Labor'
            , 'Schedules||Standard P&L Line Items||Total Net Assets'
            , 'Schedules||Standard Workcell P&L line items||Divisional Free Cash Flow'
            , 'Reporting Hierarchies||Standard P&L Line Items||Cost of Matls||410012'
            , 'Reporting Hierarchies||Standard P&L Line Items||Accounts Receivable'
            , 'Reporting Hierarchies||Standard P&L Line Items||Workcell Staff'
            , 'Reporting Hierarchies||Standard P&L Line Items||Material Handling||Material Handling Others'
            , 'Reporting Hierarchies||Standard P&L Line Items||Workcell Staff||Workcell Staff Tier Costs||91240'
            , 'Reporting Hierarchies||Standard P&L Line Items||Workcell Staff||Workcell Staff Tier Costs||91250'
            , 'Reporting Hierarchies||Standard P&L Line Items||Workcell Staff||Workcell Staff Tier Costs||91270'
            , 'Reporting Hierarchies||Standard P&L Line Items||Workcell Staff||Workcell Staff Tier Costs||91260'
            , 'Reporting Hierarchies||Standard P&L Line Items||Workcell Staff||Workcell Staff Tier Costs||91410'
            , 'Reporting Hierarchies||Standard P&L Line Items||Workcell Staff||Workcell Staff Tier Costs||91420'
            , 'Reporting Hierarchies||Standard P&L Line Items||Workcell Staff||Workcell Staff Tier Costs||91440'
            , 'Reporting Hierarchies||Standard P&L Line Items||Workcell Staff||Workcell Staff Tier Costs||91430'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||IL Headcount||Workcell Staff Headcount||Workcell Staff Mfg Headcount||Materials Management Mfg Headcount||Materials Supervisors Mfg Tier 1 Headcount'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||IL Headcount||Workcell Staff Headcount||Workcell Staff Mfg Headcount||Materials Management Mfg Headcount||Buyers Mfg Tier 2 Headcount'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||IL Headcount||Workcell Staff Headcount||Workcell Staff Mfg Headcount||Inventory Control Mfg Headcount'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||IL Headcount||Workcell Staff Headcount||Workcell Staff Mfg Headcount||Materials Management Mfg Headcount||PC Analysts Mfg Headcount'
            , 'Reporting Hierarchies||Account Analytics||Rates||Total IL Rates||Workcell Staff Mfg Rate||Inventory Control Mfg Rate'
            , 'Reporting Hierarchies||Account Analytics||Rates||Total IL Rates||Workcell Staff Mfg Rate||Materials Management Mfg Rate||PC Analysts Mfg Rate'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||IL Headcount||Workcell Staff Headcount||Workcell Staff DF Headcount||Materials Management DF Headcount||Materials Supervisors DF Tier 1 Headcount'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||IL Headcount||Workcell Staff Headcount||Workcell Staff DF Headcount||Materials Management DF Headcount||Buyers DF Tier 2 Headcount'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||IL Headcount||Workcell Staff Headcount||Workcell Staff DF Headcount||Inventory Control DF Headcount'
            , 'Reporting Hierarchies||Account Analytics||Headcounts||IL Headcount||Workcell Staff Headcount||Workcell Staff DF Headcount||Materials Management DF Headcount||PC Analysts DF Headcount'
            , 'Reporting Hierarchies||Account Analytics||Rates||Total IL Rates||Workcell Staff DF Rate||Inventory Control DF Rate'
            , 'Reporting Hierarchies||WC Variance Analysis BI||Scrap and Freight BI||Freight In||T450001'
            , 'Reporting Hierarchies||Standard P&L Line Items||Net Working Capital||Net Inventory||TOTINVENTORY||T130000||130400')
    )
SELECT
    A.Account
    , A.Hierarchy
FROM (
    SELECT *
    FROM Hadoop_Accounts
    WHERE
        Account NOT IN (SELECT Parent FROM TM1.DimTM1AccountHierarchy)
    UNION ALL
    SELECT
            Account
            ,CONCAT(Hierarchy , '||' ) Hierarchy
    FROM Hadoop_Accounts
    WHERE
        Account IN (SELECT Parent FROM TM1.DimTM1AccountHierarchy)
        ) A;
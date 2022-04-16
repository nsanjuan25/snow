create or replace view V_TMSTOSHIBACUSTOMERLOAD(
	"SHIPPING ORDER INVOICE OID",
	"SHIPPING ORDER INVOICE PRIMARY REFERENCE",
	BOL,
	OWNER,
	"DELIVERY NUMBER",
	"ACTUAL SHIP",
	"SHIPMENT STATUS",
	PRO,
	"DEST COUNTRY",
	"DEST STATE",
	"INVOICE MODE",
	"INVOICE SCAC",
	"CUSTOMER NORM. CHARGE",
	"CUSTOMER NORM. CURRENCY",
	"CUSTOMER RATED. CHARGE",
	"CUSTOMER RATED. CURRENCY",
	"ORIGIN COUNTRY",
	"DEST NAME",
	"ACTUAL DELIVERY",
	"INVOICE DATE",
	"INVOICE NUMBER",
	"ORIGIN NAME",
	"ORIGIN CITY",
	"ORIGIN STATE",
	"ORIGIN ZIP",
	"DEST CITY",
	"DEST ZIP",
	"INVOICE TOTAL LINE HAUL",
	"INVOICE TOTAL FUEL",
	"PRICESHEET OID",
	TYPE,
	SELECTED,
	LANE,
	"CARRIER NAME",
	"CARRIER SCAC",
	"CONTRACT NAME",
	"CONTRACT MODE",
	"CONTRACT SERVICE",
	"SERVICE DAYS",
	"SERVICE DAYS TYPE",
	"MIN/MAX",
	MANUAL,
	ALLOCATED,
	"GL CODE",
	SEQUENCE,
	TOTAL,
	"NORMALIZED TOTAL",
	"ITEM TOTAL",
	"ADJUSTMENT TOTAL",
	"DEFICIT TOTAL",
	"DISCOUNT TOTAL",
	"FUEL TOTAL",
	"ACCESSORIAL TOTAL",
	"FINAL PCT ACCESSORIALS TOTAL",
	"ACCESSORIAL SUMMARY",
	"ACCESSORIAL - FUE",
	"ACCESSORIAL - ADV",
	"ACCESSORIAL - AIR",
	"ACCESSORIAL - AMS",
	"ACCESSORIAL - BSH",
	"ACCESSORIAL - CCE",
	"ACCESSORIAL - DEF",
	"ACCESSORIAL - DOF",
	"ACCESSORIAL - DTH",
	"ACCESSORIAL - HAN",
	"ACCESSORIAL - HAV",
	"ACCESSORIAL - INP",
	"ACCESSORIAL - INS",
	"ACCESSORIAL - MIS",
	"ACCESSORIAL - MSC",
	"ACCESSORIAL - ODC",
	"ACCESSORIAL - RCL",
	"ACCESSORIAL - SPC",
	"ACCESSORIAL - SRG",
	"ACCESSORIAL - TEC",
	"ACCESSORIAL - THE",
	"ACCESSORIAL - WTV",
	"RATE CURRENCY",
	"SHIPPING ORDER OID",
	"SHIPPING ORDER PRIMARY REFERENCE",
	"TARGET DELIVERY (LATE)",
	STATUS,
	"CUSTOMER NAME",
	QUANTITY,
	"QUANTITY SHIPUNIT",
	"WEIGHT SHIPUNIT",
	"WEIGHT UOM SHIPUNIT",
	"CUSTOMER REFERENCE",
	"SALES ORDER",
	"LOAD OID",
	"LOAD PRIMARY REFERENCE",
	"SHIPMENT COUNT",
	"CARRIER TOTAL"
) as 
SELECT ShippingOrderInvoiceOID	            as	"Shipping Order Invoice OID"
     , ShippingOrderInvoicePrimaryReference	as	"Shipping Order Invoice Primary Reference"
     , BOL	                                as	"BOL"
     , Owner	                            as	"Owner"
     , DeliveryNumber	                    as	"Delivery Number"
     , ActualShip	                        as	"Actual Ship"
     , ShipmentStatus	                    as	"Shipment Status"
     , PRO	                                as	"PRO"
     , DestCountry	                        as	"Dest Country"
     , DestState	                        as	"Dest State"
     , InvoiceMode	                        as	"Invoice Mode"
     , InvoiceSCAC	                        as	"Invoice SCAC"
     , CustomerNormCharge	                as	"Customer Norm. Charge"
     , CustomerNormCurrency	                as	"Customer Norm. Currency"
     , CustomerRatedCharge	                as	"Customer Rated. Charge"
     , CustomerRatedCurrency	            as	"Customer Rated. Currency"
     , OriginCountry	                    as	"Origin Country"
     , DestName	                            as	"Dest Name"
     , ActualDelivery	                    as	"Actual Delivery"
     , InvoiceDate	                        as	"Invoice Date"
     , InvoiceNumber	                    as	"Invoice Number"
     , OriginName	                        as	"Origin Name"
     , OriginCity	                        as	"Origin City"
     , OriginState	                        as	"Origin State"
     , OriginZip	                        as	"Origin Zip"
     , DestCity	                            as	"Dest City"
     , DestZip	                            as	"Dest Zip"
     , InvoiceTotalLineHaul	                as	"Invoice Total Line Haul"
     , InvoiceTotalFuel	                    as	"Invoice Total Fuel"
     , PriceSheetOID	                    as	"PriceSheet OID"
     , Type	                                as	"Type"
     , Selected	                            as	"Selected"
     , Lane	                                as	"Lane"
     , CarrierName	                        as	"Carrier Name"
     , CarrierSCAC	                        as	"Carrier SCAC"
     , ContractName	                        as	"Contract Name"
     , ContractMode	                        as	"Contract Mode"
     , ContractService	                    as	"Contract Service"
     , ServiceDays	                        as	"Service Days"
     , ServiceDaysType	                    as	"Service Days Type"
     , MinMax	                            as	"Min/Max"
     , Manual	                            as	"Manual"
     , Allocated	                        as	"Allocated"
     , GLCode	                            as	"GL Code"
     , Sequence	                            as	"Sequence"
     , Total	                            as	"Total"
     , NormalizedTotal	                    as	"Normalized Total"
     , ItemTotal	                        as	"Item Total"
     , AdjustmentTotal	                    as	"Adjustment Total"
     , DeficitTotal	                        as	"Deficit Total"
     , DiscountTotal	                    as	"Discount Total"
     , FuelTotal	                        as	"Fuel Total"
     , AccessorialTotal	                    as	"Accessorial Total"
     , FinalPctAccessorialsTotal	        as	"Final Pct Accessorials Total"
     , AccessorialSummary	                as	"Accessorial Summary"
     , AccessorialFUE	                    as	"Accessorial - FUE"
     , AccessorialADV	                    as	"Accessorial - ADV"
     , AccessorialAIR	                    as	"Accessorial - AIR"
     , AccessorialAMS	                    as	"Accessorial - AMS"
     , AccessorialBSH	                    as	"Accessorial - BSH"
     , AccessorialCCE	                    as	"Accessorial - CCE"
     , AccessorialDEF	                    as	"Accessorial - DEF"
     , AccessorialDOF	                    as	"Accessorial - DOF"
     , AccessorialDTH	                    as	"Accessorial - DTH"
     , AccessorialHAN	                    as	"Accessorial - HAN"
     , AccessorialHAV	                    as	"Accessorial - HAV"
     , AccessorialINP	                    as	"Accessorial - INP"
     , AccessorialINS	                    as	"Accessorial - INS"
     , AccessorialMIS	                    as	"Accessorial - MIS"
     , AccessorialMSC	                    as	"Accessorial - MSC"
     , AccessorialODC	                    as	"Accessorial - ODC"
     , AccessorialRCL	                    as	"Accessorial - RCL"
     , AccessorialSPC	                    as	"Accessorial - SPC"
     , AccessorialSRG	                    as	"Accessorial - SRG"
     , AccessorialTEC	                    as	"Accessorial - TEC"
     , AccessorialTHE	                    as	"Accessorial - THE"
     , AccessorialWTV	                    as	"Accessorial - WTV"
     , RateCurrency	                        as	"Rate Currency"
     , ShippingOrderOID	                    as	"Shipping Order OID"
     , ShippingOrderPrimaryReference	    as	"Shipping Order Primary Reference"
     , TargetDeliveryLate	                as	"Target Delivery (Late)"
     , Status	                            as	"Status"
     , CustomerName	                        as	"Customer Name"
     , Quantity	                            as	"Quantity"
     , QuantityShipUnit	                    as	"Quantity ShipUnit"
     , WeightShipUnit	                    as	"Weight ShipUnit"
     , WeightUOMShipUnit	                as	"Weight UOM ShipUnit"
     , CustomerReference	                as	"Customer Reference"
     , SalesOrder	                        as	"Sales Order"
     , LoadOID	                            as	"Load OID"
     , LoadPrimaryReference	                as	"Load Primary Reference"
     , ShipmentCount	                    as	"Shipment Count"
     , CarrierTotal	                        as	"Carrier Total"
FROM TMS.FactTgcs;
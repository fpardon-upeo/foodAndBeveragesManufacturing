/**
 * Created by fpardon on 19/09/2022.
 */

@IsTest
private class BusinessCentralSyncServiceTest {

    static void createTestData(){

        DateTime dt = system.today();

        List<Sales_Manager_Region_Mapping__c> srmList = new List<Sales_Manager_Region_Mapping__c>();

        Sales_Manager_Region_Mapping__c srmBE = new Sales_Manager_Region_Mapping__c(Country__c='Belgium', Country_Code__c = 'BE', Sales_Manager__c = UserInfo.getUserId());
        Sales_Manager_Region_Mapping__c srmLB = new Sales_Manager_Region_Mapping__c(Country__c='Beirut', Country_Code__c = 'LB', Sales_Manager__c = UserInfo.getUserId());
        Sales_Manager_Region_Mapping__c srmIN = new Sales_Manager_Region_Mapping__c(Country__c='India', Country_Code__c = 'IN', Sales_Manager__c = UserInfo.getUserId());
        Sales_Manager_Region_Mapping__c srmGR = new Sales_Manager_Region_Mapping__c(Country__c='Greece', Country_Code__c = 'GR', Sales_Manager__c = UserInfo.getUserId());
        Sales_Manager_Region_Mapping__c srmUS = new Sales_Manager_Region_Mapping__c(Country__c='United States', Country_Code__c = 'US', Sales_Manager__c = UserInfo.getUserId());

        srmList.add(srmBE);
        srmList.add(srmLB);
        srmList.add(srmIN);
        srmList.add(srmGR);
        srmList.add(srmUS);

        insert srmList;


        Sync_Result__c srAcc = new Sync_Result__c(
                Sync_Date_Time__c = dt,
                Object__c = 'Account'
        );
        insert srAcc;

        Sync_Result__c srOrd = new Sync_Result__c(
                Sync_Date_Time__c = dt,
                Object__c = 'Order'
        );
        insert srOrd;

        Sync_Result__c srInv = new Sync_Result__c(
                Sync_Date_Time__c = dt,
                Object__c = 'Invoice',
                Operation__c = 'Delta - Open'
        );
        insert srInv;

        Sync_Result__c srInvPaid = new Sync_Result__c(
                Sync_Date_Time__c = dt,
                Object__c = 'Invoice',
                Operation__c = 'Delta - Paid'
        );
        insert srInvPaid;

        List<Business_Central_Mapping__c> mappingList = new List<Business_Central_Mapping__c>();

        Business_Central_Mapping__c idMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'customer',
                BC_Field__c = 'id',
                SF_Object__c = 'Account',
                SF_Field__c = 'Business_Central_Id__c'
        );
        mappingList.add(idMapping);

        Business_Central_Mapping__c numberMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'customer',
                BC_Field__c = 'number_Z',
                SF_Object__c = 'Account',
                SF_Field__c = 'AccountNumber'
        );
        mappingList.add(numberMapping);

        Business_Central_Mapping__c nameMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'customer',
                BC_Field__c = 'displayName',
                SF_Object__c = 'Account',
                SF_Field__c = 'Name'
        );
        mappingList.add(nameMapping);

        Business_Central_Mapping__c paymentTermMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'paymentTerm',
                BC_Field__c = 'displayName',
                SF_Object__c = 'Account',
                SF_Field__c = 'Payment_Terms__c'
        );
        mappingList.add(paymentTermMapping);

        Business_Central_Mapping__c shipmentMethodMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'shipmentMethod',
                BC_Field__c = 'displayName',
                SF_Object__c = 'Account',
                SF_Field__c = 'INCO_Terms__c'
        );
        mappingList.add(shipmentMethodMapping);

        Business_Central_Mapping__c customerFinancialDetailBalanceMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'customerFinancialDetail',
                BC_Field__c = 'balance',
                SF_Object__c = 'Account',
                SF_Field__c = 'Account_Balance__c'
        );
        mappingList.add(customerFinancialDetailBalanceMapping);

        Business_Central_Mapping__c customerFinancialDetailTotalSalesMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'customerFinancialDetail',
                BC_Field__c = 'totalSalesExcludingTax',
                SF_Object__c = 'Account',
                SF_Field__c = 'Total_Sales_Excl_Tax__c'
        );
        mappingList.add(customerFinancialDetailTotalSalesMapping);

        Business_Central_Mapping__c orderIdMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'salesOrder',
                BC_Field__c = 'id',
                SF_Object__c = 'Order',
                SF_Field__c = 'Business_Central_Id__c'
        );
        mappingList.add(orderIdMapping);

        Business_Central_Mapping__c orderAccountMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'salesOrder',
                BC_Field__c = 'customerId',
                SF_Object__c = 'Order',
                SF_Field__c = 'AccountId'
        );
        mappingList.add(orderAccountMapping);

        Business_Central_Mapping__c orderBillToMapping = new Business_Central_Mapping__c(
                BC_Table__c = 'salesOrder',
                BC_Field__c = 'billToCustomerId',
                SF_Object__c = 'Order',
                SF_Field__c = 'Bill_to__c'
        );
        mappingList.add(orderBillToMapping);

        Business_Central_Mapping__c orderName = new Business_Central_Mapping__c(
                BC_Table__c = 'salesOrder',
                BC_Field__c = 'number_Z',
                SF_Object__c = 'Order',
                SF_Field__c = 'Name'
        );
        mappingList.add(orderName);

        Business_Central_Mapping__c orderStatus = new Business_Central_Mapping__c(
                BC_Table__c = 'salesOrder',
                BC_Field__c = 'status',
                SF_Object__c = 'Order',
                SF_Field__c = 'Status'
        );
        mappingList.add(orderStatus);

        Business_Central_Mapping__c orderDate = new Business_Central_Mapping__c(
                BC_Table__c = 'salesOrder',
                BC_Field__c = 'orderDate',
                SF_Object__c = 'Order',
                SF_Field__c = 'EffectiveDate'
        );
        mappingList.add(orderDate);

        Business_Central_Mapping__c invoiceNumber = new Business_Central_Mapping__c(
                BC_Table__c = 'salesInvoice',
                BC_Field__c = 'number_Z',
                SF_Object__c = 'Invoice__c',
                SF_Field__c = 'Name'
        );
        mappingList.add(invoiceNumber);

        Business_Central_Mapping__c invoiceId = new Business_Central_Mapping__c(
                BC_Table__c = 'salesInvoice',
                BC_Field__c = 'id',
                SF_Object__c = 'Invoice__c',
                SF_Field__c = 'Business_Central_Id__c'
        );
        mappingList.add(invoiceId);

        Business_Central_Mapping__c invoiceCustomer = new Business_Central_Mapping__c(
                BC_Table__c = 'salesInvoice',
                BC_Field__c = 'customerId',
                SF_Object__c = 'Invoice__c',
                SF_Field__c = 'Account__c'
        );
        mappingList.add(invoiceCustomer);

        Business_Central_Mapping__c invoiceBillTo = new Business_Central_Mapping__c(
                BC_Table__c = 'salesInvoice',
                BC_Field__c = 'billToCustomerId',
                SF_Object__c = 'Invoice__c',
                SF_Field__c = 'Bill_to__c'
        );
        mappingList.add(invoiceBillTo);

        Business_Central_Mapping__c invoiceOrder = new Business_Central_Mapping__c(
                BC_Table__c = 'salesInvoice',
                BC_Field__c = 'orderId',
                SF_Object__c = 'Invoice__c',
                SF_Field__c = 'Order__c'
        );
        mappingList.add(invoiceOrder);

        insert mappingList;

    }

    static void createMockCallouts() {

        DateTime dt = system.today();

        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String, HttpCalloutMock>();
        SingleRequestMock fakeAccountData = new SingleRequestMock(
                200,
                'Complete',
                '{'+
                        '    \"@odata.context\": \"https://bcdta.belmoca.com:60043/Belmoca_ACCEPT/api/v2.0/$metadata#companies(fdeb4368-3840-eb11-9830-eecf2f863101)/customers\",'+
                        '    \"value\": ['+
                        '        {'+
                        '            \"@odata.etag\": \"W/\\\"JzQ0O3Z6bFB1WlZyamt3dDZ4Zk1yYjB2TnlaSW1uRjFVNTVkcmJGL0cyZFEvdUE9MTswMDsn\\\"\",'+
                        '            \"id\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"number\": \"Z0132\",'+
                        '            \"displayName\": \"Test from SF to BC\",'+
                        '            \"type\": \"Company\",'+
                        '            \"addressLine1\": \"1940 Argentia Road. \",'+
                        '            \"addressLine2\": \"\",'+
                        '            \"city\": \"Mississauga\",'+
                        '            \"state\": \"\",'+
                        '            \"country\": \"US\",'+
                        '            \"postalCode\": \"L5N 1P9\",'+
                        '            \"phoneNumber\": \"001 (905) 821-2111\",'+
                        '            \"email\": \"Haiek.Melkon@walmart.com\",'+
                        '            \"website\": \"\",'+
                        '            \"taxLiable\": false,'+
                        '            \"taxAreaId\": \"0f002cd2-5c79-ea11-93f7-005056b46d84\",'+
                        '            \"taxAreaDisplayName\": \"Klanten/leveranciers (niet EU)\",'+
                        '            \"taxRegistrationNumber\": \"US004734872\",'+
                        '            \"currencyId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"currencyCode\": \"EUR\",'+
                        '            \"paymentTermsId\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"paymentMethodId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"blocked\": \"_x0020_\",'+
                        '            \"lastModifiedDateTime\": \"2022-09-15T15:10:08.357Z\",'+
                        '            \"paymentTerm\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0OzJhNzFlV3lmdk5sSURMbzVUa2ZpYndoZzFUN2JCK0w2TG52OG5iQVp3c3c9MTswMDsn\\\"\",'+
                        '                \"id\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '                \"code\": \"FOC\",'+
                        '                \"displayName\": \"Free of charge\",'+
                        '                \"dueDateCalculation\": \"0D\",'+
                        '                \"discountDateCalculation\": \"\",'+
                        '                \"discountPercent\": 0,'+
                        '                \"calculateDiscountOnCreditMemos\": false,'+
                        '                \"lastModifiedDateTime\": \"2021-04-12T13:09:50.283Z\"'+
                        '            },'+
                        '            \"shipmentMethod\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0Ozg1ZmlIMk1FWnZYdDQ1bHI4MXVKRXZHWFVGZG1ZNzAvc0VRODJnTEpaWGs9MTswMDsn\\\"\",'+
                        '                \"id\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '                \"code\": \"DAP\",'+
                        '                \"displayName\": \"Geleverd op bestemming\",'+
                        '                \"lastModifiedDateTime\": \"2020-04-08T07:39:15.497Z\"'+
                        '            },'+
                        '            \"customerFinancialDetail\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0O2d5aThSZGVZenUyR2RiOUtjQmx5d0ZKbEFEbk9taVlZWG4rOGtEd0gzWE09MTswMDsn\\\"\",'+
                        '                \"id\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '                \"number\": \"Z0132\",'+
                        '                \"balance\": 0,'+
                        '                \"totalSalesExcludingTax\": 0,'+
                        '                \"overdueAmount\": 0'+
                        '            }'+
                        '        },'+
                        '        {'+
                        '            \"@odata.etag\": \"W/\\\"JzQ0O2hYODVKOUhOU0txdlF5a05xd3k3TGtML0JrcGgzT3Z6NTJIVDZVQlhaS3M9MTswMDsn\\\"\",'+
                        '            \"id\": \"7f6c8257-b8b4-ec11-8ba6-000d3abff80b\",'+
                        '            \"number\": \"Z0133\",'+
                        '            \"displayName\": \"DELDICO GROUP BV\",'+
                        '            \"type\": \"Company\",'+
                        '            \"addressLine1\": \"Klokstraat 12\",'+
                        '            \"addressLine2\": \"\",'+
                        '            \"city\": \"BERCHEM (ANTWERPEN)\",'+
                        '            \"state\": \"\",'+
                        '            \"country\": \"BE\",'+
                        '            \"postalCode\": \"2600\",'+
                        '            \"phoneNumber\": \"\",'+
                        '            \"email\": \"pierre@deldico.be\",'+
                        '            \"website\": \"\",'+
                        '            \"taxLiable\": false,'+
                        '            \"taxAreaId\": \"0b002cd2-5c79-ea11-93f7-005056b46d84\",'+
                        '            \"taxAreaDisplayName\": \"Klanten/leveranciers (binnenland)\",'+
                        '            \"taxRegistrationNumber\": \"\",'+
                        '            \"currencyId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"currencyCode\": \"EUR\",'+
                        '            \"paymentTermsId\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"paymentMethodId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"blocked\": \"_x0020_\",'+
                        '            \"lastModifiedDateTime\": \"2022-04-05T08:16:10.793Z\",'+
                        '            \"paymentTerm\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0OzJhNzFlV3lmdk5sSURMbzVUa2ZpYndoZzFUN2JCK0w2TG52OG5iQVp3c3c9MTswMDsn\\\"\",'+
                        '                \"id\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '                \"code\": \"FOC\",'+
                        '                \"displayName\": \"Free of charge\",'+
                        '                \"dueDateCalculation\": \"0D\",'+
                        '                \"discountDateCalculation\": \"\",'+
                        '                \"discountPercent\": 0,'+
                        '                \"calculateDiscountOnCreditMemos\": false,'+
                        '                \"lastModifiedDateTime\": \"2021-04-12T13:09:50.283Z\"'+
                        '            },'+
                        '            \"shipmentMethod\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0Ozg1ZmlIMk1FWnZYdDQ1bHI4MXVKRXZHWFVGZG1ZNzAvc0VRODJnTEpaWGs9MTswMDsn\\\"\",'+
                        '                \"id\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '                \"code\": \"DAP\",'+
                        '                \"displayName\": \"Geleverd op bestemming\",'+
                        '                \"lastModifiedDateTime\": \"2020-04-08T07:39:15.497Z\"'+
                        '            },'+
                        '            \"customerFinancialDetail\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0O1VtZnFabDVjQkJMcVo1QjF5b1BTdVBUZ3hSSzBWQnZ3cnlGMUdHVGNld0U9MTswMDsn\\\"\",'+
                        '                \"id\": \"7f6c8257-b8b4-ec11-8ba6-000d3abff80b\",'+
                        '                \"number\": \"Z0133\",'+
                        '                \"balance\": 0,'+
                        '                \"totalSalesExcludingTax\": 0,'+
                        '                \"overdueAmount\": 0'+
                        '            }'+
                        '        },'+
                        '        {'+
                        '            \"@odata.etag\": \"W/\\\"JzQ0O29jcFhZLzlhZlh5UlB6c2VGcDkyOVZ0a0I1bDdLY093RHlNbVFJTkg4TEk9MTswMDsn\\\"\",'+
                        '            \"id\": \"9fcbb0b1-e3b4-ec11-8ba6-000d3abff80b\",'+
                        '            \"number\": \"Z0134\",'+
                        '            \"displayName\": \"CASTANIA NUTS\",'+
                        '            \"type\": \"Company\",'+
                        '            \"addressLine1\": \"Dekwane Industrial Zone\",'+
                        '            \"addressLine2\": \"Barista Bldg, 4th floor\",'+
                        '            \"city\": \"Beirut\",'+
                        '            \"state\": \"\",'+
                        '            \"country\": \"LB\",'+
                        '            \"postalCode\": \"\",'+
                        '            \"phoneNumber\": \"\",'+
                        '            \"email\": \"roydaniel@castanianuts.com\",'+
                        '            \"website\": \"\",'+
                        '            \"taxLiable\": false,'+
                        '            \"taxAreaId\": \"0f002cd2-5c79-ea11-93f7-005056b46d84\",'+
                        '            \"taxAreaDisplayName\": \"Klanten/leveranciers (niet EU)\",'+
                        '            \"taxRegistrationNumber\": \"LE165913\",'+
                        '            \"currencyId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"currencyCode\": \"EUR\",'+
                        '            \"paymentTermsId\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"paymentMethodId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"blocked\": \"_x0020_\",'+
                        '            \"lastModifiedDateTime\": \"2022-04-05T13:25:55.577Z\",'+
                        '            \"paymentTerm\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0OzJhNzFlV3lmdk5sSURMbzVUa2ZpYndoZzFUN2JCK0w2TG52OG5iQVp3c3c9MTswMDsn\\\"\",'+
                        '                \"id\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '                \"code\": \"FOC\",'+
                        '                \"displayName\": \"Free of charge\",'+
                        '                \"dueDateCalculation\": \"0D\",'+
                        '                \"discountDateCalculation\": \"\",'+
                        '                \"discountPercent\": 0,'+
                        '                \"calculateDiscountOnCreditMemos\": false,'+
                        '                \"lastModifiedDateTime\": \"2021-04-12T13:09:50.283Z\"'+
                        '            },'+
                        '            \"shipmentMethod\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0Ozg1ZmlIMk1FWnZYdDQ1bHI4MXVKRXZHWFVGZG1ZNzAvc0VRODJnTEpaWGs9MTswMDsn\\\"\",'+
                        '                \"id\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '                \"code\": \"DAP\",'+
                        '                \"displayName\": \"Geleverd op bestemming\",'+
                        '                \"lastModifiedDateTime\": \"2020-04-08T07:39:15.497Z\"'+
                        '            },'+
                        '            \"customerFinancialDetail\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0O252RENNMWg4bURDdHNKUlF6NHl6R3NNaUt0dXI2VmdaZGlaT2d5MmRTNFk9MTswMDsn\\\"\",'+
                        '                \"id\": \"9fcbb0b1-e3b4-ec11-8ba6-000d3abff80b\",'+
                        '                \"number\": \"Z0134\",'+
                        '                \"balance\": 0,'+
                        '                \"totalSalesExcludingTax\": 0,'+
                        '                \"overdueAmount\": 0'+
                        '            }'+
                        '        },'+
                        '        {'+
                        '            \"@odata.etag\": \"W/\\\"JzQ0O2QvaDR2RXVPcHp1TVdtdERvZzFjOXM1UTIrTlIxTjdkVVE2cmVrODgwR1U9MTswMDsn\\\"\",'+
                        '            \"id\": \"0c2ddbed-e3b4-ec11-8ba6-000d3abff80b\",'+
                        '            \"number\": \"Z0135\",'+
                        '            \"displayName\": \"CHM TRADE SOLUTIONS\",'+
                        '            \"type\": \"Company\",'+
                        '            \"addressLine1\": \"6 Platonos\",'+
                        '            \"addressLine2\": \"Strovolos\",'+
                        '            \"city\": \"Nicosia \",'+
                        '            \"state\": \"\",'+
                        '            \"country\": \"GR\",'+
                        '            \"postalCode\": \"2040\",'+
                        '            \"phoneNumber\": \"00357 99346099\",'+
                        '            \"email\": \"info@chmsolutions.com.cy\",'+
                        '            \"website\": \"\",'+
                        '            \"taxLiable\": false,'+
                        '            \"taxAreaId\": \"0d002cd2-5c79-ea11-93f7-005056b46d84\",'+
                        '            \"taxAreaDisplayName\": \"Klanten/leveranciers (EU)\",'+
                        '            \"taxRegistrationNumber\": \"CY10335719N\",'+
                        '            \"currencyId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"currencyCode\": \"EUR\",'+
                        '            \"paymentTermsId\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"paymentMethodId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"blocked\": \"_x0020_\",'+
                        '            \"lastModifiedDateTime\": \"2022-05-13T09:50:07.223Z\",'+
                        '            \"paymentTerm\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0OzJhNzFlV3lmdk5sSURMbzVUa2ZpYndoZzFUN2JCK0w2TG52OG5iQVp3c3c9MTswMDsn\\\"\",'+
                        '                \"id\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '                \"code\": \"FOC\",'+
                        '                \"displayName\": \"Free of charge\",'+
                        '                \"dueDateCalculation\": \"0D\",'+
                        '                \"discountDateCalculation\": \"\",'+
                        '                \"discountPercent\": 0,'+
                        '                \"calculateDiscountOnCreditMemos\": false,'+
                        '                \"lastModifiedDateTime\": \"2021-04-12T13:09:50.283Z\"'+
                        '            },'+
                        '            \"shipmentMethod\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0Ozg1ZmlIMk1FWnZYdDQ1bHI4MXVKRXZHWFVGZG1ZNzAvc0VRODJnTEpaWGs9MTswMDsn\\\"\",'+
                        '                \"id\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '                \"code\": \"DAP\",'+
                        '                \"displayName\": \"Geleverd op bestemming\",'+
                        '                \"lastModifiedDateTime\": \"2020-04-08T07:39:15.497Z\"'+
                        '            },'+
                        '            \"customerFinancialDetail\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0O0EwZnVZaHBRRnNYeS9KMEg0czNxUytxcDYvQ3cwZlhDMnpaek5HSzBnSEE9MTswMDsn\\\"\",'+
                        '                \"id\": \"0c2ddbed-e3b4-ec11-8ba6-000d3abff80b\",'+
                        '                \"number\": \"Z0135\",'+
                        '                \"balance\": 0,'+
                        '                \"totalSalesExcludingTax\": 0,'+
                        '                \"overdueAmount\": 0'+
                        '            }'+
                        '        },'+
                        '        {'+
                        '            \"@odata.etag\": \"W/\\\"JzQ0O3FpMlMzZDZ2MmppdkZTZTRCZTUzQk9KMmlzbUZpN2RMSExScTBMS0Z4d2M9MTswMDsn\\\"\",'+
                        '            \"id\": \"3c489522-e4b4-ec11-8ba6-000d3abff80b\",'+
                        '            \"number\": \"Z0136\",'+
                        '            \"type\": \"Company\",'+
                        '            \"addressLine1\": \"WeWork, Chromium, Suite no. GRB110, Jogeshwari-Vikhroli Link Road,\",'+
                        '            \"addressLine2\": \"Andheri East\",'+
                        '            \"city\": \"MUMBAI\",'+
                        '            \"state\": \"\",'+
                        '            \"country\": \"IN\",'+
                        '            \"postalCode\": \"IN-400001\",'+
                        '            \"phoneNumber\": \"0091 9820 871 456\",'+
                        '            \"email\": \"randall@gcmventure.com\",'+
                        '            \"website\": \"\",'+
                        '            \"taxLiable\": false,'+
                        '            \"taxAreaId\": \"0f002cd2-5c79-ea11-93f7-005056b46d84\",'+
                        '            \"taxAreaDisplayName\": \"Klanten/leveranciers (niet EU)\",'+
                        '            \"taxRegistrationNumber\": \"IN27AAICG3982A1ZN\",'+
                        '            \"currencyId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"currencyCode\": \"EUR\",'+
                        '            \"paymentTermsId\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"paymentMethodId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"blocked\": \"_x0020_\",'+
                        '            \"lastModifiedDateTime\": \"2022-04-08T11:51:00.62Z\",'+
                        '            \"paymentTerm\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0OzJhNzFlV3lmdk5sSURMbzVUa2ZpYndoZzFUN2JCK0w2TG52OG5iQVp3c3c9MTswMDsn\\\"\",'+
                        '                \"id\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '                \"code\": \"FOC\",'+
                        '                \"displayName\": \"Free of charge\",'+
                        '                \"dueDateCalculation\": \"0D\",'+
                        '                \"discountDateCalculation\": \"\",'+
                        '                \"discountPercent\": 0,'+
                        '                \"calculateDiscountOnCreditMemos\": false,'+
                        '                \"lastModifiedDateTime\": \"2021-04-12T13:09:50.283Z\"'+
                        '            },'+
                        '            \"shipmentMethod\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0Ozg1ZmlIMk1FWnZYdDQ1bHI4MXVKRXZHWFVGZG1ZNzAvc0VRODJnTEpaWGs9MTswMDsn\\\"\",'+
                        '                \"id\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '                \"code\": \"DAP\",'+
                        '                \"displayName\": \"Geleverd op bestemming\",'+
                        '                \"lastModifiedDateTime\": \"2020-04-08T07:39:15.497Z\"'+
                        '            },'+
                        '            \"customerFinancialDetail\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0O2JOeW95cFRsNFBybFRzanM2bi81RlU3K0NKTFlOQVlaS3htd3A2YlVlbHc9MTswMDsn\\\"\",'+
                        '                \"id\": \"3c489522-e4b4-ec11-8ba6-000d3abff80b\",'+
                        '                \"number\": \"Z0136\",'+
                        '                \"balance\": 0,'+
                        '                \"totalSalesExcludingTax\": 0.5,'+
                        '                \"overdueAmount\": 0'+
                        '            }'+
                        '        }'+
                        '    ]'+
                        '}',
                null);

        SingleRequestMock fakeAccountDataSingle = new SingleRequestMock(
                200,
                'Complete',
                '{'+
                        '    \"@odata.context\": \"https://bcdta.belmoca.com:60043/Belmoca_ACCEPT/api/v2.0/$metadata#companies(fdeb4368-3840-eb11-9830-eecf2f863101)/customers\",'+
                        '    \"value\": ['+
                        '        {'+
                        '            \"@odata.etag\": \"W/\\\"JzQ0O3Z6bFB1WlZyamt3dDZ4Zk1yYjB2TnlaSW1uRjFVNTVkcmJGL0cyZFEvdUE9MTswMDsn\\\"\",'+
                        '            \"id\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"number\": \"Z0132\",'+
                        '            \"displayName\": \"Test from SF to BC\",'+
                        '            \"type\": \"Company\",'+
                        '            \"addressLine1\": \"1940 Argentia Road. \",'+
                        '            \"addressLine2\": \"\",'+
                        '            \"city\": \"Mississauga\",'+
                        '            \"state\": \"\",'+
                        '            \"country\": \"US\",'+
                        '            \"postalCode\": \"L5N 1P9\",'+
                        '            \"phoneNumber\": \"001 (905) 821-2111\",'+
                        '            \"email\": \"Haiek.Melkon@walmart.com\",'+
                        '            \"website\": \"\",'+
                        '            \"taxLiable\": false,'+
                        '            \"taxAreaId\": \"0f002cd2-5c79-ea11-93f7-005056b46d84\",'+
                        '            \"taxAreaDisplayName\": \"Klanten/leveranciers (niet EU)\",'+
                        '            \"taxRegistrationNumber\": \"US004734872\",'+
                        '            \"currencyId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"currencyCode\": \"EUR\",'+
                        '            \"paymentTermsId\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"paymentMethodId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"blocked\": \"_x0020_\",'+
                        '            \"lastModifiedDateTime\": \"2022-09-15T15:10:08.357Z\",'+
                        '            \"paymentTerm\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0OzJhNzFlV3lmdk5sSURMbzVUa2ZpYndoZzFUN2JCK0w2TG52OG5iQVp3c3c9MTswMDsn\\\"\",'+
                        '                \"id\": \"31bfab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '                \"code\": \"FOC\",'+
                        '                \"displayName\": \"Free of charge\",'+
                        '                \"dueDateCalculation\": \"0D\",'+
                        '                \"discountDateCalculation\": \"\",'+
                        '                \"discountPercent\": 0,'+
                        '                \"calculateDiscountOnCreditMemos\": false,'+
                        '                \"lastModifiedDateTime\": \"2021-04-12T13:09:50.283Z\"'+
                        '            },'+
                        '            \"shipmentMethod\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0Ozg1ZmlIMk1FWnZYdDQ1bHI4MXVKRXZHWFVGZG1ZNzAvc0VRODJnTEpaWGs9MTswMDsn\\\"\",'+
                        '                \"id\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '                \"code\": \"DAP\",'+
                        '                \"displayName\": \"Geleverd op bestemming\",'+
                        '                \"lastModifiedDateTime\": \"2020-04-08T07:39:15.497Z\"'+
                        '            },'+
                        '            \"customerFinancialDetail\": {'+
                        '                \"@odata.etag\": \"W/\\\"JzQ0O2d5aThSZGVZenUyR2RiOUtjQmx5d0ZKbEFEbk9taVlZWG4rOGtEd0gzWE09MTswMDsn\\\"\",'+
                        '                \"id\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '                \"number\": \"Z0132\",'+
                        '                \"balance\": 0,'+
                        '                \"totalSalesExcludingTax\": 0,'+
                        '                \"overdueAmount\": 0'+
                        '            }' +
                        '        }'+
                        '    ]'+
                        '}',
                null);

        SingleRequestMock fakeOrderDate = new SingleRequestMock(
                200,
                'Complete',
                '{'+
                        '    \"value\": ['+
                        '        {'+
                        '            \"id\": \"da34eb45-0d22-ed11-8bac-000d3abff80b\",'+
                        '            \"number\": \"VO/22/01415\",'+
                        '            \"externalDocumentNumber\": \"10000434204-0558\",'+
                        '            \"orderDate\": \"2022-08-22\",'+
                        '            \"postingDate\": \"2022-08-22\",'+
                        '            \"customerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"customerNumber\": \"00025\",'+
                        '            \"customerName\": \"TARGET CORPORATION - DC 0558\",'+
                        '            \"billToName\": \"TARGET CORPORATION - MAIN\",'+
                        '            \"billToCustomerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"billToCustomerNumber\": \"00047\",'+
                        '            \"shipToName\": \"TARGET CORPORATION - DC 0558\",'+
                        '            \"shipToContact\": \"\",'+
                        '            \"sellToAddressLine1\": \"875 BETA DRIVE SW\",'+
                        '            \"sellToAddressLine2\": \"\",'+
                        '            \"sellToCity\": \"ALBANY\",'+
                        '            \"sellToCountry\": \"US\",'+
                        '            \"sellToState\": \"\",'+
                        '            \"sellToPostCode\": \"OR 97321\",'+
                        '            \"billToAddressLine1\": \"P.O. Box 59251\",'+
                        '            \"billToAddressLine2\": \"\",'+
                        '            \"billToCity\": \"Minneapolis\",'+
                        '            \"billToCountry\": \"US\",'+
                        '            \"billToState\": \"\",'+
                        '            \"billToPostCode\": \"MN 55459\",'+
                        '            \"shipToAddressLine1\": \"875 BETA DRIVE SW\",'+
                        '            \"shipToAddressLine2\": \"\",'+
                        '            \"shipToCity\": \"ALBANY\",'+
                        '            \"shipToCountry\": \"US\",'+
                        '            \"shipToState\": \"\",'+
                        '            \"shipToPostCode\": \"OR 97321\",'+
                        '            \"currencyId\": \"40c4a84f-4679-ea11-93f7-005056b46d84\",'+
                        '            \"currencyCode\": \"USD\",'+
                        '            \"pricesIncludeTax\": false,'+
                        '            \"paymentTermsId\": \"c7af13b6-f0a7-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"8de53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"salesperson\": \"DANIEL\",'+
                        '            \"partialShipping\": true,'+
                        '            \"requestedDeliveryDate\": \"2022-09-03\",'+
                        '            \"discountAmount\": 0,'+
                        '            \"discountAppliedBeforeTax\": true,'+
                        '            \"totalAmountExcludingTax\": 3440.64,'+
                        '            \"totalTaxAmount\": 0,'+
                        '            \"totalAmountIncludingTax\": 3440.64,'+
                        '            \"fullyShipped\": true,'+
                        '            \"status\": \"Draft\",'+
                        '            \"lastModifiedDateTime\": \"2022-09-19T07:05:33.27Z\",'+
                        '            \"phoneNumber\": \"\",'+
                        '            \"email\": \"\"'+
                        '        },'+
                        '        {'+
                        '            \"id\": \"770e880b-c135-ed11-8baa-0022488339d6\",'+
                        '            \"number\": \"VO/22/01438\",'+
                        '            \"externalDocumentNumber\": \"\",'+
                        '            \"orderDate\": \"2022-09-16\",'+
                        '            \"postingDate\": \"2022-09-16\",'+
                        '            \"customerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"customerNumber\": \"01162\",'+
                        '            \"customerName\": \"SUPPLY UNIQUE S.A - COFFEE ISLAND\",'+
                        '            \"billToName\": \"SUPPLY UNIQUE S.A - COFFEE ISLAND\",'+
                        '            \"billToCustomerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"billToCustomerNumber\": \"01162\",'+
                        '            \"shipToName\": \"SUPPLY UNIQUE S.A - COFFEE ISLAND\",'+
                        '            \"shipToContact\": \"Andreas Skondras\",'+
                        '            \"sellToAddressLine1\": \"30 Vrisakion Street\",'+
                        '            \"sellToAddressLine2\": \"\",'+
                        '            \"sellToCity\": \"Patras\",'+
                        '            \"sellToCountry\": \"GR\",'+
                        '            \"sellToState\": \"\",'+
                        '            \"sellToPostCode\": \"26334\",'+
                        '            \"billToAddressLine1\": \"30 Vrisakion Street\",'+
                        '            \"billToAddressLine2\": \"\",'+
                        '            \"billToCity\": \"Patras\",'+
                        '            \"billToCountry\": \"GR\",'+
                        '            \"billToState\": \"\",'+
                        '            \"billToPostCode\": \"26334\",'+
                        '            \"shipToAddressLine1\": \"30 Vrisakion Street\",'+
                        '            \"shipToAddressLine2\": \"\",'+
                        '            \"shipToCity\": \"Patras\",'+
                        '            \"shipToCountry\": \"GR\",'+
                        '            \"shipToState\": \"\",'+
                        '            \"shipToPostCode\": \"26334\",'+
                        '            \"currencyId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"currencyCode\": \"EUR\",'+
                        '            \"pricesIncludeTax\": false,'+
                        '            \"paymentTermsId\": \"89b24966-6e6c-eb11-983f-b56a0f665545\",'+
                        '            \"shipmentMethodId\": \"8de53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"salesperson\": \"BRECHT\",'+
                        '            \"partialShipping\": true,'+
                        '            \"requestedDeliveryDate\": \"0001-01-01\",'+
                        '            \"discountAmount\": 0,'+
                        '            \"discountAppliedBeforeTax\": true,'+
                        '            \"totalAmountExcludingTax\": 0,'+
                        '            \"totalTaxAmount\": 0,'+
                        '            \"totalAmountIncludingTax\": 0,'+
                        '            \"fullyShipped\": true,'+
                        '            \"status\": \"Draft\",'+
                        '            \"lastModifiedDateTime\": \"2022-09-16T13:26:32.783Z\",'+
                        '            \"phoneNumber\": \"+30 2610 647 702\",'+
                        '            \"email\": \"askondras@coffeeisland.gr\"'+
                        '        },'+
                        '        {'+
                        '            \"id\": \"f8cfd890-e837-ed11-8bab-0022488339d6\",'+
                        '            \"number\": \"VO/22/01439\",'+
                        '            \"externalDocumentNumber\": \"\",'+
                        '            \"orderDate\": \"2022-09-19\",'+
                        '            \"postingDate\": \"2022-09-19\",'+
                        '            \"customerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"customerNumber\": \"00003\",'+
                        '            \"customerName\": \"OVERSEAS.CO.,LTD\",'+
                        '            \"billToName\": \"OVERSEAS.CO.,LTD\",'+
                        '            \"billToCustomerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"billToCustomerNumber\": \"00003\",'+
                        '            \"shipToName\": \"OVERSEAS.CO.,LTD\",'+
                        '            \"shipToContact\": \"Logistics\",'+
                        '            \"sellToAddressLine1\": \"Daita 5-11-10,Setagayaku\",'+
                        '            \"sellToAddressLine2\": \"\",'+
                        '            \"sellToCity\": \"Tokyo\",'+
                        '            \"sellToCountry\": \"JP\",'+
                        '            \"sellToState\": \"\",'+
                        '            \"sellToPostCode\": \"155-0033\",'+
                        '            \"billToAddressLine1\": \"Daita 5-11-10,Setagayaku\",'+
                        '            \"billToAddressLine2\": \"\",'+
                        '            \"billToCity\": \"Tokyo\",'+
                        '            \"billToCountry\": \"JP\",'+
                        '            \"billToState\": \"\",'+
                        '            \"billToPostCode\": \"155-0033\",'+
                        '            \"shipToAddressLine1\": \"Daita 5-11-10,Setagayaku\",'+
                        '            \"shipToAddressLine2\": \"\",'+
                        '            \"shipToCity\": \"Tokyo\",'+
                        '            \"shipToCountry\": \"JP\",'+
                        '            \"shipToState\": \"\",'+
                        '            \"shipToPostCode\": \"155-0033\",'+
                        '            \"currencyId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"currencyCode\": \"EUR\",'+
                        '            \"pricesIncludeTax\": false,'+
                        '            \"paymentTermsId\": \"6095ee22-6f6c-eb11-983f-b56a0f665545\",'+
                        '            \"shipmentMethodId\": \"91e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"salesperson\": \"BRECHT\",'+
                        '            \"partialShipping\": true,'+
                        '            \"requestedDeliveryDate\": \"2022-09-26\",'+
                        '            \"discountAmount\": 0,'+
                        '            \"discountAppliedBeforeTax\": true,'+
                        '            \"totalAmountExcludingTax\": 8750.7,'+
                        '            \"totalTaxAmount\": 0,'+
                        '            \"totalAmountIncludingTax\": 8750.7,'+
                        '            \"fullyShipped\": true,'+
                        '            \"status\": \"Draft\",'+
                        '            \"lastModifiedDateTime\": \"2022-09-19T07:01:37.86Z\",'+
                        '            \"phoneNumber\": \"\",'+
                        '            \"email\": \"administration@overseasvinarte.co.jp\"'+
                        '        }'+
                        '    ]'+
                        '}',
                        null
        );

        SingleRequestMock fakeOrderDateSingle = new SingleRequestMock(
                200,
                'Complete',
                '{'+
                        '    \"value\": ['+
                        '        {'+
                        '            \"id\": \"da34eb45-0d22-ed11-8bac-000d3abff80b\",'+
                        '            \"number\": \"VO/22/01415\",'+
                        '            \"externalDocumentNumber\": \"10000434204-0558\",'+
                        '            \"orderDate\": \"2022-08-22\",'+
                        '            \"postingDate\": \"2022-08-22\",'+
                        '            \"customerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"customerNumber\": \"00025\",'+
                        '            \"customerName\": \"TARGET CORPORATION - DC 0558\",'+
                        '            \"billToName\": \"TARGET CORPORATION - MAIN\",'+
                        '            \"billToCustomerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"billToCustomerNumber\": \"00047\",'+
                        '            \"shipToName\": \"TARGET CORPORATION - DC 0558\",'+
                        '            \"shipToContact\": \"\",'+
                        '            \"sellToAddressLine1\": \"875 BETA DRIVE SW\",'+
                        '            \"sellToAddressLine2\": \"\",'+
                        '            \"sellToCity\": \"ALBANY\",'+
                        '            \"sellToCountry\": \"US\",'+
                        '            \"sellToState\": \"\",'+
                        '            \"sellToPostCode\": \"OR 97321\",'+
                        '            \"billToAddressLine1\": \"P.O. Box 59251\",'+
                        '            \"billToAddressLine2\": \"\",'+
                        '            \"billToCity\": \"Minneapolis\",'+
                        '            \"billToCountry\": \"US\",'+
                        '            \"billToState\": \"\",'+
                        '            \"billToPostCode\": \"MN 55459\",'+
                        '            \"shipToAddressLine1\": \"875 BETA DRIVE SW\",'+
                        '            \"shipToAddressLine2\": \"\",'+
                        '            \"shipToCity\": \"ALBANY\",'+
                        '            \"shipToCountry\": \"US\",'+
                        '            \"shipToState\": \"\",'+
                        '            \"shipToPostCode\": \"OR 97321\",'+
                        '            \"currencyId\": \"40c4a84f-4679-ea11-93f7-005056b46d84\",'+
                        '            \"currencyCode\": \"USD\",'+
                        '            \"pricesIncludeTax\": false,'+
                        '            \"paymentTermsId\": \"c7af13b6-f0a7-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"8de53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"salesperson\": \"DANIEL\",'+
                        '            \"partialShipping\": true,'+
                        '            \"requestedDeliveryDate\": \"2022-09-03\",'+
                        '            \"discountAmount\": 0,'+
                        '            \"discountAppliedBeforeTax\": true,'+
                        '            \"totalAmountExcludingTax\": 3440.64,'+
                        '            \"totalTaxAmount\": 0,'+
                        '            \"totalAmountIncludingTax\": 3440.64,'+
                        '            \"fullyShipped\": true,'+
                        '            \"status\": \"Draft\",'+
                        '            \"lastModifiedDateTime\": \"2022-09-19T07:05:33.27Z\",'+
                        '            \"phoneNumber\": \"\",'+
                        '            \"email\": \"\"'+
                        '        }'+
                        '    ]'+
                        '}',
                null
        );

        SingleRequestMock fakeInvoiceData = new SingleRequestMock(
                200,
                'Complete',
                '{'+
                        '    \"value\": ['+
                        '        {'+
                        '            \"id\": \"76a10cf4-efb3-ec11-8ba6-000d3abff80b\",'+
                        '            \"number\": \"VF22030207\",'+
                        '            \"externalDocumentNumber\": \"\",'+
                        '            \"invoiceDate\": \"2022-03-31\",'+
                        '            \"postingDate\": \"2022-03-31\",'+
                        '            \"dueDate\": \"2022-04-15\",'+
                        '            \"customerPurchaseOrderReference\": \"Amazon 2022 Sales March\",'+
                        '            \"customerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"customerNumber\": \"00088\",'+
                        '            \"customerName\": \"AMAZON CORPORATE LLC\",'+
                        '            \"billToName\": \"AMAZON CORPORATE LLC\",'+
                        '            \"billToCustomerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"billToCustomerNumber\": \"00088\",'+
                        '            \"shipToName\": \"AMAZON CORPORATE LLC\",'+
                        '            \"shipToContact\": \"\",'+
                        '            \"sellToAddressLine1\": \"440 Terry Avenue North\",'+
                        '            \"sellToAddressLine2\": \"\",'+
                        '            \"sellToCity\": \"Seattle \",'+
                        '            \"sellToCountry\": \"US\",'+
                        '            \"sellToState\": \"\",'+
                        '            \"sellToPostCode\": \"WA, 98109\",'+
                        '            \"billToAddressLine1\": \"440 Terry Avenue North\",'+
                        '            \"billToAddressLine2\": \"\",'+
                        '            \"billToCity\": \"Seattle \",'+
                        '            \"billToCountry\": \"US\",'+
                        '            \"billToState\": \"\",'+
                        '            \"billToPostCode\": \"WA, 98109\",'+
                        '            \"shipToAddressLine1\": \"440 Terry Avenue North\",'+
                        '            \"shipToAddressLine2\": \"\",'+
                        '            \"shipToCity\": \"Seattle \",'+
                        '            \"shipToCountry\": \"US\",'+
                        '            \"shipToState\": \"\",'+
                        '            \"shipToPostCode\": \"WA, 98109\",'+
                        '            \"currencyId\": \"40c4a84f-4679-ea11-93f7-005056b46d84\",'+
                        '            \"currencyCode\": \"USD\",'+
                        '            \"orderId\": \"da34eb45-0d22-ed11-8bac-000d3abff80b\",'+
                        '            \"orderNumber\": \"VO/22/00497\",'+
                        '            \"paymentTermsId\": \"ffbeab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"salesperson\": \"DANIEL\",'+
                        '            \"pricesIncludeTax\": false,'+
                        '            \"remainingAmount\": 3779.95,'+
                        '            \"discountAmount\": 0,'+
                        '            \"discountAppliedBeforeTax\": true,'+
                        '            \"totalAmountExcludingTax\": 3916.93,'+
                        '            \"totalTaxAmount\": 0,'+
                        '            \"totalAmountIncludingTax\": 3916.93,'+
                        '            \"status\": \"Open\",'+
                        '            \"lastModifiedDateTime\": \"2022-09-20T07:53:31.43Z\",'+
                        '            \"phoneNumber\": \"\",'+
                        '            \"email\": \"\"'+
                        '        },'+
                        '        {'+
                        '            \"id\": \"08098a9d-15b4-ec11-8ba6-000d3abff80b\",'+
                        '            \"number\": \"VF22030209\",'+
                        '            \"externalDocumentNumber\": \"\",'+
                        '            \"invoiceDate\": \"2022-03-31\",'+
                        '            \"postingDate\": \"2022-03-31\",'+
                        '            \"dueDate\": \"2022-03-31\",'+
                        '            \"customerPurchaseOrderReference\": \"\",'+
                        '            \"customerId\": \"7f6c8257-b8b4-ec11-8ba6-000d3abff80b\",'+
                        '            \"customerNumber\": \"00089\",'+
                        '            \"customerName\": \"ALUSENSE NV\",'+
                        '            \"billToName\": \"ALUSENSE NV\",'+
                        '            \"billToCustomerId\": \"7f6c8257-b8b4-ec11-8ba6-000d3abff80b\",'+
                        '            \"billToCustomerNumber\": \"00089\",'+
                        '            \"shipToName\": \"ALUSENSE NV\",'+
                        '            \"shipToContact\": \"\",'+
                        '            \"sellToAddressLine1\": \"Weversstraat 20\",'+
                        '            \"sellToAddressLine2\": \"\",'+
                        '            \"sellToCity\": \"LONDERZEEL\",'+
                        '            \"sellToCountry\": \"BE\",'+
                        '            \"sellToState\": \"\",'+
                        '            \"sellToPostCode\": \"1840\",'+
                        '            \"billToAddressLine1\": \"Weversstraat 20\",'+
                        '            \"billToAddressLine2\": \"\",'+
                        '            \"billToCity\": \"LONDERZEEL\",'+
                        '            \"billToCountry\": \"BE\",'+
                        '            \"billToState\": \"\",'+
                        '            \"billToPostCode\": \"1840\",'+
                        '            \"shipToAddressLine1\": \"Weversstraat 20\",'+
                        '            \"shipToAddressLine2\": \"\",'+
                        '            \"shipToCity\": \"LONDERZEEL\",'+
                        '            \"shipToCountry\": \"BE\",'+
                        '            \"shipToState\": \"\",'+
                        '            \"shipToPostCode\": \"1840\",'+
                        '            \"currencyId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"currencyCode\": \"EUR\",'+
                        '            \"orderId\": \"00000000-0000-0000-0000-000000000000\",'+
                        '            \"orderNumber\": \"\",'+
                        '            \"paymentTermsId\": \"6095ee22-6f6c-eb11-983f-b56a0f665545\",'+
                        '            \"shipmentMethodId\": \"8de53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"salesperson\": \"MICHAEL\",'+
                        '            \"pricesIncludeTax\": false,'+
                        '            \"remainingAmount\": 0.01,'+
                        '            \"discountAmount\": 0,'+
                        '            \"discountAppliedBeforeTax\": true,'+
                        '            \"totalAmountExcludingTax\": 40763.07,'+
                        '            \"totalTaxAmount\": 0,'+
                        '            \"totalAmountIncludingTax\": 40763.07,'+
                        '            \"status\": \"Open\",'+
                        '            \"lastModifiedDateTime\": \"2022-09-20T07:53:31.463Z\",'+
                        '            \"phoneNumber\": \"\",'+
                        '            \"email\": \"\"'+
                        '        }'+
                        '    ]'+
                        '}',
                null
        );

        SingleRequestMock fakeInvoiceDataSingle = new SingleRequestMock(
                200,
                'Complete',
                '{'+
                        '    \"value\": ['+
                        '        {'+
                        '            \"id\": \"76a10cf4-efb3-ec11-8ba6-000d3abff80b\",'+
                        '            \"number\": \"VF22030207\",'+
                        '            \"externalDocumentNumber\": \"\",'+
                        '            \"invoiceDate\": \"2022-03-31\",'+
                        '            \"postingDate\": \"2022-03-31\",'+
                        '            \"dueDate\": \"2022-04-15\",'+
                        '            \"customerPurchaseOrderReference\": \"Amazon 2022 Sales March\",'+
                        '            \"customerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"customerNumber\": \"00088\",'+
                        '            \"customerName\": \"AMAZON CORPORATE LLC\",'+
                        '            \"billToName\": \"AMAZON CORPORATE LLC\",'+
                        '            \"billToCustomerId\": \"41727536-28b0-ec11-8ba6-000d3abff80b\",'+
                        '            \"billToCustomerNumber\": \"00088\",'+
                        '            \"shipToName\": \"AMAZON CORPORATE LLC\",'+
                        '            \"shipToContact\": \"\",'+
                        '            \"sellToAddressLine1\": \"440 Terry Avenue North\",'+
                        '            \"sellToAddressLine2\": \"\",'+
                        '            \"sellToCity\": \"Seattle \",'+
                        '            \"sellToCountry\": \"US\",'+
                        '            \"sellToState\": \"\",'+
                        '            \"sellToPostCode\": \"WA, 98109\",'+
                        '            \"billToAddressLine1\": \"440 Terry Avenue North\",'+
                        '            \"billToAddressLine2\": \"\",'+
                        '            \"billToCity\": \"Seattle \",'+
                        '            \"billToCountry\": \"US\",'+
                        '            \"billToState\": \"\",'+
                        '            \"billToPostCode\": \"WA, 98109\",'+
                        '            \"shipToAddressLine1\": \"440 Terry Avenue North\",'+
                        '            \"shipToAddressLine2\": \"\",'+
                        '            \"shipToCity\": \"Seattle \",'+
                        '            \"shipToCountry\": \"US\",'+
                        '            \"shipToState\": \"\",'+
                        '            \"shipToPostCode\": \"WA, 98109\",'+
                        '            \"currencyId\": \"40c4a84f-4679-ea11-93f7-005056b46d84\",'+
                        '            \"currencyCode\": \"USD\",'+
                        '            \"orderId\": \"da34eb45-0d22-ed11-8bac-000d3abff80b\",'+
                        '            \"orderNumber\": \"VO/22/00497\",'+
                        '            \"paymentTermsId\": \"ffbeab9e-6f77-eb11-9840-e27f39b2616e\",'+
                        '            \"shipmentMethodId\": \"83e53309-6c79-ea11-93f8-005056b46d84\",'+
                        '            \"salesperson\": \"DANIEL\",'+
                        '            \"pricesIncludeTax\": false,'+
                        '            \"remainingAmount\": 3779.95,'+
                        '            \"discountAmount\": 0,'+
                        '            \"discountAppliedBeforeTax\": true,'+
                        '            \"totalAmountExcludingTax\": 3916.93,'+
                        '            \"totalTaxAmount\": 0,'+
                        '            \"totalAmountIncludingTax\": 3916.93,'+
                        '            \"status\": \"Open\",'+
                        '            \"lastModifiedDateTime\": \"2022-09-20T07:53:31.43Z\",'+
                        '            \"phoneNumber\": \"\",'+
                        '            \"email\": \"\"'+
                        '        }'+
                        '    ]'+
                        '}',
                null
        );


        String syncDateFormatted = dt.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS')+ 'Z';
        system.debug('syncDateFormatted in Test Class = '+syncDateFormatted);

        //Account mocks
        endpoint2TestResp.put('callout:BusinessCentral/customers?$expand=paymentTerm,shipmentMethod,customerFinancialDetail&$filter=lastModifiedDateTime%20ge%20' + syncDateFormatted, fakeAccountData);
        endpoint2TestResp.put('callout:BusinessCentral/customers?$expand=paymentTerm,shipmentMethod,customerFinancialDetail', fakeAccountData);
        endpoint2TestResp.put('callout:BusinessCentral/customers?$expand=paymentTerm,shipmentMethod,customerFinancialDetail&$filter=id%20eq%2041727536-28b0-ec11-8ba6-000d3abff80b', fakeAccountDataSingle);
        //Order mocks
        endpoint2TestResp.put('callout:BusinessCentral/salesOrders', fakeOrderDate);
        endpoint2TestResp.put('callout:BusinessCentral/salesOrders?$filter=lastModifiedDateTime%20ge%20' +syncDateFormatted, fakeOrderDate);
        endpoint2TestResp.put('callout:BusinessCentral/salesOrders?$filter=id%20eq%20da34eb45-0d22-ed11-8bac-000d3abff80b', fakeOrderDateSingle);
        //Invoice mocks
        endpoint2TestResp.put('callout:BusinessCentral/salesInvoices?$filter=status%20ne%20\'paid\'%20and%20lastModifiedDateTime%20ge%20' +syncDateFormatted, fakeInvoiceData);
        endpoint2TestResp.put('callout:BusinessCentral/salesInvoices?$filter=status%20eq%20\'paid\'%20and%20lastModifiedDateTime%20ge%20' +syncDateFormatted, fakeInvoiceData);
        endpoint2TestResp.put('callout:BusinessCentral/salesInvoices?$filter=status%20ne%20\'paid\'', fakeInvoiceData);
        endpoint2TestResp.put('callout:BusinessCentral/salesInvoices', fakeInvoiceData);
        endpoint2TestResp.put('callout:BusinessCentral/salesInvoices?$filter=id%20eq%2076a10cf4-efb3-ec11-8ba6-000d3abff80b', fakeInvoiceDataSingle);

        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
    }

    // -----------------------------------------------------------------------------------------------
    //                                      Account Tests
    // -----------------------------------------------------------------------------------------------

    @IsTest
    public static void testGetAllAccountData(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getAccountDataAll();

        Test.stopTest();

        //Added one record to the mock JSON without a displayName node
        //Expecting 4 creates and 1 error record
        List<Account> insertedAccounts = [SELECT Id, Name, AccountNumber, Business_Central_Id__c FROM Account];
        System.debug('insertedAccounts size = ' +insertedAccounts.size());
        List<Sync_Error__c> syncErrors = [SELECT Id, Error_Message__c from Sync_Error__c];
        for(Sync_Error__c syncError : syncErrors){
            system.debug(syncError.Error_Message__c);
        }
        System.debug('syncErrors size = ' +syncErrors.size());
        System.assertEquals(1, syncErrors.size());
        System.assertEquals(4, insertedAccounts.size());
    }

    @IsTest
    public static void testGetAccountDataDelta(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getAccountDataDelta();

        Test.stopTest();

        //Added one record to the mock JSON without a displayName node
        //Expecting 4 creates and 1 error record
        List<Account> insertedAccounts = [SELECT Id, Name, AccountNumber, Business_Central_Id__c FROM Account];
        System.debug('insertedAccounts size = ' +insertedAccounts.size());
        System.assertEquals(4, insertedAccounts.size());
        List<Sync_Error__c> syncErrors = [SELECT Id from Sync_Error__c];
        System.debug('syncErrors size = ' +syncErrors.size());
        System.assertEquals(1, syncErrors.size());
    }

    @IsTest
    public static void testGetAccountDataSingle(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getSingleAccountData('41727536-28b0-ec11-8ba6-000d3abff80b');

        Test.stopTest();

        List<Account> insertedAccounts = [SELECT Id, Name, AccountNumber, Business_Central_Id__c FROM Account];
        System.debug('insertedAccounts size = ' +insertedAccounts.size());
        System.assertEquals(1, insertedAccounts.size());
        List<Sync_Error__c> syncErrors = [SELECT Id from Sync_Error__c];
        System.debug('syncErrors size = ' +syncErrors.size());
        System.assertEquals(0, syncErrors.size());
    }

    // -----------------------------------------------------------------------------------------------
    //                                      Order Tests
    // -----------------------------------------------------------------------------------------------

    @IsTest
    public static void testGetOrderDataAll(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getAccountDataAll();
        BusinessCentralSyncService.getOrderDataAll();

        Test.stopTest();

        //Expecting 3 creates and 1 error record
        List<Order> insertedOrders = [SELECT Id, AccountId, Bill_to__c FROM Order];
        System.debug('insertedOrders size = ' +insertedOrders.size());
        List<Sync_Error__c> syncErrors = [SELECT Id, Error_Message__c from Sync_Error__c];
        for(Sync_Error__c syncError : syncErrors){
            System.debug(syncError.Error_Message__c);
        }
        System.assertEquals(3, insertedOrders.size());
    }

    @IsTest
    public static void testGetOrderDataDelta(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getAccountDataAll();
        BusinessCentralSyncService.getOrderDataDelta();

        Test.stopTest();

        //Expecting 3 creates and 1 error record
        List<Order> insertedOrders = [SELECT Id, AccountId, Bill_to__c FROM Order];
        System.debug('insertedOrders size = ' +insertedOrders.size());
        List<Sync_Error__c> syncErrors = [SELECT Id, Error_Message__c from Sync_Error__c Where Type__c = 'Order Upsert'];
        for(Sync_Error__c syncError : syncErrors){
            System.debug(syncError.Error_Message__c);
        }
        System.assertEquals(3, insertedOrders.size());
        System.assertEquals(0, syncErrors.size());
    }

    @IsTest
    public static void testGetOrderDataSingle(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getAccountDataAll();
        BusinessCentralSyncService.getOrderDataSingle('da34eb45-0d22-ed11-8bac-000d3abff80b');

        Test.stopTest();

        List<Order> insertedOrders = [SELECT Id, AccountId, Bill_to__c FROM Order];
        System.debug('insertedOrders size = ' +insertedOrders.size());
        List<Sync_Error__c> syncErrors = [SELECT Id, Error_Message__c from Sync_Error__c Where Type__c = 'Order Upsert'];
        for(Sync_Error__c syncError : syncErrors){
            System.debug(syncError.Error_Message__c);
        }
        System.assertEquals(1, insertedOrders.size());
        System.assertEquals(0, syncErrors.size());
    }

    // -----------------------------------------------------------------------------------------------
    //                                      Invoice Tests
    // -----------------------------------------------------------------------------------------------

    @IsTest
    public static void testGetInvoiceDataAll(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getAccountDataAll();
        BusinessCentralSyncService.getOrderDataAll();
        BusinessCentralSyncService.getInvoiceDataAll();

        Test.stopTest();

        //Expecting 2 creates and 0 error record
        List<Invoice__c> insertedInvoices = [SELECT Id FROM Invoice__c];
        System.debug('insertedInvoices size = ' +insertedInvoices.size());
        List<Sync_Error__c> syncErrors = [SELECT Id, Error_Message__c from Sync_Error__c Where Type__c = 'Invoice Upsert'];
        for(Sync_Error__c syncError : syncErrors){
            System.debug(syncError.Error_Message__c);
        }
        System.assertEquals(2, insertedInvoices.size());
        System.assertEquals(0, syncErrors.size());
    }

    @IsTest
    public static void testGetInvoiceDataDeltaOpen(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getAccountDataDelta();
        BusinessCentralSyncService.getOrderDataAll();
        BusinessCentralSyncService.getInvoiceDataDeltaOpen();

        Test.stopTest();

        //Added one record to the mock JSON without a displayName node
        //Expecting 4 creates and 1 error record
        List<Invoice__c> insertedInvoices = [SELECT Id FROM Invoice__c];
        System.debug('insertedInvoices size = ' +insertedInvoices.size());
        System.assertEquals(2, insertedInvoices.size());
        List<Sync_Error__c> syncErrors = [SELECT Id from Sync_Error__c Where Type__c = 'Invoice Upsert'];
        System.debug('syncErrors size = ' +syncErrors.size());
        System.assertEquals(0, syncErrors.size());
    }

    @IsTest
    public static void testGetInvoiceDataDeltaPaid(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getAccountDataDelta();
        BusinessCentralSyncService.getOrderDataAll();
        BusinessCentralSyncService.getInvoiceDataDeltaPaid();

        Test.stopTest();

        //Added one record to the mock JSON without a displayName node
        //Expecting 4 creates and 1 error record
        List<Invoice__c> insertedInvoices = [SELECT Id FROM Invoice__c];
        System.debug('insertedInvoices size = ' +insertedInvoices.size());
        System.assertEquals(2, insertedInvoices.size());
        List<Sync_Error__c> syncErrors = [SELECT Id from Sync_Error__c Where Type__c = 'Invoice Upsert'];
        System.debug('syncErrors size = ' +syncErrors.size());
        System.assertEquals(0, syncErrors.size());
    }

    @IsTest
    public static void testGetInvoiceDataSingle(){
        createTestData();
        createMockCallouts();

        Test.startTest();

        BusinessCentralSyncService.getAccountDataDelta();
        BusinessCentralSyncService.getOrderDataAll();
        BusinessCentralSyncService.getInvoiceDataSingle('76a10cf4-efb3-ec11-8ba6-000d3abff80b');

        Test.stopTest();

        //Added one record to the mock JSON without a displayName node
        //Expecting 4 creates and 1 error record
        List<Invoice__c> insertedInvoices = [SELECT Id FROM Invoice__c];
        System.debug('insertedInvoices size = ' +insertedInvoices.size());
        System.assertEquals(1, insertedInvoices.size());
        List<Sync_Error__c> syncErrors = [SELECT Id from Sync_Error__c Where Type__c = 'Invoice Upsert'];
        System.debug('syncErrors size = ' +syncErrors.size());
        System.assertEquals(0, syncErrors.size());
    }
}
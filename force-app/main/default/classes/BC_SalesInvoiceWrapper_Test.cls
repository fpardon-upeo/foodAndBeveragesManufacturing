/**
 * @Version: 1.0
 * @Author: Frederik
 * @Copyright: 2021 Upeo Consulting
 * @Uses:
 *
 * -----------------------------------------------------------------------------------------------
 * Description: 
 *
 *
 * Created: 21/09/2022
 * Last Updated: 21/09/2022
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

@IsTest
public class BC_SalesInvoiceWrapper_Test {

    // This test method should give 100% coverage
    static testMethod void testParse() {
        String json = '{'+
                '    \"value\": ['+
                '        {'+
                '            \"id\": \"76a10cf4-efb3-ec11-8ba6-000d3abff80b\",'+
                '            \"number\": \"VF22030207\",'+
                '            \"externalDocumentNumber\": \"\",'+
                '            \"invoiceDate\": \"2022-03-31\",'+
                '            \"postingDate\": \"2022-03-31\",'+
                '            \"dueDate\": \"2022-04-15\",'+
                '            \"customerPurchaseOrderReference\": \"Amazon 2022 Sales March\",'+
                '            \"customerId\": \"120d85da-6db2-eb11-9840-e27f39b2616e\",'+
                '            \"customerNumber\": \"00088\",'+
                '            \"customerName\": \"AMAZON CORPORATE LLC\",'+
                '            \"billToName\": \"AMAZON CORPORATE LLC\",'+
                '            \"billToCustomerId\": \"120d85da-6db2-eb11-9840-e27f39b2616e\",'+
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
                '            \"orderId\": \"7e3f77c2-ecb3-ec11-8ba6-000d3abff80b\",'+
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
                '            \"customerId\": \"5a609706-03be-eb11-9840-e27f39b2616e\",'+
                '            \"customerNumber\": \"00089\",'+
                '            \"customerName\": \"ALUSENSE NV\",'+
                '            \"billToName\": \"ALUSENSE NV\",'+
                '            \"billToCustomerId\": \"5a609706-03be-eb11-9840-e27f39b2616e\",'+
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
                '}';
        BC_SalesInvoiceWrapper r = BC_SalesInvoiceWrapper.parse(json);
        System.assert(r != null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        BC_SalesInvoiceWrapper objBC_SalesInvoiceWrapper = new BC_SalesInvoiceWrapper(System.JSON.createParser(json));
        System.assert(objBC_SalesInvoiceWrapper != null);
        System.assert(objBC_SalesInvoiceWrapper.value == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        BC_SalesInvoiceWrapper.Value objValue = new BC_SalesInvoiceWrapper.Value(System.JSON.createParser(json));
        System.assert(objValue != null);
        System.assert(objValue.id == null);
        System.assert(objValue.number_Z == null);
        System.assert(objValue.externalDocumentNumber == null);
        System.assert(objValue.invoiceDate == null);
        System.assert(objValue.postingDate == null);
        System.assert(objValue.dueDate == null);
        System.assert(objValue.customerPurchaseOrderReference == null);
        System.assert(objValue.customerId == null);
        System.assert(objValue.customerNumber == null);
        System.assert(objValue.customerName == null);
        System.assert(objValue.billToName == null);
        System.assert(objValue.billToCustomerId == null);
        System.assert(objValue.billToCustomerNumber == null);
        System.assert(objValue.shipToName == null);
        System.assert(objValue.shipToContact == null);
        System.assert(objValue.sellToAddressLine1 == null);
        System.assert(objValue.sellToAddressLine2 == null);
        System.assert(objValue.sellToCity == null);
        System.assert(objValue.sellToCountry == null);
        System.assert(objValue.sellToState == null);
        System.assert(objValue.sellToPostCode == null);
        System.assert(objValue.billToAddressLine1 == null);
        System.assert(objValue.billToAddressLine2 == null);
        System.assert(objValue.billToCity == null);
        System.assert(objValue.billToCountry == null);
        System.assert(objValue.billToState == null);
        System.assert(objValue.billToPostCode == null);
        System.assert(objValue.shipToAddressLine1 == null);
        System.assert(objValue.shipToAddressLine2 == null);
        System.assert(objValue.shipToCity == null);
        System.assert(objValue.shipToCountry == null);
        System.assert(objValue.shipToState == null);
        System.assert(objValue.shipToPostCode == null);
        System.assert(objValue.currencyId == null);
        System.assert(objValue.currencyCode == null);
        System.assert(objValue.orderId == null);
        System.assert(objValue.orderNumber == null);
        System.assert(objValue.paymentTermsId == null);
        System.assert(objValue.shipmentMethodId == null);
        System.assert(objValue.salesperson == null);
        System.assert(objValue.pricesIncludeTax == null);
        System.assert(objValue.remainingAmount == null);
        System.assert(objValue.discountAmount == null);
        System.assert(objValue.discountAppliedBeforeTax == null);
        System.assert(objValue.totalAmountExcludingTax == null);
        System.assert(objValue.totalTaxAmount == null);
        System.assert(objValue.totalAmountIncludingTax == null);
        System.assert(objValue.status == null);
        System.assert(objValue.lastModifiedDateTime == null);
        System.assert(objValue.phoneNumber == null);
        System.assert(objValue.email == null);
    }
}
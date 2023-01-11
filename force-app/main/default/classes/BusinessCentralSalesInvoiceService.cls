/**
 * @Version: 1.0
 * @Author: Frederik
 * @Copyright: 2021 Upeo Consulting
 * @Uses:
 *
 * -----------------------------------------------------------------------------------------------
 * Description: 
 *  This class is used to handle the data transformation for Sales Invoices coming from Business Central. For additional details see: BusinessCentralAccountService.
 *
 * Created: 16/09/2022
 * Last Updated: 16/09/2022
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
public with sharing class BusinessCentralSalesInvoiceService {

    public static void parseInvoiceData(HttpResponse response, String operationType){
        List<Invoice__c> invoices = new List<Invoice__c>();
        List<Sync_Error__c> errors = new List<Sync_Error__c>();
        BC_SalesInvoiceWrapper invoiceWrapper = BC_SalesInvoiceWrapper.parse(response.getBody());
        Map<String, String> invoiceMap = new Map<String, String>();

        List<Business_Central_Mapping__c> mappings = [SELECT Id, BC_Table__c, BC_Field__c, SF_Object__c, SF_Field__c FROM Business_Central_Mapping__c WHERE SF_Object__c = 'Invoice__c'];

        for(Business_Central_Mapping__c mapping : mappings) {
            invoiceMap.put(mapping.BC_Field__c, mapping.SF_Field__c);
        }

        for(BC_SalesInvoiceWrapper.Value invoice: invoiceWrapper.Value) {
            try {
                //Create a new Order record to hold the values
                Invoice__c sfInvoice = new Invoice__c();
                //Create a temporary map to hold the values for the BC Order record
                Map<String, Object> fieldsAsMap = invoice.getPopulatedFieldsAsMap();
                //system.debug('allFields = ' +fieldsAsMap);
                for (String key : fieldsAsMap.keySet()) {
                    //system.debug('key: ' + key + ' value: ' + fieldsAsMap.get(key));
                    if (invoiceMap.get(key) != null) {
                        if(key == 'customerId'){
                            //System.debug('customerId: ' + invoiceMap.get(key));
                            Account parentAccount = new Account(Business_Central_Id__c = (String) fieldsAsMap.get(key));
                            sfInvoice.Account__r = parentAccount;
                        } else if(key == 'billToCustomerId'){
                            //System.debug('billToCustomerId: ' + invoiceMap.get(key));
                            Account billToAccount = new Account(Business_Central_Id__c = (String) fieldsAsMap.get(key));
                            sfInvoice.Bill_to__r = billToAccount;
                            //Catching cases where the requested Delivery Date is a strange value
                        } else if (key == 'requestedDeliveryDate' && fieldsAsMap.get(key).toString() == 'Mon Jan 03 00:00:00 GMT 1') {
                            //do nothing
                        } else if (key == 'orderId' && fieldsAsMap.get(key) != '00000000-0000-0000-0000-000000000000') {
                            Order invoiceOrder = new Order(Business_Central_Id__c = (String) fieldsAsMap.get(key));
                            sfInvoice.Order__r = invoiceOrder;
                        } else if (key == 'orderId') {
                            //do nothing
                        }
                        else {
                            sfInvoice.put(invoiceMap.get(key), fieldsAsMap.get(key));
                        }
                    }
                }
                sfInvoice.Last_Business_Central_Sync__c = System.now();
                invoices.add(sfInvoice);
            } catch (Exception e) {
                system.debug('Error: ' + e);
                //Write the error records to the Sync Error object
                Sync_Error__c syncError = new Sync_Error__c();
                syncError.Error_Message__c = e.getMessage();
                syncError.Type__c = 'Invoice';
                syncError.Business_Central_Id__c = invoice.id;
                syncError.Record__c = (String)invoice.toString();
                errors.add(syncError);
            }
        }

        system.debug('Invoice size = ' + invoices.size());
        //Get the Field token for the External Id so that we can use it for the upsert
        Schema.SObjectField f = Invoice__c.Fields.Business_Central_Id__c;
        //Upsert the Account records and catch the exceptions
        List<Database.UpsertResult> results = Database.upsert(invoices, f,  false);
        Integer successCount = 0;
        Integer errorCount = 0;
        for(Integer i = 0; i < results.size(); i++) {
            if(results[i].isSuccess()){
                successCount++;
            }
            if(!results[i].isSuccess()) {
                errorCount++;
                Sync_Error__c syncError = new Sync_Error__c();
                syncError.Error_Message__c = results[i].getErrors()[0].getStatusCode() + '-' +results[i].getErrors()[0].getMessage();
                syncError.Record__c = JSON.serialize(invoices[i]);
                syncError.Business_Central_Id__c = invoices[i].Business_Central_Id__c;
                syncError.Type__c = 'Invoice Upsert';
                errors.add(syncError);
            }
        }
        insert errors;

        //Create a Sync Result record with the date and the number of records that were synced
        Sync_Result__c newSyncResult = new Sync_Result__c();
        newSyncResult.Sync_Date_Time__c = System.now();
        newSyncResult.Object__c = 'Invoice';
        newSyncResult.Operation__c = operationType;
        newSyncResult.Successful_Records__c = successCount;
        newSyncResult.Error_Records__c = errorCount;
        insert newSyncResult;
    }
}
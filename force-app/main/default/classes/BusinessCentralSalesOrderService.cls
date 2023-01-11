/**
 * @Version: 1.0
 * @Author: Frederik
 * @Copyright: 2021 Upeo Consulting
 * @Uses:
 *
 * -----------------------------------------------------------------------------------------------
 * Description: 
 *  This class is used to handle the data transformation for Sales Orders coming from Business Central. For additional details see: BusinessCentralAccountService.
 *
 * Created: 16/09/2022
 * Last Updated: 16/09/2022
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
public with sharing class BusinessCentralSalesOrderService {

    public static void parseOrderData(HttpResponse response, String operationType){
        List<Order> orders = new List<Order>();
        List<Sync_Error__c> errors = new List<Sync_Error__c>();
        BC_SalesOrderWrapper orderWrapper = BC_SalesOrderWrapper.parse(response.getBody());
        Map<String, String> orderMap = new Map<String, String>();

        List<Business_Central_Mapping__c> mappings = [SELECT Id, BC_Table__c, BC_Field__c, SF_Object__c, SF_Field__c FROM Business_Central_Mapping__c WHERE SF_Object__c = 'Order'];

        for(Business_Central_Mapping__c mapping : mappings) {
            orderMap.put(mapping.BC_Field__c, mapping.SF_Field__c);
        }

        for(BC_SalesOrderWrapper.Value order: orderWrapper.Value) {
            try {
                //Create a new Order record to hold the values
                Order sfOrder = new Order();
                //Create a temporary map to hold the values for the BC Order record
                Map<String, Object> fieldsAsMap = order.getPopulatedFieldsAsMap();
                system.debug('allFields = ' +fieldsAsMap);
                for (String key : fieldsAsMap.keySet()) {
                    //system.debug('key: ' + key + ' value: ' + fieldsAsMap.get(key));
                    if (orderMap.get(key) != null) {
                        if(key == 'customerId'){
                            //System.debug('customerId: ' + orderMap.get(key));
                            Account parentAccount = new Account(Business_Central_Id__c = (String) fieldsAsMap.get(key));
                            sfOrder.Account = parentAccount;
                        } else if(key == 'billToCustomerId'){
                            //System.debug('billToCustomerId: ' + orderMap.get(key));
                            Account billToAccount = new Account(Business_Central_Id__c = (String) fieldsAsMap.get(key));
                            sfOrder.Bill_to__r = billToAccount;
                        //Catching cases where the requested Delivery Date is a strange value
                        } else if (key == 'requestedDeliveryDate' && fieldsAsMap.get(key).toString() == 'Mon Jan 03 00:00:00 GMT 1') {
                            //do nothing
                            System.debug('weird del date = '+ fieldsAsMap.get(key));
                            System.debug(fieldsAsMap.get(key).toString());
                        }
                        else {
                            sfOrder.put(orderMap.get(key), fieldsAsMap.get(key));
                        }
                    }
                }
                sfOrder.Last_Business_Central_Sync__c = System.now();
                orders.add(sfOrder);
            } catch (Exception e) {
                //Write the error records to the Sync Error object
                Sync_Error__c syncError = new Sync_Error__c();
                syncError.Error_Message__c = e.getMessage();
                syncError.Type__c = 'Order';
                syncError.Business_Central_Id__c = order.id;
                syncError.Record__c = (String)order.toString();
                errors.add(syncError);
            }
        }

        system.debug('order size = ' + orders.size());
        //Get the Field token for the External Id so that we can use it for the upsert
        Schema.SObjectField f = Order.Fields.Business_Central_Id__c;
        //Upsert the Account records and catch the exceptions
        List<Database.UpsertResult> results = Database.upsert(orders, f,  false);
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
                syncError.Record__c = JSON.serialize(orders[i]);
                syncError.Type__c = 'Order Upsert';
                errors.add(syncError);
            }
        }
        insert errors;

        //Create a Sync Result record with the date and the number of records that were synced
        Sync_Result__c newSyncResult = new Sync_Result__c();
        newSyncResult.Sync_Date_Time__c = System.now();
        newSyncResult.Object__c = 'Order';
        newSyncResult.Operation__c = operationType;
        newSyncResult.Successful_Records__c = successCount;
        newSyncResult.Error_Records__c = errorCount;
        insert newSyncResult;
    }
}
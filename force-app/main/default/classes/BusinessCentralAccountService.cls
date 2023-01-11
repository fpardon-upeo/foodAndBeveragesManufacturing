/**
 * @Version: 1.0
 * @Author: Frederik
 * @Copyright: 2022 Upeo Consulting
 * @Uses:
 *  BC_AccountWrapper
 *  Business_Central_Mapping__c SObject
 *  Sync_Errors__c SObject
 *  Sync_Result__c SObject
 *
 * -----------------------------------------------------------------------------------------------
 * Description:
 *  This is the main class that's used to sync data from Business Central to Salesforce.
 *  The mapping between the two systems is done in the Business_Central_Mapping__c SObject. The decision to put this in an SObject and not in a Custom Metadata Type
 *  is based on the fact that there will be no dedicated in-house Admin at Belmoca. So in order to keep the maintenance of the mapping as simple as possible,
 *  we decided to put it in an SObject.
 *  The mapping is done by using the SF_Object__c as the main identifier. This is the Salesforce Object that will be updated.
 *  The BC_Table__c is the Business Central table or expanded table that will be used to get the data from. In the case of the customer table for example, we have
 *  mappings for 'customer', 'paymentTerm', 'shipmentMethod' and 'customerFinancialDetail'. Except for 'customer' These are all expanded tables that are used to get the data from.
 *  The BC_Field__c is the field in the Business Central table that will be used to get the data from. The SF_Field__c is the field in the Salesforce Object that will be updated.
 *
 *  If extra expanded tables come into scope, the BC_AccountWrapper class will need to be updated to include the new expanded table.
 *  The expanded table will also need to be added to the URL for the GET request in the getAccountDataDelta() and getAccountDataAll methods.
 *
 *
 * Created: 15/09/2022
 * Last Updated: 15/09/2022
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
public with sharing class BusinessCentralAccountService {

    public static void parseAccountData(HttpResponse response, String operationType){
        List<Account> accounts = new List<Account>();
        List<Sync_Error__c> errors = new List<Sync_Error__c>();
        BC_AccountWrapper accountWrapper = BC_AccountWrapper.parse(response.getBody());
        Map<String, String> accountMap = new Map<String, String>();
        Map<String, String> paymentTermMap = new Map<String, String>();
        Map<String, String> shippingMethodMap = new Map<String, String>();
        Map<String, String> customerFinancialDetailMap = new Map<String, String>();

        //Get Business Central Mapping values
        List<Business_Central_Mapping__c> mappings = [SELECT Id, BC_Table__c, BC_Field__c, SF_Object__c, SF_Field__c FROM Business_Central_Mapping__c WHERE SF_Object__c = 'Account'];

        //Loop through the mapping values and create maps of the values.
        // The accountMap contains the fields that are directly on the Customer record.
        // The paymentTermMap contains the fields that are on the expanded paymentTerm object on the Customer record.
        // The shippingMethodMap contains the fields that are on the expanded shippingMethod object on the Customer record.
        // The maps contain the Business Central field name as the key and the Salesforce field name as the value.
        for(Business_Central_Mapping__c mapping : mappings) {
            //system.debug('mapping Field and Table = ' +mapping.BC_Field__c +' & '+mapping.BC_Table__c);
            if(mapping.BC_Table__c == 'customer') {
                accountMap.put(mapping.BC_Field__c, mapping.SF_Field__c);
                //system.debug('is customer value ' + mapping.BC_Table__c + ' - ' +mapping.BC_Field__c);
            } else if(mapping.BC_Table__c == 'paymentTerm') {
                //system.debug('is paymentTerm value ' + mapping.BC_Table__c);
                paymentTermMap.put(mapping.BC_Field__c, mapping.SF_Field__c);
            } else if(mapping.BC_Table__c == 'shipmentMethod') {
                //system.debug('is shipmentMethod value ' + mapping.BC_Table__c);
                shippingMethodMap.put(mapping.BC_Field__c, mapping.SF_Field__c);
            } else if(mapping.BC_Table__c == 'customerFinancialDetail') {
                //system.debug('is financial detail');
                customerFinancialDetailMap.put(mapping.BC_Field__c, mapping.SF_Field__c);
            }
        }

        system.debug('!!!! after mapping logic');

        for(BC_AccountWrapper.Value account: accountWrapper.Value) {
            System.debug(account);
            if (account.displayName != '') {
                system.debug(account.customerFinancialDetail);
                try {
                    //system.debug('account name: ' + account.displayName);
                    //Create a new Account record to hold the values
                    Account sfAccount = new Account();
                    //Create a temporary map to hold the values for the BC Customer record
                    Map<String, Object> fieldsAsMap = account.getPopulatedFieldsAsMap();
                    //Loop through the customer record as defined in the fieldsAsMap map
                    for (String key : fieldsAsMap.keySet()) {
                        system.debug('key = ' +key);
                        if (key == 'paymentTerm' && fieldsAsMap.get(key) != null) {
                            //System.debug('accMap+ ' +accountMap.get(key) +'=' +fieldsAsMap.get(key));
                            //System.debug('Payment Term');
                            for (String paymentTermKey : paymentTermMap.keySet()) {
                                Object paymentTermValue = fieldsAsMap.get(key);
                                Map<String, Object> paymentTermFieldsAsMap = account.paymentTerm.getPopulatedFieldsAsMap();
                                //system.debug('paymentTermValue: ' + paymentTermValue);
                                //system.debug('paymentMap ' +paymentTermMap.get(paymentTermKey) + ':'  +paymentTermFieldsAsMap.get(paymentTermKey));
                                if (paymentTermMap.get(paymentTermKey) != null) {
                                    sfAccount.put(paymentTermMap.get(paymentTermKey), paymentTermFieldsAsMap.get(paymentTermKey));
                                }
                            }
                        }
                        //If the key equals shipmentMethod, then we need to loop through the shippingMethodMap object map and get the values we need from it
                        else if (key == 'shipmentMethod' && fieldsAsMap.get(key) != null) {
                            //System.debug('accMap+ ' +accountMap.get(key) +'=' +fieldsAsMap.get(key));
                            //System.debug('Shipment Method');
                            for (String shipmentMethodKey : shippingMethodMap.keySet()) {
                                Map<String, Object> shipmentMethodFieldsAsMap = account.shipmentMethod.getPopulatedFieldsAsMap();
                                //system.debug('shipmentMethodValue: ' + shipmentMethodValue);
                                //system.debug('shipmentMethodMap ' +shippingMethodMap.get(shipmentMethodKey) + ':'  +shipmentMethodFieldsAsMap.get(shipmentMethodKey));
                                if (shippingMethodMap.get(shipmentMethodKey) != null) {
                                    //system.debug('shipping method = '+shipmentMethodFieldsAsMap.get(shipmentMethodKey));
                                    sfAccount.put(shippingMethodMap.get(shipmentMethodKey), shipmentMethodFieldsAsMap.get(shipmentMethodKey));
                                }
                            }
                        }
                        else if (key == 'customerFinancialDetail' && fieldsAsMap.get(key) != null) {
                            System.debug('customerFinancialDetail');
                            for (String customerFinancialDetailKey : customerFinancialDetailMap.keySet()) {
                                Map<String, Object> customerFinancialDetailFieldsAsMap = account.customerFinancialDetail.getPopulatedFieldsAsMap();
                                system.debug('customerFinancialDetailMap ' +customerFinancialDetailFieldsAsMap.get(customerFinancialDetailKey) + ':'  +customerFinancialDetailFieldsAsMap.get(customerFinancialDetailKey));
                                if (customerFinancialDetailMap.get(customerFinancialDetailKey) != null) {
                                    sfAccount.put(customerFinancialDetailMap.get(customerFinancialDetailKey), customerFinancialDetailFieldsAsMap.get(customerFinancialDetailKey));
                                }
                            }
                        } else {
                            if (accountMap.get(key) != null) {
                                //System.debug(key + ' : ' + accountMap.get(key));
                                //system.debug(accountMap.get(key) +'=' +fieldsAsMap.get(key));
                                //If the field is on the Account record, set the value on the Account record
                                sfAccount.put(accountMap.get(key), fieldsAsMap.get(key));
                            }
                            //If the key equals paymentTerm, then we need to loop through the paymentTerm object map and get the values we need from it
                        }
                    }
                    sfAccount.Last_Business_Central_Sync__c = System.now();
                    System.debug('@@@@@'+sfAccount.Total_Sales_Excl_Tax__c);
                    accounts.add(sfAccount);

                }
                catch (Exception e) {
                    //Write the error records to the Sync Error object
                    Sync_Error__c syncError = new Sync_Error__c();
                    syncError.Error_Message__c = e.getMessage();
                    syncError.Type__c = 'Account';
                    syncError.Business_Central_Id__c = account.id;
                    syncError.Record__c = (String)account.toString();
                    errors.add(syncError);
                }
            }
        }

        //Get the Field token for the External Id so that we can use it for the upsert
        Schema.SObjectField f = Account.Fields.Business_Central_Id__c;
        //Upsert the Account records and catch the exceptions
        List<Database.UpsertResult> results = Database.upsert(accounts, f,  false);
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
                syncError.Record__c = JSON.serialize(accounts[i]);
                syncError.Type__c = 'Account Upsert';
                errors.add(syncError);
            }
        }
        insert errors;

        //Create a Sync Result record with the date and the number of records that were synced
        Sync_Result__c newSyncResult = new Sync_Result__c();
        newSyncResult.Sync_Date_Time__c = System.now();
        newSyncResult.Successful_Records__c = successCount;
        newSyncResult.Error_Records__c = errorCount;
        newSyncResult.Object__c = 'Account';
        newSyncResult.Operation__c = operationType;
        insert newSyncResult;
    }

}
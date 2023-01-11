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
 * Created: 5/10/2022
 * Last Updated: 5/10/2022
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
public with sharing class DetailButtonController
{

    private ApexPages.StandardController standardController;


    public DetailButtonController(ApexPages.StandardController standardController) {
        this.standardController = standardController;
    }



    public pageReference  doSomething() {
        // Apex code for handling record from a Detail page goes here
        Id recordId = standardController.getId();
        Sync_Error__c record = [SELECT Id, Name, Type__c,Business_Central_Id__c, Resolution_Status__c FROM Sync_Error__c WHERE Id = :recordId];
        String result;
        Boolean success = true;
        String returnMessage = null;
        If(record != null) {
            System.debug('record: ' + record);
            if(record.Type__c == 'Invoice Upsert') {
                BusinessCentralSyncService.getInvoiceDataSingle(record.Business_Central_Id__c);
                record.Resolution_Status__c = 'Resolved';
                update record;
            }
            if(record.Type__c == 'Account') {
                BusinessCentralSyncService.getSingleAccountData(record.Business_Central_Id__c);
                record.Resolution_Status__c = 'Resolved';
                update record;
            }
            if(record.Type__c == 'Account Upsert') {
                BusinessCentralSyncService.getSingleAccountData(record.Business_Central_Id__c);
                record.Resolution_Status__c = 'Resolved';
                update record;
            }
        }
        PageReference pageRef = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + recordId);
        pageRef.setRedirect(true);
        return pageRef;
    }

}
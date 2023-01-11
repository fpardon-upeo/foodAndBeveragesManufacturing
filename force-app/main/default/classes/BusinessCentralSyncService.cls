/**
 * @Version: 1.0
 * @Author: Frederik
 * @Copyright: 2022 Upeo Consulting
 * @Uses:
 *  BusinessCentralAccountService
 *
 * -----------------------------------------------------------------------------------------------
 * Description: 
 *  This class is used to handle the callouts to Business Central
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
public with sharing class BusinessCentralSyncService {

    // -----------------------------------------------------------------------------------------------
    //                                      Account Sync
    // -----------------------------------------------------------------------------------------------

    @Future(callout=true)
    public static void getAccountDataDelta(){

        Sync_Result__c syncResult = [SELECT Id, Sync_Date_Time__c FROM Sync_Result__c WHERE Object__c = 'Account' AND Operation__c != 'Single' ORDER BY LastModifiedDate DESC LIMIT 1];

        Datetime lastSyncDate = syncResult.Sync_Date_Time__c;
        String syncDateFormatted = lastSyncDate.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS')+ 'Z';
        system.debug('lastSyncDate: ' + lastSyncDate);
        system.debug('syncDateFormatted: ' + syncDateFormatted);
        system.debug('sycnResult Date: ' + syncResult.Sync_Date_Time__c);
        String url = 'callout:BusinessCentral/customers?$expand=paymentTerm,shipmentMethod,customerFinancialDetail&$filter=lastModifiedDateTime ge ' + syncDateFormatted;
        url = url.replace(' ', '%20');
        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            BusinessCentralAccountService.parseAccountData(response, 'Delta');
        }
    }

    @Future(callout=true)
    public static void getAccountDataAll(){


        String url = 'callout:BusinessCentral/customers?$expand=paymentTerm,shipmentMethod,customerFinancialDetail';
        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            BusinessCentralAccountService.parseAccountData(response, 'All');
        }
    }

    @Future(callout=true)
    public static void getSingleAccountData(String accountNumber){


        String url = 'callout:BusinessCentral/customers?$expand=paymentTerm,shipmentMethod,customerFinancialDetail&$filter=id%20eq%20'+accountNumber;
        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            system.debug(response.getBody());
            BusinessCentralAccountService.parseAccountData(response, 'Single');
        }
    }

    // -----------------------------------------------------------------------------------------------
    //                                      Order Sync
    // -----------------------------------------------------------------------------------------------

    @Future(callout=true)
    public static void getOrderDataAll(){

        String url = 'callout:BusinessCentral/salesOrders';
        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            BusinessCentralSalesOrderService.parseOrderData(response, 'All');
        }
    }

    @Future(callout=true)
    public static void getOrderDataDelta(){

        Sync_Result__c syncResult = [SELECT Id, Sync_Date_Time__c FROM Sync_Result__c WHERE Object__c = 'Order' AND Operation__c != 'Single' ORDER BY LastModifiedDate DESC LIMIT 1];

        Datetime lastSyncDate = syncResult.Sync_Date_Time__c;
        String syncDateFormatted = lastSyncDate.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS')+ 'Z';
        system.debug('lastSyncDate: ' + lastSyncDate);
        system.debug('syncDateFormatted: ' + syncDateFormatted);
        system.debug('sycnResult Date: ' + syncResult.Sync_Date_Time__c);
        String url = 'callout:BusinessCentral/salesOrders?$filter=lastModifiedDateTime ge ' + syncDateFormatted;
        url = url.replace(' ', '%20');
        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            BusinessCentralSalesOrderService.parseOrderData(response, 'Delta');
        }
    }

    @Future(callout=true)
    public static void getOrderDataSingle(String orderNumber){


        String url = 'callout:BusinessCentral/salesOrders?$filter=id%20eq%20'+orderNumber;
        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            system.debug(response.getBody());
            BusinessCentralSalesOrderService.parseOrderData(response, 'Single');
        }
    }

    // -----------------------------------------------------------------------------------------------
    //                                      Invoice Sync
    // -----------------------------------------------------------------------------------------------

    @Future(callout=true)
    public static void getInvoiceDataAll(){

        String url = 'callout:BusinessCentral/salesInvoices';
        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            BusinessCentralSalesInvoiceService.parseInvoiceData(response, 'All');
        }
    }

    @Future(callout=true)
    public static void getInvoiceDataDeltaPaid(){

        System.debug('getInvoiceDataDeltaPaid');
        Sync_Result__c syncResult = [SELECT Id, Sync_Date_Time__c FROM Sync_Result__c WHERE Object__c = 'Invoice' AND Operation__c = 'Delta - Paid' ORDER BY LastModifiedDate DESC LIMIT 1];

        Datetime lastSyncDate = syncResult.Sync_Date_Time__c;
        String syncDateFormatted = lastSyncDate.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS')+ 'Z';
        system.debug('lastSyncDate: ' + lastSyncDate);
        system.debug('syncDateFormatted: ' + syncDateFormatted);
        system.debug('sycnResult Date: ' + syncResult.Sync_Date_Time__c);
        String url = 'callout:BusinessCentral/salesInvoices?$filter=status eq \'paid\' and lastModifiedDateTime ge ' + syncDateFormatted;
        url = url.replace(' ', '%20');

        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            BusinessCentralSalesInvoiceService.parseInvoiceData(response, 'Delta - Paid');
        }
    }

    @Future(callout=true)
    public static void getInvoiceDataDeltaOpen(){

        System.debug('getInvoiceDataDeltaOpen');
        Sync_Result__c syncResult = [SELECT Id, Sync_Date_Time__c FROM Sync_Result__c WHERE Object__c = 'Invoice' AND Operation__c = 'Delta - Open' ORDER BY LastModifiedDate DESC LIMIT 1];

        Datetime lastSyncDate = syncResult.Sync_Date_Time__c;
        String syncDateFormatted = lastSyncDate.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS')+ 'Z';
        system.debug('lastSyncDate: ' + lastSyncDate);
        system.debug('syncDateFormatted: ' + syncDateFormatted);
        system.debug('sycnResult Date: ' + syncResult.Sync_Date_Time__c);
        String url = 'callout:BusinessCentral/salesInvoices?$filter=status ne \'paid\' and lastModifiedDateTime ge ' + syncDateFormatted;
        url = url.replace(' ', '%20');

        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            BusinessCentralSalesInvoiceService.parseInvoiceData(response, 'Delta - Open');
        }
    }

    @Future(callout=true)
    public static void getInvoiceDataSingle(String invoiceNumber){


        String url = 'callout:BusinessCentral/salesInvoices?$filter=id%20eq%20'+invoiceNumber;
        HttpResponse response = doCallOut(url, 'GET');

        if(response.getBody() != null && response.getStatusCode() == 200){
            system.debug(response.getBody());
            BusinessCentralSalesInvoiceService.parseInvoiceData(response, 'Single');
        }
    }

    // -----------------------------------------------------------------------------------------------
    //                                      Callout
    // -----------------------------------------------------------------------------------------------

    Public static HttpResponse doCallOut(String url, string method){

        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        system.debug(req.getEndpoint());
        req.setMethod(method);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res;
    }

}
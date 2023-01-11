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
 * Created: 20/09/2022
 * Last Updated: 20/09/2022
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
public with sharing class AccountService {

    @Future
    public static void updateAccountTotals(){

        List<Order> orders = [SELECT Id, AccountId, Bill_to__c, Total_Amount_Including_Tax__c FROM Order where Total_Amount_Including_Tax__c != 0 or Total_Amount_Including_Tax__c != null LIMIT 200];
        List<String> accountIds = new List<String>();
        List<Account> accounts = new List<Account>();

        for(Order order : orders){
            if(!accountIds.contains(order.AccountId)){
                accountIds.add(order.AccountId);
            }
        }

        system.debug('accountIds: ' + accountIds.size());

        for(String account : accountIds){
            Decimal totalAmount = 0;
            for(Order order : orders){
                if(account == order.AccountId){
                    totalAmount = totalAmount + order.Total_Amount_Including_Tax__c;
                }
            }
            system.debug('account: ' + account + ' totalAmount: ' + totalAmount);
            Account acc = new Account(Id=account, Bill_to_Total_Sales_Incl_Tax__c=totalAmount);
            accounts.add(acc);
        }

        update accounts;

    }

    @Future
    public static void updateAccountBillToTotals(){

        List<Order> orders = [SELECT Id, AccountId, Bill_to__c, Total_Amount_Including_Tax__c FROM Order];
        List<String> accountIds = new List<String>();
        List<Account> accounts = new List<Account>();

        for(Order order : orders){
            if(!accountIds.contains(order.Bill_to__c) && order.Bill_to__c != order.AccountId){
                accountIds.add(order.Bill_to__c);
            }
        }

        system.debug('accountIds: ' + accountIds.size());

        for(String billTo : accountIds){
            Decimal totalAmount = 0;
            for(Order order : orders){
                if(billTo == order.Bill_to__c){
                    totalAmount = totalAmount + order.Total_Amount_Including_Tax__c;
                }
            }
            system.debug('billTo: ' + billTo + ' totalAmount: ' + totalAmount);
            Account acc = new Account(Id=billTo, Bill_to_Total_Sales_Incl_Tax__c=totalAmount);
            accounts.add(acc);
        }

        update accounts;

    }
}
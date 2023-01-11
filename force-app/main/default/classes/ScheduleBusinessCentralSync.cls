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
 * Created: 15/09/2022
 * Last Updated: 15/09/2022
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
global class ScheduleBusinessCentralSync Implements Schedulable{
    global void execute(SchedulableContext sc){
        getAccountData();
    }

    public void getAccountData() {
        BusinessCentralSyncService.getAccountDataDelta();
        BusinessCentralSyncService.getOrderDataDelta();
        BusinessCentralSyncService.getInvoiceDataDeltaPaid();
        BusinessCentralSyncService.getInvoiceDataDeltaOpen();
    }
}
@isTest
public class customLookUpControllerTest {
    
    @testSetup static void methodName() {
        Account acnt = new Account(name='test Account');
        insert acnt;
    }
    
    public static testMethod void fetchLookUpValuesMethod(){
        customLookUpController.fetchLookUpValues('Pune');
    }
    
    public static testMethod void fetchAddressMethod(){
        customLookUpController.fetchAddress('ChIJUdztPG67wjsRErWbfYac1la');
    }
    
    public static testMethod void saveAddressInAccountMethod(){
        Account acnt = [SELECT Id FROM Account LIMIT 1];
        customLookUpController.saveAddressInAccount(acnt.Id, 'Hinjewadi', 'Pune', 'Maharashtra', 'India', '410027');
    }
}
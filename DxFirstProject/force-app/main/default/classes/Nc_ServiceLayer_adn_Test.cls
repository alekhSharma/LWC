@isTest(seeAllData=false)
private class Nc_ServiceLayer_adn_Test {
    private static testMethod void updateRecordsTest_Positive() {
        Test.StartTest();
        	//Invoke insert
        	Nc_ServiceLayer_adn.updateRecords(new list<Account>{new Account(Name='Demo Name1'),new Account(Name='Demo Name2')},true,'insert');
        	//Assert - Account should be inserted
        	System.Assert([select count() from Account]!=0);
        	
        	//Update Account
        	Account accRecord = [select id from Account limit 1];
        	Nc_ServiceLayer_adn.updateRecords(new list<Account>{accRecord},true,'update');
        Test.StopTest();
    }
    private static testMethod void updateRecordsTest_Negative() {
        Test.StartTest();
        	//Invoke insert - It would be failed as lastname is required in contact
        	Nc_ServiceLayer_adn.updateRecords(new list<Contact>{new Contact(FirstName='Demo Name1')},false,'insert');
        	//Assert - No Contact record should be inserted
        	System.Assert([select count() from Account]==0);
        Test.StopTest();
    }
}
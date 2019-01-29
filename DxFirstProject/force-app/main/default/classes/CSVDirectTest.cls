@isTest
public class CSVDirectTest {
    
    @isTest static void testCSVDirect(){
 
        List<Account> lstAccount = new List<Account>();
        Account testAccount = new Account(name='Test Account');
        Account testAccount1 = new Account(name='account 2');
        lstAccount.add(testAccount);
        lstAccount.add(testAccount1);
        insert lstAccount;
        
         list<list<string>> names 	= new list<list<string>>();
        list<string> mylist 	 	= new list<string>();
         mylist.add('Account');
         mylist.add('Recent');
          names.add(mylist);
        
        
     	Test.startTest();
       	 Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorCSV()); 
    	list<list<String>> result = ListViewApi.fetchListviewRecords(names);
        Test.setCurrentPage(page.AccountList);
        List<Account> lstCase = [select id,name from Account];
      
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstCase);
        
        stdSetController.setSelected(lstAccount);
        
        CSVDirect ext = new CSVDirect(stdSetController);
       
		Test.stopTest();
    }
}
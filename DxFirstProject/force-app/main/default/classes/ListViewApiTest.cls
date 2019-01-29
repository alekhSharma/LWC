@isTest
public class ListViewApiTest{
    @isTest
    public static void basicCodeCoverage(){
        
        list<list<string>> names 	= new list<list<string>>();
        list<string> mylist 	 	= new list<string>();
         mylist.add('Account');
         mylist.add('Recent');
          names.add(mylist);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorCSV()); 
    	list<list<String>> result = ListViewApi.fetchListviewRecords(names);
        Test.StopTest();
     }
}
@isTest
global class CSVGenFromLstViewControllerTest implements HttpCalloutMock {	
     global HttpResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setStatus('SUCCESS');
        res.setStatusCode(200);
        res.setBody('"{"columns":[{"ascendingLabel":"Z-A","descendingLabel":"A-Z"}]"}"');
        return res;
      }
    public static testmethod void basicCOverage(){
        CSVGenFromLstViewController ListViewCSV = New CSVGenFromLstViewController();
        CSVGenFromLstViewController.objectNamefromPrefix('001');
        CSVGenFromLstViewController.getListViewLst('Account');
        String strLiewId=CSVGenFromLstViewController.getListViewLst('Account')[0].id;
        Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new CSVGenFromLstViewControllerTest());
        CSVGenFromLstViewController.getCSVData('Account',strLiewId);  
        Test.StopTest();
     }
}
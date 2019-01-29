public class exporrtDataString {
    
    public string exportDataString {get;set;}
     public exporrtDataString(ApexPages.StandardSetController controller) {
             
    } 
    public PageReference goToExcelExportPage(){
        return Page.AccountList;
    }

}
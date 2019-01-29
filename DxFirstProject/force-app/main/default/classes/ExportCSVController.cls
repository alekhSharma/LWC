public class ExportCSVController {
	
    
    public  String  headerdata{get;set;}
    public string urlvalue{get;set;}
    public string url{get;set;}
         
    public ExportCSVController(){
         
         headerdata= ApexPages.currentPage().getHeaders().get('Host');
         
         urlvalue=Apexpages.currentPage().getUrl();
         
         url='https://' + headerdata+ urlvalue;
    }
    
}
public with sharing class CSVDirect {

    public list<list<string>> names = new list<list<string>>();
    public list<string> mylist 		= new list<string>();
    public list<string> Records		= new list<string>();
    
    public List<String> 		columnName {get;set;}
    public list<list<String>> 	allRecords {get;set;}
    public list<list<string>> 	names1{get;set;}
 
    public string 				headerdata{get;set;}
    public string 				urlvalue{get;set;}
    public string 				url{get;set;}

    public CSVDirect(ApexPages.StandardSetController controller) {
         allRecords = new list<list<string>>();
          names1 	= new list<list<string>>();
        	
         // Pattern creation to filter the filtername from the URL.
         Pattern p 	= Pattern.compile('((filterName)[%3D][0-9a-zA-Z]+)');
        
         // Getting the Current page URL.
         url 		= ApexPages.currentPage().geturl();
         Matcher pm = p.matcher(url);
        
         system.debug('Url'+url);
         
         // Exacting out the filter name from the URL.
         if(pm.find())
         {
	     urlvalue 	= (pm.group(1)).remove('filterName%3D');     
         } 
     	
         mylist.add('Account');
         mylist.add(urlvalue);
          names.add(mylist);
   		
         // fetching the Data from the object using the ListViewAPI
         names1 		= listviewAPI.fetchListviewRecords(names);
        	
         // header for the table
         columnName 	= names1[0][0].split(',');    

         // Data for the table
         Records 		= names1[0][1].split('\n'); 
        
         // Preparing data for Excel 
         for(integer i=0;i<Records.size();i++){
     	 allRecords.add(Records.get(i).split(','));
        }  
    }      
}
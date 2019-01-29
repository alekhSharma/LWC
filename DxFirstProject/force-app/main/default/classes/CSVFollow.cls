public class CSVFollow {
    
     public pagereference pr;
    
    public CSVFollow(ApexPages.StandardSetController controller) {
             
         method2();
        
    } 
    
     public pageReference method2(){
        	
        pr = new pagereference('/apex/contactView');
		
         //pr = new pagereference('/one/one.app#/sObject/Account/list?filterName=Recent');
        
         return pr;
    }
    
    
    
  
    
}
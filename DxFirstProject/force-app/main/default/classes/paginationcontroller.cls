public class paginationcontroller {
 public List<alekhcognizant__pagination__c> conList {get;set;}
   static integer i=1;
    integer a =0;
   
    
    public list<alekhcognizant__pagination__c> getContactLists()
    { 	
        conList = new list<alekhcognizant__pagination__c>();  
        conlist = getcreateEmptyRecord();
     	return conList;
    }       
    
    public list<alekhcognizant__pagination__c> getcreateEmptyRecord(){
        for(a=i;a<i+5;a++){
            conlist.add(new alekhcognizant__pagination__c(alekhcognizant__PName__c=a+''));
        }
        system.debug(conlist);
        return conlist;
    }
    
     public PageReference createEmptyRecordPR(){
         i=i+5;
        conlist = getcreateEmptyRecord(); 
         system.debug('inside method'+i);
        return null;
    }
    
    public PageReference EmptyRecordPR(){
        if(i>5){
         system.debug('inside method'+i);
        }
        return null;
    }
}
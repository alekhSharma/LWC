public class leadwrappercontainer {
 //this class serves as the wrapper class to include checkbox and lead record
        @AuraEnabled public lead leadValue{get;set;}
        @AuraEnabled public boolean checked{get;set;}
        
          public leadwrappercontainer(lead leadObj){
            leadValue=leadObj;
            checked=false;
        }
       public leadwrappercontainer(){
            
        }
}
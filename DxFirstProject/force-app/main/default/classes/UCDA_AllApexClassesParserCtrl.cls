public class UCDA_AllApexClassesParserCtrl {
    
    
    @AuraEnabled public Integer size {get;set;} 
    @AuraEnabled public Integer totalSize {get;set;} 
    @AuraEnabled public Boolean done {get;set;} 
    @AuraEnabled public String queryLocator {get;set;} 
    @AuraEnabled public String entityTypeName {get;set;} 
    @AuraEnabled public List<Records> records {get;set;} 
    
    
    public class Attributes {
        
        @AuraEnabled public String type_Z {get;set;} // in json: type
        @AuraEnabled public String url {get;set;} 
        
    } 
    
    public class Records {
        @AuraEnabled public Attributes attributes {get;set;} 
        @AuraEnabled public String Id {get;set;} 
        @AuraEnabled public String Body {get;set;} 
        @AuraEnabled public Boolean IsValid {get;set;} 
    }
}
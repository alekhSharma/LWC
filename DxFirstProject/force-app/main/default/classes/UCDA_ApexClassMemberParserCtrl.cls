public class UCDA_ApexClassMemberParserCtrl {
	@AuraEnabled public List<CompositeResponse> compositeResponse;
    
    public class Errors {
        public Errors(){}
    }
    
    public class HttpHeaders {
       public HttpHeaders(){}
       @AuraEnabled public String Location;
    }
    
    public class CompositeResponse {
       @AuraEnabled public Body body;
       @AuraEnabled public HttpHeaders httpHeaders;
       @AuraEnabled public Integer httpStatusCode;
       @AuraEnabled public String referenceId;
    }
    
    public class Body {
       @AuraEnabled public String id;
       @AuraEnabled public Boolean success;
       @AuraEnabled public List<Errors> errors;
       @AuraEnabled public List<Errors> warnings;
    }
}
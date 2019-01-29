public class UCDA_SymbolTableParserCtrl {
   @AuraEnabled public Integer size {get;set;} 
   @AuraEnabled public Integer totalSize {get;set;} 
   @AuraEnabled public Boolean done {get;set;} 
   @AuraEnabled public String queryLocator {get;set;} 
   @AuraEnabled public String entityTypeName {get;set;} 
   @AuraEnabled public List<Records> records {get;set;} 

    public UCDA_SymbolTableParserCtrl()
    {}

    public class Variables {
        public Variables(){}
        //public List<Annotations> annotations {get;set;} 
       @AuraEnabled public Location location {get;set;} 
        //public List<Annotations> modifiers {get;set;} 
       @AuraEnabled public String name {get;set;} 
       @AuraEnabled public List<Location> references {get;set;} 
       @AuraEnabled public String type_Z {get;set;} // in json: type
    }
    
    public class Annotations {
    }
    
    public class ExternalReferences {
       @AuraEnabled public List<Methods> methods {get;set;} 
       @AuraEnabled public String name {get;set;} 
       @AuraEnabled public String namespace {get;set;} 
       @AuraEnabled public List<Location> references {get;set;} 
        //public List<Annotations> variables {get;set;} 
    }
    
    public class Attributes {
       @AuraEnabled public String type_Z {get;set;} // in json: type
       @AuraEnabled public String url {get;set;} 
    }
    
    public class TableDeclaration {
       @AuraEnabled public List<Annotations> annotations {get;set;} 
       @AuraEnabled public Location location {get;set;} 
       @AuraEnabled public List<String> modifiers {get;set;} 
       @AuraEnabled public String name {get;set;} 
        //public List<Annotations> references {get;set;} 
       @AuraEnabled public String type_Z {get;set;} // in json: type
    }
    
    public class SymbolTable {
       @AuraEnabled public List<Constructors> constructors {get;set;} 
       @AuraEnabled public List<ExternalReferences> externalReferences {get;set;} 
       @AuraEnabled public String id {get;set;} 
       @AuraEnabled public String key {get;set;} 
       @AuraEnabled public String name {get;set;} 
       @AuraEnabled public String namespace {get;set;} 
       @AuraEnabled public String parentClass {get;set;} 
       @AuraEnabled public TableDeclaration tableDeclaration {get;set;} 
       @AuraEnabled public List<Variables> variables {get;set;} 
    }
    
    public class Constructors {
       @AuraEnabled public List<Annotations> annotations {get;set;} 
       @AuraEnabled public Location location {get;set;} 
       @AuraEnabled public List<String> modifiers {get;set;} 
       @AuraEnabled public String name {get;set;} 
        //public List<Annotations> parameters {get;set;} 
        //public List<Annotations> references {get;set;} 
       @AuraEnabled public String type_Z {get;set;} // in json: type
    }

    public class Records {
       @AuraEnabled public Attributes attributes {get;set;} 
       @AuraEnabled public String Id {get;set;} 
       @AuraEnabled public SymbolTable SymbolTable {get;set;} 
    }
    
    public class Methods {
       @AuraEnabled public List<Annotations> argTypes {get;set;} 
       @AuraEnabled public Boolean isStatic {get;set;} 
       @AuraEnabled public String methodDoc {get;set;} 
       @AuraEnabled public String name {get;set;} 
       @AuraEnabled public List<Parameters> parameters {get;set;} 
       @AuraEnabled public List<Location> references {get;set;} 
       @AuraEnabled public String returnType {get;set;} 

    }
    
    public class Parameters {
       @AuraEnabled public String name {get;set;} 
       @AuraEnabled public String type_Z {get;set;} // in json: type
    }
    
    public class Location {
       @AuraEnabled public Integer column {get;set;} 
       @AuraEnabled public Integer line {get;set;} 
    }
    
}
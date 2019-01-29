public class UCDA_GetAllMethodsParser {
    
    @AuraEnabled public List<CompositeResponse> compositeResponse {get;set;} 
    
    public class HttpHeaders {
        @AuraEnabled public String Last_Modified {get;set;} 
    }
    
    public class Parameters {
        @AuraEnabled public String name {get;set;} 
        @AuraEnabled public String type_Z {get;set;} // in json: type
    }
    
    public class CompositeResponse {
        @AuraEnabled public Body body {get;set;} 
        @AuraEnabled  public HttpHeaders httpHeaders {get;set;} 
        @AuraEnabled public Integer httpStatusCode {get;set;} 
        @AuraEnabled public String referenceId {get;set;} 
    }
    
    public class Attributes {
        @AuraEnabled public String type_Z {get;set;} // in json: type
        @AuraEnabled  public String url {get;set;} 
    }
    
    public class Metadata {
        @AuraEnabled  public String module {get;set;} 
        //   public List<Annotations> packageVersions {get;set;} 
        @AuraEnabled  public String status {get;set;} 
        @AuraEnabled public String urls {get;set;} 
    }
    
    public class TableDeclaration {
        //    public List<Annotations> annotations {get;set;} 
        @AuraEnabled  public Location location {get;set;} 
        //    public List<Annotations> modifiers {get;set;} 
        @AuraEnabled  public String name {get;set;} 
        //     public List<Annotations> references {get;set;} 
        @AuraEnabled  public String type_Z {get;set;} // in json: type
        
    }
    
    public class SymbolTable {
        @AuraEnabled  public List<Constructors> constructors {get;set;} 
        //    public List<Annotations> externalReferences {get;set;} 
        @AuraEnabled public String id {get;set;} 
        @AuraEnabled  public List<InnerClasses> innerClasses {get;set;} 
        //     public List<Annotations> interfaces {get;set;} 
        @AuraEnabled  public List<Methods> methods {get;set;} 
        @AuraEnabled public String name {get;set;} 
        @AuraEnabled  public String namespace {get;set;} 
        @AuraEnabled public String parentClass {get;set;} 
        @AuraEnabled public List<Properties> properties {get;set;} 
        @AuraEnabled public Properties tableDeclaration {get;set;} 
        @AuraEnabled public List<TableDeclaration> variables {get;set;} 
    }
    
    public class Constructors {
        //   public List<Annotations> annotations {get;set;} 
        @AuraEnabled public Location location {get;set;} 
        @AuraEnabled public List<String> modifiers {get;set;} 
        @AuraEnabled public String name {get;set;} 
        //    public List<Annotations> parameters {get;set;} 
        //     public List<Annotations> references {get;set;} 
        @AuraEnabled  public String type_Z {get;set;} // in json: type
    }
    
    public class InnerClasses {
        @AuraEnabled public List<Constructors> constructors {get;set;} 
        //    public List<Annotations> externalReferences {get;set;} 
        @AuraEnabled public String id {get;set;} 
        //     public List<Annotations> innerClasses {get;set;} 
        //     public List<Annotations> interfaces {get;set;} 
        @AuraEnabled public List<Methods> methods {get;set;} 
        @AuraEnabled public String name {get;set;} 
        @AuraEnabled public String namespace {get;set;} 
        @AuraEnabled public String parentClass {get;set;} 
        @AuraEnabled public List<Properties> properties {get;set;} 
        @AuraEnabled public TableDeclaration tableDeclaration {get;set;} 
        @AuraEnabled public List<TableDeclaration> variables {get;set;} 
        
    }
    
    public class Properties {
        //     public List<Annotations> annotations {get;set;} 
        @AuraEnabled public Location location {get;set;} 
        @AuraEnabled public List<String> modifiers {get;set;} 
        @AuraEnabled  public String name {get;set;} 
        //      public List<Annotations> references {get;set;} 
        @AuraEnabled  public String type_Z {get;set;} // in json: type
        
    }
    
    //  public class Annotations {
    //
    //  }
    
    public class Body {
        @AuraEnabled public Attributes attributes {get;set;} 
        @AuraEnabled public String Id {get;set;} 
        @AuraEnabled public String NamespacePrefix {get;set;} 
        @AuraEnabled public String Name {get;set;} 
        @AuraEnabled public String ApiVersion {get;set;} 
        @AuraEnabled public String Status {get;set;} 
        @AuraEnabled public Boolean IsValid {get;set;} 
        @AuraEnabled public String BodyCrc {get;set;} 
        @AuraEnabled public String Body {get;set;} 
        @AuraEnabled public Integer LengthWithoutComments {get;set;} 
        @AuraEnabled public String CreatedDate {get;set;} 
        @AuraEnabled public String CreatedById {get;set;} 
        @AuraEnabled public String LastModifiedDate {get;set;} 
        @AuraEnabled public String LastModifiedById {get;set;} 
        @AuraEnabled public String SystemModstamp {get;set;} 
        @AuraEnabled public String ManageableState {get;set;} 
        @AuraEnabled public SymbolTable SymbolTable {get;set;} 
        @AuraEnabled public Metadata Metadata {get;set;} 
        @AuraEnabled public String FullName {get;set;} 
    }
    
    public class Methods {
        //   public List<Annotations> annotations {get;set;} 
        @AuraEnabled public Location location {get;set;} 
        @AuraEnabled public List<String> modifiers {get;set;} 
        @AuraEnabled public String name {get;set;} 
        @AuraEnabled public List<Parameters> parameters {get;set;} 
        //   public List<Annotations> references {get;set;} 
        @AuraEnabled public String returnType {get;set;} 
        @AuraEnabled public String type_Z {get;set;} // in json: type
    }
    
    public class Location {
        @AuraEnabled public Integer column {get;set;} 
        @AuraEnabled public Integer line {get;set;} 
    }
}
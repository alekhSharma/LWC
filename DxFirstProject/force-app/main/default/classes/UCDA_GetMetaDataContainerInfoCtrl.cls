public class UCDA_GetMetaDataContainerInfoCtrl {
    public String size {get;set;} 
    public String totalSize {get;set;} 
    public Boolean done {get;set;} 
    public String queryLocator {get;set;} 
    public String entityTypeName {get;set;} 
    public List<Records> records {get;set;} 
    
    public class Attributes {
        public String type_Z {get;set;} // in json: type
        public String url {get;set;} 
        
    }
    
    public class Records {
        public Attributes attributes {get;set;} 
        public String Id {get;set;} 
        public String Name {get;set;} 
        
    }
    
}
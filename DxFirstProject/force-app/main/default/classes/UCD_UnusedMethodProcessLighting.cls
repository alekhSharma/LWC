public class UCD_UnusedMethodProcessLighting {
    
    @AuraEnabled
    public static string error {get; set;}
    public static string containerId {get; set;}
    
    
    public static void getContainerInfo()
    {
        try
        {
            UCDA_GetMetaDataContainerInfoCtrl container =  UCD_ToolingAPIServiceLighting.getContainerInfo();
            system.debug('container::'+container);
            if(integer.valueof(container.size) > 0)
            {
                list<UCDA_GetMetaDataContainerInfoCtrl.Records> listRecords = container.records;
                deleteContainer(listRecords[0].Id);
            }
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }
        
    }
   
    public static void deleteContainer(string containerId)
    {
        UCD_ToolingAPIServiceLighting.deleteContainer(containerId);
        containerId = null;
        // isEnabled = true; 
    }
     
   // @future 
    @AuraEnabled
    public static string getAllApexClasses()
    {
        try
        {
            getContainerInfo();
            UCDA_AllApexClassesParserCtrl allApexClasses = UCD_ToolingAPIServiceLighting.getAllApexClasses();
            return JSON.serialize(allApexClasses);
        }
        catch(Exception ex)
        {
            System.debug('ex:::'+ex.getMessage());
            string error = ex.getMessage();
            system.debug('error::::::'+error);
            if(error.contains('Unauthorized endpoint'))
            {
                System.debug('error::'+error);
                return ' Unauthorized endpoint'+URL.getSalesforceBaseUrl().toExternalForm();
            }
            else
            {
                System.debug('error:::::'+error);
                return null;
            }
        } 
    }
    
   // @future
    @AuraEnabled
    public static string createContainer()
    {
        //try
       // {
            string bodyContainer = '{\"Name\": \"Container2\"}';//'{\'Name\':\'Container1\'}';
            // UCDA_ToolingAPIService toolingApi = new UCDA_ToolingAPIService();
            UCDA_MetaDataContainerParserCtrl container = UCD_ToolingAPIServiceLighting.createContainer(bodyContainer);
            system.debug('container#########'+container);
            containerId = container.id;
            System.debug('containerId::'+containerId);
            return containerId;
       // }
      //  catch(Exception ex)
      //  {
       //     return null;
       // }
    }
    
    @AuraEnabled
    public static UCDA_GetAllMethodsParser getAllMethods(string jsonString)
    {
        system.debug('jsonString:::'+jsonString);
        UCDA_GetAllMethodsParser allMethods = UCD_ToolingAPIServiceLighting.getAllMethods(JSONString);
        return allMethods;
    }
    
   // @future
    @AuraEnabled
    public static void createApexClassMembers(string jsonString)
    {
        UCD_ToolingAPIServiceLighting.createApexClassMember(jsonString);
        
    }
    
    //@future
    @AuraEnabled
    public static void createApexTriggerMembers(string jsonString)
    {
        UCD_ToolingAPIServiceLighting.createApexTriggerMember(jsonString);
    }
    
    
    @AuraEnabled
    public static string createContainerAsyncRequest(string containerId)
    {
        string bodyContainer = '{\"MetadataContainerId\": \"'+containerId+'\",\"IsCheckOnly\": \"false\"}';
        
        UCDA_ParserContainerAsyncRequestCtrl asyncRequest = UCD_ToolingAPIServiceLighting.createContainerAsyncRequest(bodyContainer);
        return asyncRequest.id;
     
    }
    
    @AuraEnabled
    public static string createContainerAsyncRequestStatus(string asyncRequestId){
        
        string requestStatus = UCD_ToolingAPIServiceLighting.getStatusofContainerAsyncRequest(asyncRequestId);
        return requestStatus;
    }
    
    @AuraEnabled
    public static UCDA_AllApexClassesParserCtrl getTriggerMethods(string container)
    {
        UCDA_AllApexClassesParserCtrl allApexTriggers = UCD_ToolingAPIServiceLighting.getAllApexTriggers();
        return allApexTriggers;
    }
    
    @AuraEnabled
    public static UCDA_SymbolTableParserCtrl getSymbolTable(string asyncRequestId)
    {
        UCDA_SymbolTableParserCtrl allMethodsRef = UCD_ToolingAPIServiceLighting.getAllSymbolTable(asyncRequestId);
        return allMethodsRef;
    }
     
    @AuraEnabled
    public static UCDA_SymbolTableParserCtrl getTriggerSymbolTable(string asyncRequestId)
    {
        UCDA_SymbolTableParserCtrl allMethodsTrigRef = UCD_ToolingAPIServiceLighting.getAllTriggerSymbolTable(asyncRequestId);
        return allMethodsTrigRef;
    }
     
   // @future 
    @AuraEnabled
    public static boolean sendMailMethod(String mMail ,String mSubject ,String mbody, string listAllMethods)
    {
       system.debug('listAllMethods::::'+listAllMethods);

       // Blob blobAllMethods = Blob.valueOf(listAllMethods);
      boolean isSuccess = UCD_ToolingAPIServiceLighting.sendMailMethod(mMail, mSubject, mbody,listAllMethods);
        return isSuccess;
    }

}
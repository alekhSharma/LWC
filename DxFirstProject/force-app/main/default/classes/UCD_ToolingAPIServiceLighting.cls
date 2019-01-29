public class UCD_ToolingAPIServiceLighting {
    
    @AuraEnabled public static string userSessionId {get; set;}
    
    public UCD_ToolingAPIServiceLighting()
    {
        
    }
    
    
    public static void getSessionId()
    {
        String sessionId = '';
        PageReference reportPage = Page.UCD_GetSessionIdPage;
        String vfContent = reportPage.getContent().toString();
        System.debug('vfContent:: '+vfContent);
        // Find the position of Start_Of_Session_Id and End_Of_Session_Id
        Integer startP = vfContent.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
            endP = vfContent.indexOf('End_Of_Session_Id');
        // Get the Session Id
        sessionId = vfContent.substring(startP, endP);
        System.debug('sessionId:: '+sessionId);
        userSessionId = sessionId;
    }
    
    @AuraEnabled
    public static UCDA_AllApexClassesParserCtrl getAllApexClasses()
    {
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
        }
        
        try
        {
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
            req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
            req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ System.Label.SetEndUrlApxClsMngnablState +'\''+'unmanaged'+'\''+ System.Label.ClassNotLikeUCDA); //+ System.Label.ClassNotLikeUCDA
            
            req.setMethod(System.label.HttpMethodGet);
            System.debug('req:::'+req);
            HttpResponse res = h.send(req);
            System.debug('apexClass::'+ res.getBody());
            UCDA_AllApexClassesParserCtrl allApexClasses = (UCDA_AllApexClassesParserCtrl)JSON.deserialize(res.getBody(), UCDA_AllApexClassesParserCtrl.class);
            System.debug('allapexClass::::'+allApexClasses+':::'+allApexClasses);
            return allApexClasses; 
        }
        catch(Exception ex)
        {
            System.debug('ex::'+ex.getMessage());
            throw ex;
        }
    }
    
    @AuraEnabled  
    public static UCDA_GetMetaDataContainerInfoCtrl getContainerInfo()
    {
        try
        {
            if(string.isBlank(userSessionId) && !Test.isRunningTest())
            {
                getSessionId();
                System.debug('userSessionId::'+userSessionId);
            }
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
            req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
            //   req.setEndpoint(baseUrl+'/services/data/v41.0/tooling/query?q=+select+id,+name+from+metadatacontainer+where+name+='+'\''+'Container2'+'\'');
            req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v41.0/tooling/query?q=+select+id,+name+from+metadatacontainer+where+name+='+'\''+'Container2'+'\'');
            req.setMethod(System.label.HttpMethodGet);
            System.debug('req:::'+req);
            HttpResponse res = h.send(req);
            System.debug('apexClass::ress'+ res.getBody());
            
            UCDA_GetMetaDataContainerInfoCtrl isContainerExist = (UCDA_GetMetaDataContainerInfoCtrl)JSON.deserialize(res.getBody(), UCDA_GetMetaDataContainerInfoCtrl.class);
            System.debug('isContainerExist++++'+isContainerExist );
            return isContainerExist;
        }
        catch(Exception ex)
        {
            System.debug('ex::'+ex.getMessage());
            throw ex;
            //return null;
        }
    }
    
    @AuraEnabled
    public static void deleteContainer(string containerId)
    {
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ System.Label.SetEndUrlMetaDTContnrFwdSlsh +containerId);
        req.setMethod(System.label.HttpMethodDelete);
        if(!Test.isRunningTest()){
            HttpResponse res = h.send(req);
        }
        // System.debug('res.getBody()delete::'+ res.getBody());
    }
    
    
    public static UCDA_MetaDataContainerParserCtrl createContainer(string JSONString)
    {
        System.debug('userSessionId::'+userSessionId);
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ System.Label.SetEndpointUrlMetaDTCon);
        req.setMethod(System.Label.HttpMethodPost);
        req.setBody(JSONString);
        HttpResponse res;
        string jsonBody ;
        
        if(!Test.isRunningTest())
        {
            res = h.send(req);  
            jsonBody = res.getBody();
        }
        else
        {
            //res.setBody('{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "MetadataContainer","records" : [ {"attributes" : {"type" : "MetadataContainer","url" : "/services/data/v41.0/tooling/sobjects/MetadataContainer/1dc7F00000AFdOqQAL"},"Id" : "1dc7F00000AFdOqQAL","Name" : "1de7F00000CNkEFQA1"} ]}');
            jsonBody = '{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "MetadataContainer","records" : [ {"attributes" : {"type" : "MetadataContainer","url" : "/services/data/v41.0/tooling/sobjects/MetadataContainer/1dc7F00000AFdOqQAL"},"Id" : "1dc7F00000AFdOqQAL","Name" : "1de7F00000CNkEFQA1"} ]}';
        }
        //System.debug('res.getBody()::'+ res.getBody());
        
        UCDA_MetaDataContainerParserCtrl container = (UCDA_MetaDataContainerParserCtrl)JSON.deserialize(jsonBody, UCDA_MetaDataContainerParserCtrl.class);
        
        return container;
    }
    
    public static UCDA_GetAllMethodsParser getAllMethods(string JSONString)
    {
        System.debug('JSONString::'+JSONString);
        
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ System.Label.SetEndpointBsUrl);
        req.setMethod(System.Label.HttpMethodGet);
        req.setBody('{"allOrNone":false, "compositeRequest":'+JSONString+'}');
        HttpResponse res;
        string jsonBody;
        if(!Test.isRunningTest())
        {
            res = h.send(req);
            jsonBody = res.getBody();
        }
        else
        {
            jsonBody =  '{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "ApexClassMember","records" : [ {"attributes" : {"type" : "ApexClassMember","url" : "/services/data/v41.0/tooling/sobjects/ApexClassMember/4007F000002MtIqQAK"},"Id" : "4007F000002MtIqQAK"}]}';
        }
        UCDA_GetAllMethodsParser allMethods = (UCDA_GetAllMethodsParser)JSON.deserialize(jsonBody, UCDA_GetAllMethodsParser.class);
        return allMethods;
    }
    
    public static UCDA_ApexClassMemberParserCtrl createApexClassMember(string JSONString)
    {
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ System.Label.SetEndpointBsUrl);
        req.setMethod(System.label.HttpMethodGet);
        req.setBody('{"allOrNone":false, "compositeRequest":'+JSONString+'}');
        System.debug('JSONString1::'+JSONString);
        HttpResponse res;
        string jsonBody;
        if(!Test.isRunningTest())
        {
            res = h.send(req);
            jsonBody = res.getBody();
        }
        else
        {
            jsonBody =  '{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "ApexClassMember","records" : [ {"attributes" : {"type" : "ApexClassMember","url" : "/services/data/v41.0/tooling/sobjects/ApexClassMember/4007F000002MtIqQAK"},"Id" : "4007F000002MtIqQAK"}]}';
        }
        UCDA_ApexClassMemberParserCtrl apexClassMember = (UCDA_ApexClassMemberParserCtrl)JSON.deserialize(jsonBody, UCDA_ApexClassMemberParserCtrl.class);
        System.debug('apexClassMember::'+apexClassMember);
        return apexClassMember;
    }
    
    public static UCDA_ParserContainerAsyncRequestCtrl createContainerAsyncRequest(string JSONString)
    {
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + System.Label.SetEndUrlAsyncRequest);
        req.setMethod(System.Label.HttpMethodPost);
        req.setBody(JSONString);
        HttpResponse res;
        string jsonBody;
        if(!Test.isRunningTest())
        {
            res = h.send(req);
            jsonBody = res.getBody();
        }
        else
        {
            jsonBody =  '{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "ApexClassMember","records" : [ {"attributes" : {"type" : "ApexClassMember","url" : "/services/data/v41.0/tooling/sobjects/ApexClassMember/4007F000002MtIqQAK"},"Id" : "4007F000002MtIqQAK"}]}';
        }
        // System.debug('res.getBody()Async::'+ res.getBody());
        
        UCDA_ParserContainerAsyncRequestCtrl asyncRequest = (UCDA_ParserContainerAsyncRequestCtrl)JSON.deserialize(jsonBody, UCDA_ParserContainerAsyncRequestCtrl.class);
        return asyncRequest;
    }
    
    public static String getStatusofContainerAsyncRequest(String asyncRequestId)
    {
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ System.Label.SetEndUrlAsyncRequestFwdSlash +asyncRequestId);
        req.setMethod(System.label.HttpMethodGet);
        HttpResponse res;
        string jsonBody;
        if(!Test.isRunningTest())
        {
            res = h.send(req);
            jsonBody = res.getBody();
        }
        else
        {
            jsonBody =  '{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "ApexClassMember","records" : [ {"attributes" : {"type" : "ApexClassMember","url" : "/services/data/v41.0/tooling/sobjects/ApexClassMember/4007F000002MtIqQAK"},"Id" : "4007F000002MtIqQAK"}]}';
        }
        System.debug('asyncRequestjsonBody :: '+jsonBody);
        UCDA_ContainerAsyncRequestDTO.ContainerAsyncRequest asyncRequest;
        try
        {
            asyncRequest = (UCDA_ContainerAsyncRequestDTO.ContainerAsyncRequest)JSON.deserialize(jsonBody, UCDA_ContainerAsyncRequestDTO.ContainerAsyncRequest.class);
            return jsonBody;
        }
        catch(Exception ex)
        {
            string error = ex.getMessage();
            if(error.contains('unsupported in JSON'))
            {
                // UCD_ErrorAsyncRequestParser errorAsyncRequest = (UCD_ErrorAsyncRequestParser)JSON.deserialize(jsonBody, UCD_ErrorAsyncRequestParser.class);
                // System.debug('errorAsyncRequest::'+errorAsyncRequest);
                return jsonBody;
            }
            else
                return '';
        }
        
    }
    
    public static UCDA_AllApexClassesParserCtrl getAllApexTriggers()
    {
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/tooling/query?q=Select+Id,+Body,+IsValid+from+ApexTrigger+where+manageablestate+='+'\''+'unmanaged'+'\'');
        req.setMethod(System.label.HttpMethodGet);
        HttpResponse res;
        string jsonBody;
        if(!Test.isRunningTest())
        {
            res = h.send(req);
            jsonBody = res.getBody();
        }
        else
        {
            jsonBody =  '{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "ApexClassMember","records" : [ {"attributes" : {"type" : "ApexClassMember","url" : "/services/data/v41.0/tooling/sobjects/ApexClassMember/4007F000002MtIqQAK"},"Id" : "4007F000002MtIqQAK"}]}';
        }
        UCDA_AllApexClassesParserCtrl allApexTriggers = (UCDA_AllApexClassesParserCtrl)JSON.deserialize(jsonBody, UCDA_AllApexClassesParserCtrl.class);
        return allApexTriggers;
    }
    
    public static UCDA_ApexClassMemberParserCtrl createApexTriggerMember(string JSONString)
    {
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ System.Label.SetEndpointBsUrl);
        req.setMethod(System.label.HttpMethodGet);
        req.setBody('{"allOrNone":false, "compositeRequest":'+JSONString+'}');
        System.debug('JSONString1::'+JSONString);
        HttpResponse res;
        string jsonBody;
        if(!Test.isRunningTest())
        {
            res = h.send(req);
            jsonBody = res.getBody();
        }
        else
        {
            jsonBody =  '{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "ApexClassMember","records" : [ {"attributes" : {"type" : "ApexClassMember","url" : "/services/data/v41.0/tooling/sobjects/ApexClassMember/4007F000002MtIqQAK"},"Id" : "4007F000002MtIqQAK"}]}';
        }
        UCDA_ApexClassMemberParserCtrl apexClassMember = (UCDA_ApexClassMemberParserCtrl)JSON.deserialize(jsonBody, UCDA_ApexClassMemberParserCtrl.class);
        System.debug('apexTriggerMember::'+apexClassMember);
        return apexClassMember;
    }
    
    
    public static UCDA_SymbolTableParserCtrl getAllSymbolTable(string asyncRequestId)
    {
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ System.Label.SetEndUrlApxClsMeteDTContnrID +'\''+asyncRequestId+'\'');
        req.setMethod(System.label.HttpMethodGet);
        HttpResponse res;
        string jsonBody;
        if(!Test.isRunningTest())
        {
            res = h.send(req);
            jsonBody = res.getBody();
        }
        else
        {
            jsonBody =  '{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "ApexClassMember","records" : [ {"attributes" : {"type" : "ApexClassMember","url" : "/services/data/v41.0/tooling/sobjects/ApexClassMember/4007F000002MtIqQAK"},"Id" : "4007F000002MtIqQAK"}]}';
        }
        UCDA_SymbolTableParserCtrl allMethodsRef = (UCDA_SymbolTableParserCtrl)JSON.deserialize(jsonBody, UCDA_SymbolTableParserCtrl.class);
        System.debug('allMethodsRef::::'+allMethodsRef);
        return allMethodsRef;
    }
    
    public static UCDA_SymbolTableParserCtrl getAllTriggerSymbolTable(string asyncRequestId)
    {
        if(string.isBlank(userSessionId) && !Test.isRunningTest())
        {
            getSessionId();
            System.debug('userSessionId::'+userSessionId);
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader(System.Label.SetHeaderAuth, System.Label.SetHeaderBearer +' '+ userSessionId);
        req.setHeader(System.Label.SetHeaderVal1, System.Label.SetHeaderVal2);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ System.Label.SetEndUrlApxTrigrMem +'\''+asyncRequestId+'\'');
        req.setMethod(System.label.HttpMethodGet);
        HttpResponse res;
        string jsonBody;
        if(!Test.isRunningTest())
        {
            res = h.send(req);
            jsonBody = res.getBody();
        }
        else
        {
            jsonBody =  '{"size" : 1,"totalSize" : 1,"done" : true,"queryLocator" : null,"entityTypeName" : "ApexClassMember","records" : [ {"attributes" : {"type" : "ApexClassMember","url" : "/services/data/v41.0/tooling/sobjects/ApexClassMember/4007F000002MtIqQAK"},"Id" : "4007F000002MtIqQAK"}]}';
        }
        UCDA_SymbolTableParserCtrl allMethodsRef = (UCDA_SymbolTableParserCtrl)JSON.deserialize(jsonBody, UCDA_SymbolTableParserCtrl.class);
        System.debug('allMethodsRef::::'+allMethodsRef);
        return allMethodsRef;
    }
    
    @AuraEnabled 
    public static boolean sendMailMethod(String mMail ,String mSubject ,String mbody, string listAllMethods){
        // mMail = 'anujkumar.sharma@cognizant.com';
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();     
        List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
        // Step 1: Create a new Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Step 2: Set list of people who should get the email
        List<String> sendTo = new List<String>();
        sendTo.add(mMail);
        mail.setToAddresses(sendTo);
        mail.setPlainTextBody( mbody );
        // Step 3: Set who the email is sent from
        mail.setReplyTo('noreply@gmail.com'); // change it with your mail address.
        mail.setSenderDisplayName('salesforce User'); 
        
        Blob b =  blob.valueOf(listAllMethods);
        // Create the email attachment
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('attachment.csv');
        efa.setBody(b); 
        attachments.add(efa);
        mail.setFileAttachments(attachments);
        // Step 4. Set email contents - you can use variables!
        mail.setSubject(mSubject);
        mail.setHtmlBody(mbody);
        // Step 5. Add your email to the master list
        mails.add(mail);
        
        // Step 6: Send all emails in the master list
        //Messaging.sendEmail(mails);
        Messaging.SendEmailResult [] res = Messaging.sendEmail(mails);
        Boolean isSuccess;
        for(Messaging.SendEmailResult rr:res){
            isSuccess = rr.isSuccess();
            //System.debug('Email result ' + rr.IsSuccess());
        } 
        System.debug('isSuccess::'+isSuccess);
        return isSuccess;
        
    } 
    
    
}//END Class
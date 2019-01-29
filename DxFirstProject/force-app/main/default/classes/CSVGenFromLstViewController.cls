public class CSVGenFromLstViewController{
	public string strFilename{get;set;}
    public string strObjType{get;set;}
    public String strBaseURL{get;set;}
    private string strListViewId;
    @AuraEnabled
 	public static List <listView> getListViewLst(string objName){
        return [select id,name from ListView where sObjectType=:objName];
    }    
    public CSVGenFromLstViewController(){
        strObjType=objectNamefromPrefix(ApexPages.currentPage().getParameters().get('objName'));
        strFilename=strObjType+'.csv';
        strBaseURL=ApexPages.currentPage().getHeaders().get('referer')+'one/one.app#/sObject/'+strObjType+'/list?filterName=Recent';        
    }
    public static String objectNamefromPrefix(String recordIdOrPrefix){
        String objectName = '';
        try{
            //This assumes that you have passed at least 3 characters
            String myIdPrefix = String.valueOf(recordIdOrPrefix).substring(0,3);
            //Get schema information
            Map<String, Schema.SObjectType> gd =  Schema.getGlobalDescribe();
            //Loop through all the sObject types returned by Schema
            for(Schema.SObjectType stype : gd.values()){
                Schema.DescribeSObjectResult r = stype.getDescribe();string prefix = r.getKeyPrefix();
                //Check if the prefix matches with requested prefix
                if(prefix!=null && prefix.equals(myIdPrefix)){objectName = r.getName();break;
                }
            }
        }catch(Exception e){System.debug(e);}return objectName;
    }
    public class relatedDataWrapper{
        @AuraEnabled public list<String> headerList;@AuraEnabled public list<String> recordList;
    }  
    @AuraEnabled
 	public static relatedDataWrapper getCSVData(string sobjType,String listViewId){
        try{
        String strSessionId=UserInfo.getOrganizationId()+''+userinfo.getSessionId().substring(15,userinfo.getSessionId().length()); 
        relatedDataWrapper relteddDataWrap=new relatedDataWrapper(); 
            HttpRequest req = new HttpRequest();
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/sobjects/'+sobjType+'/listviews/'+listViewId+'/results');
        req.setMethod('GET');
            String authorizationHeader = 'OAuth ' +strSessionId;  
            req.setHeader('Authorization', authorizationHeader);
        Http http = new Http();HTTPResponse res = http.send(req); 
            list<String> headerList=New list<String>();list<String> RecordList=New list<String>();
        Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        List<Object> items = (List<Object>)root.get('columns');
        for (Object item : items) 
        { 
            Map<String, Object> i = (Map<String, Object>)item;
            headerList.add((String)i.get('fieldNameOrPath'));
        } 
            List<Object> records = (List<Object>)root.get('records');
        for(Object item : records)
        {  
            Map<String, Object> i = (Map<String, Object>)item;
            string strRecord='';
            for(object objRec:(list<object>)i.get('columns'))
            { 
                Map<String, Object> j = (Map<String, Object>)objRec;                
                strRecord+=(j.get('value')==null?'':(string)j.get('value'))+',';                              
            }
            strRecord = strRecord.removeEnd(',');
            RecordList.add(strRecord);
        	}
            relteddDataWrap.headerList=headerList;
            relteddDataWrap.RecordList=RecordList; 
            return relteddDataWrap;
        }
        catch(Exception e)
        {
            System.debug(e);
        }
        return null;
    }
}
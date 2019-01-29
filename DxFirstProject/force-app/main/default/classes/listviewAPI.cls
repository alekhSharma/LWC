public with sharing class listviewAPI {
    
    public class relatedDataWrapper{
        @AuraEnabled public list<String> headerList;
        @AuraEnabled public list<String> recordList;
    }  
    
    @invocableMethod
    public static list<list<String>> fetchListviewRecords(list<list<string>> names) {  
        
        try{
            String strSessionId=UserInfo.getOrganizationId()+''+userinfo.getSessionId().substring(15,userinfo.getSessionId().length()); 
            String authorizationHeader = 'OAuth ' +strSessionId;
            
            //Creating the Httprequest
            HttpRequest req = new HttpRequest();
            
            // Using the GET method for the request with endpoint
            req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/sobjects/'+names[0][0]+'/listviews/'+names[0][1]+'/results');
            req.setMethod('GET');
            req.setHeader('Authorization', authorizationHeader);
            
            // Using http class to send the request
            Http http = new Http();
            
            // Storing the response in the res variable
            HTTPResponse res = http.send(req); 
            system.debug(res.getBody());
            
            // Converting the JSON into the Primitive Data type
            Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            List<Object> items = (List<Object>)root.get('columns');
            list<String> headerList=New list<String>();
            
            // Iteration of the fieldName
            for (Object item : items) { 
                Map<String, Object> i = (Map<String, Object>)item;
                headerList.add((String)i.get('fieldNameOrPath'));
            } 
            
            List<String> RecordList=New list<String>();
            List<Object> records = (List<Object>)root.get('records');
            for(Object item : records){  
                Map<String, Object> i = (Map<String, Object>)item;
                string strRecord='';
                for(object objRec:(list<object>)i.get('columns')){ 
                    Map<String, Object> j = (Map<String, Object>)objRec;                
                    strRecord+=(j.get('value')==null?'':(string)j.get('value'))+',';      
                }
                strRecord = strRecord.removeEnd(',');            
                RecordList.add(strRecord);
            }
            
            // Classify the header and Data for the Excel table
            relatedDataWrapper relteddDataWrap=new relatedDataWrapper(); 
            relteddDataWrap.headerList=headerList;
            relteddDataWrap.RecordList=RecordList; 
            
            String csvStringResult, counter, columnDivider, lineDivider; 
            list<string> keys=new list<string>();
            list<list<string>> data = new list<list<string>>();
            list<string> datastring = new list<string>();
            columnDivider = ',';
            
            keys = relteddDataWrap.headerList;
            csvStringResult = String.join(keys,',');
            
            datastring.add(csvStringResult);
            
            csvStringResult='';
            keys = relteddDataWrap.RecordList;
            keys = relteddDataWrap.RecordList;
            csvStringResult = String.join(keys,'\n');
            datastring.add(csvStringResult);
            data.add(datastring);
            return data;
        }
        catch(Exception e) {
            System.debug(e);
        }
        return null;
    }
}
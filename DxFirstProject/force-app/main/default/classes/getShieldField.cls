/*
 * 
 ------------------------------------
@Author: Alekh Sharma
 ------------------------------------                             
*/



public with sharing class getShieldField {
    // Test data
    // [select id from account];
    // [select id from account where lastname =: lastName];
    // [select id from contact where lastname = 'alekh'];
    // [select id from account group by lastname];
    // [select id from lead where lastName = 'lead' group by leadName];
    // [select id from opportunity where LastNaME = 'lead test' order by lastnamE];
    // [select id from bank where lastNAME = 'test lead' order by status group by LaSTname];
    // [select id from lead where lastNAME = 'test lead' order by lastName group by LaSTname];
    // [select id from opportunity where LastNaME = 'lead test' order by status];
    // [SELECT CampaignId, AVG(LaSTname) FROM Opportunity GROUP BY CampaignId];
    // [SELECT COUNT(LaSTname) FROM Account WHERE Name LIKE 'a%'];
    // [SELECT COUNT_DISTINCT(LaSTname) FROM Lead];
    // [SELECT MIN(LaSTname), FirstName, LastName FROM Contact GROUP BY FirstName, LastName];
    // [SELECT MAX(LaSTname), FirstName, LastName FROM lead GROUP BY FirstName, LastName];
    // SELECT SUM(LaSTname) FROM Opportunity WHERE IsClosed = false AND Probability > 60

    Public List<ApexClass> ApexList{get;set;}
    Public List<ApexTrigger> TriggerList{get;set;}
    Public List<String> ApexBody{get;set;}
    Public List<String> TriggerBody{get;set;}
    
    public list<string> whereFinder(String ObjectName, String FieldName){
        list<string> result ;
        ApexList = New List<ApexClass>();
        TriggerList = New List<ApexTrigger>();
        String string_complete='',string_from='',string_sql='';
        List<String> list_of_string; 
        
        String searchStr1  = '{where '+FieldName+' = }';
        String searchQuery = 'FIND \'' + searchStr1 + '\' IN ALL FIELDS RETURNING ApexClass(name,body), ApexTrigger(name,body)';
        
        List<List <sObject>> searchList = search.query(searchQuery);
        ApexList    = ((List<ApexClass>)searchList[0]);
        TriggerList = ((List<ApexTrigger>)searchList[1]);
        ApexBody = New List<String>();
        TriggerBody = New List<String>();

        for(integer count =0; count<ApexList.size(); count++){
           	ApexBody.add((ApexList[count].body).toLowerCase());
           
            string_complete=ApexBody[count];
            
            while(string_complete!=''){
          		string_sql      = string_complete.substringbetween('[',']');
                string_complete = string_complete.substringAfter('];');

                if(string_sql!=null){
                   list_of_string = string_sql.split(' ');
                   //  to find the index 
                   integer where_index = list_of_string.indexOf('where');
                   integer from_index  = list_of_string.indexOf('from'); 
                   integer order_index = list_of_string.indexOf('order');
                   integer group_index = list_of_string.indexOf('group');
                   integer FieldName_index = list_of_string.indexOf(FieldName);
						
                   if((string_sql.contains(FieldName))&&(where_index!=-1)&&(list_of_string[from_index+1]==ObjectName))
                   {
                           // to find between where 
                           if((group_index==-1)&&(order_index!=-1)){
                               for(integer index = where_index;index<=order_index;index++){
                                   if(list_of_string[index]==FieldName){
                                       system.debug('found '+' '+list_of_string[index]+' in '+string_sql+index+' from '+list_of_string[from_index+1]);  
                                   }
                               }
                           }
                           if((order_index==-1)&&(group_index!=-1)){
                               for(integer index = where_index;index<=group_index;index++){
                                   if(list_of_string[index]==FieldName){
                                       system.debug('found '+' '+list_of_string[index]+' in '+string_sql+index+' from '+list_of_string[from_index+1]);
                                   }
                               }
                           }
                           if((group_index!=-1)&&(order_index!=-1)){
                               integer index_small = order_index<group_index?order_index:group_index;
                                   for(integer index = where_index;index<=index_small;index++){
                                       if(list_of_string[index]==FieldName){
                                           system.debug('found '+' '+list_of_string[index]+' in '+string_sql+index_small+' from '+list_of_string[from_index+1]);
                                       }
                                   }
                           }
                           if((group_index==-1)&&(order_index==-1)){
                               //system.debug(string_from);
                               string_from = string_sql.substringAfter('where');
                               if(string_from.contains(FieldName))
                               		system.debug('found '+' in '+string_sql+' from '+list_of_string[from_index+1]);
                           }      
                    }
                }
            }
         }
        
         for(integer count =0; count<TriggerList.size(); count++){
           	TriggerBody.add((TriggerList[count].body).toLowerCase());
           
            string_complete=TriggerBody[count];
            
            while(string_complete!=''){
          		string_sql      = string_complete.substringbetween('[',']');
                string_complete = string_complete.substringAfter('];');

                if(string_sql!=null){
                   list_of_string = string_sql.split(' ');
                   //  to find the index 
                   integer where_index = list_of_string.indexOf('where');
                   integer from_index  = list_of_string.indexOf('from'); 
                   integer order_index = list_of_string.indexOf('order');
                   integer group_index = list_of_string.indexOf('group');
                   integer FieldName_index = list_of_string.indexOf(FieldName);
						
                   if((string_sql.contains(FieldName))&&(where_index!=-1)&&(list_of_string[from_index+1]==ObjectName))
                   {

                           // to find between where 
                           if((group_index==-1)&&(order_index!=-1)){
                               for(integer index = where_index;index<=order_index;index++){
                                   if(list_of_string[index]==FieldName){
                                       system.debug('found '+' '+list_of_string[index]+' in '+string_sql+index+' from '+list_of_string[from_index+1]);  
                                   }
                               }
                           }
                           if((order_index==-1)&&(group_index!=-1)){
                               for(integer index = where_index;index<=group_index;index++){
                                   if(list_of_string[index]==FieldName){
                                       system.debug('found '+' '+list_of_string[index]+' in '+string_sql+index+' from '+list_of_string[from_index+1]);
                                   }
                               }
                           }
                           if((group_index!=-1)&&(order_index!=-1)){
                               integer index_small = order_index<group_index?order_index:group_index;
                                   for(integer index = where_index;index<=index_small;index++){
                                       if(list_of_string[index]==FieldName){
                                           system.debug('found '+' '+list_of_string[index]+' in '+string_sql+index_small+' from '+list_of_string[from_index+1]);
                                       }
                                   }
                           }
                           if((group_index==-1)&&(order_index==-1)){
                               //system.debug(string_from);
                               string_from = string_sql.substringAfter('where');
                               if(string_from.contains(FieldName))
                               		system.debug('found '+' in '+string_sql+' from '+list_of_string[from_index+1]);
                           }      
                    }
                }
            }
        }
        return result;
        }    
    
    public list<string> groupByFinder(String ObjectName, String FieldName){
        list<string> result ;
        ApexList = New List<ApexClass>();
        TriggerList = New List<ApexTrigger>();
        String string_complete='',string_from='',string_sql='';
        List<String> list_of_string; 
        
        String searchStr1  = '{group by '+FieldName+' = }';
        String searchQuery = 'FIND \'' + searchStr1 + '\' IN ALL FIELDS RETURNING ApexClass(name,body), ApexTrigger(name,body)';
        
        List<List <sObject>> searchList = search.query(searchQuery);
        ApexList    = ((List<ApexClass>)searchList[0]);
        TriggerList = ((List<ApexTrigger>)searchList[1]);
        ApexBody = New List<String>();
        TriggerBody = New List<String>();

        for(integer count =0; count<ApexList.size(); count++){
           	ApexBody.add((ApexList[count].body).toLowerCase());
            string_complete=ApexBody[count];
            
            while(string_complete!=''){
          		string_sql      = string_complete.substringbetween('[',']');
                string_complete = string_complete.substringAfter('];');
                
                if(string_sql!=null){		
                   list_of_string = string_sql.split(' ');
                   integer from_index  = list_of_string.indexOf('from'); 
                   if((string_sql.contains('group by'+' '+FieldName))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found group by in'+' '+string_sql);	
                   }
                }
            }
         }
        
         for(integer count =0; count<TriggerList.size(); count++){
           	TriggerBody.add((TriggerList[count].body).toLowerCase());
           
            string_complete=TriggerBody[count];
            while(string_complete!=''){
          		string_sql      = string_complete.substringbetween('[',']');
                string_complete = string_complete.substringAfter('];');

                if(string_sql!=null){	
                   list_of_string = string_sql.split(' ');
                   integer from_index  = list_of_string.indexOf('from'); 
                   if((string_sql.contains('group by'+' '+FieldName))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found group by in'+' '+string_sql);	
                   }
                }
            }  
         }
        
        return result;
        }    
    	
    public list<string> orderByFinder(String ObjectName, String FieldName){
        list<string> result ;
        ApexList = New List<ApexClass>();
        TriggerList = New List<ApexTrigger>();
        String string_complete='',string_from='',string_sql='';
        List<String> list_of_string; 
        
        String searchStr1  = '{order by '+FieldName+' = }';
        String searchQuery = 'FIND \'' + searchStr1 + '\' IN ALL FIELDS RETURNING ApexClass(name,body), ApexTrigger(name,body)';
        
        List<List <sObject>> searchList = search.query(searchQuery);
        ApexList    = ((List<ApexClass>)searchList[0]);
        TriggerList = ((List<ApexTrigger>)searchList[1]);
        ApexBody = New List<String>();
        TriggerBody = New List<String>();

        for(integer count =0; count<ApexList.size(); count++){
           	ApexBody.add((ApexList[count].body).toLowerCase());
           
            string_complete=ApexBody[count];
            
            while(string_complete!=''){
          		string_sql      = string_complete.substringbetween('[',']');
                string_complete = string_complete.substringAfter('];');

                if(string_sql!=null){
                list_of_string = string_sql.split(' ');
                integer from_index  = list_of_string.indexOf('from'); 
                   if((string_sql.contains('order by'+' '+FieldName))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found order by in'+' '+string_sql);	
                   }
                }
            }
         }
        
         for(integer count =0; count<TriggerList.size(); count++){
           	TriggerBody.add((TriggerList[count].body).toLowerCase());
           
            string_complete=TriggerBody[count];
            while(string_complete!=''){
          		string_sql      = string_complete.substringbetween('[',']');
                string_complete = string_complete.substringAfter('];');

                if(string_sql!=null){
                   list_of_string = string_sql.split(' ');							
                   integer from_index  = list_of_string.indexOf('from'); 
                   if((string_sql.contains('order by'+' '+FieldName))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found order by in'+' '+string_sql);	
                   }
                }
            }  
         }
        
        return result;
        }    
    
    public list<string> aggregateFunction(String ObjectName, String FieldName){
        list<string> result ;
        ApexList = New List<ApexClass>();
        TriggerList = New List<ApexTrigger>();
        String string_complete='',string_from='',string_sql='';
        List<String> list_of_string; 

        String searchStr1  = '{max ('+FieldName+') }';
        String searchStr2  = '{min ('+FieldName+') }';
        String searchStr3  = '{count ('+FieldName+') }';
        String searchStr4  = '{avg ('+FieldName+') }';
        String searchStr5  = '{count_distinct ('+FieldName+') }';
        String searchQuery = 'FIND \'' + searchStr1 +' OR '+ searchStr2+' OR '+ searchStr3+' OR '+ searchStr4+' OR '+ searchStr5+'\' IN ALL FIELDS RETURNING ApexClass(name,body), ApexTrigger(name,body)';
        
        List<List <sObject>> searchList = search.query(searchQuery);
        ApexList    = ((List<ApexClass>)searchList[0]);
        TriggerList = ((List<ApexTrigger>)searchList[1]);
        ApexBody = New List<String>();
        TriggerBody = New List<String>();

        for(integer count =0; count<ApexList.size(); count++){
           	ApexBody.add((ApexList[count].body).toLowerCase());
            string_complete=ApexBody[count];
            
            while(string_complete!=''){
          		string_sql      = string_complete.substringbetween('[',']');
                string_complete = string_complete.substringAfter('];');

                if(string_sql!=null){
                   list_of_string = string_sql.split(' ');							
                   integer from_index  = list_of_string.indexOf('from'); 
                   if((string_sql.contains('max('+FieldName+')'))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found max in'+' '+string_sql);	
                   }
                }
            }
         }
        
         for(integer count =0; count<TriggerList.size(); count++){
           	TriggerBody.add((TriggerList[count].body).toLowerCase());
            string_complete=TriggerBody[count];
            while(string_complete!=''){
          		string_sql      = string_complete.substringbetween('[',']');
                string_complete = string_complete.substringAfter('];');

                if(string_sql!=null){	
                   list_of_string = string_sql.split(' ');							
                   integer from_index  = list_of_string.indexOf('from'); 
                   if((string_sql.contains('max('+FieldName+')'))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found max in'+' '+string_sql);	
                   }
                    if((string_sql.contains('min('+FieldName+')'))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found max in'+' '+string_sql);	
                   }
                    if((string_sql.contains('avg('+FieldName+')'))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found max in'+' '+string_sql);	
                   }
                    if((string_sql.contains('count('+FieldName+')'))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found max in'+' '+string_sql);	
                   }
                    if((string_sql.contains('count_distinct('+FieldName+')'))&&(list_of_string[from_index+1]==ObjectName))
                   {
      				 system.debug('Found max in'+' '+string_sql);	
                   }  
                }
            }  
         }
        
        return result;
        }    
  
}
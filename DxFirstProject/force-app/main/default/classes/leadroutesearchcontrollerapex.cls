public with sharing class leadroutesearchcontrollerapex {
    
    //method to get list of leads from server
    @AuraEnabled
    public static List<leadwrappercontainer> getleads(){
        list<leadwrappercontainer> leadWrapperList=new list<leadwrappercontainer>();
        for(lead leadObj:[select name,Id,status,Address,latitude,longitude from Lead]){
          leadwrappercontainer leadWrapperObj=new leadwrappercontainer(leadObj);
           leadWrapperList.add(leadWrapperObj); 
        }
        return leadWrapperList;
    }
    
    //method to get API key stored in custom label 'leadroutesearchAPImaps'
    @AuraEnabled
    public static string CustomLabel(){
       string customLabelValue = System.Label.leadroutesearchAPImaps;
        return customLabelValue;
    }
}
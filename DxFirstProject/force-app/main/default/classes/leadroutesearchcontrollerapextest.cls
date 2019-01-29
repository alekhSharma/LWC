@istest
public class leadroutesearchcontrollerapextest {
    
    @TestSetup
    public static void leadfactory(){
        
        List<Lead> listlead=new List<Lead>();
        for(integer i=0;i<40;i++){
          Lead leadObj=new lead();
          leadObj.FirstName='factorylead'+i;  
          leadObj.LastName='Testlead'+i;
          leadObj.Status='Working - Contacted';
          leadObj.Company='Cts'+i;
          leadObj.LeadSource='Web';  
          listlead.add(leadObj);  
        }  
        insert listlead;
    }
    @istest
    public static  void getleadstest(){
        list<leadwrappercontainer> leadWrapperList=new list<leadwrappercontainer>();      
        leadWrapperList=leadroutesearchcontrollerapex.getleads();
        integer n=[select count() from lead];
        system.assertEquals(n, leadWrapperList.size());
    }  
    @istest    
    public static  void CustomLabeltest(){
        string apiKeyLabel= leadroutesearchcontrollerapex.CustomLabel();
        string apiKey=System.Label.leadroutesearchAPImaps; 
        system.assertEquals(apiKey,apiKeyLabel);
    }
}
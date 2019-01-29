@isTest(seeAllData=false)
public class UCD_UnusedMethodProcessLightingTest {
    /* public static testMethod void ucdcProcessTestCntnr(){
//try{
Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
UCDA_UnusedMethodProcessCtrl objUcda = new UCDA_UnusedMethodProcessCtrl();
objUcda.getUnusedCode();
} */
    
    public static testMethod void ucdcProcessTestAllApxCls1(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.createContainer();
    }
    public static testMethod void ucdcProcessTestAllApxCls2(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.getAllApexClasses();
    }
    
    public static testMethod void ucdcProcessTestAllApxCls5(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.createApexClassMembers('{/ApexClass}');
    }
    
    public static testMethod void ucdcProcessTestAllApxCls6(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.createApexTriggerMembers('{/ApexTrigger}');
    }

    
    public static testMethod void ucdcProcessTestAllApxCls3(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.createContainerAsyncRequest('{}');
    }
    
    public static testMethod void ucdcProcessTestAllApxCls4(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.createContainerAsyncRequestStatus('{}');
    }
    
     
    public static testMethod void ucdcProcessTestAllApxCls7(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.getSymbolTable('{}');
    }
    
    public static testMethod void ucdcProcessTestAllApxCls8(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.getTriggerMethods('{}');
    }
    
    public static testMethod void ucdcProcessTestAllApxCls9(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.getTriggerSymbolTable('{}');
    }
    
    public static testMethod void ucdcProcessTestAllApxCls10(){
        Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        UCD_UnusedMethodProcessLighting.getAllMethods('{/ApexClass}'); 
    } 
    
    
    
   // public static testMethod void ucdcProcessTestAllApxCls(){
       // Test.setMock(HttpCalloutMock.class,new UCDA_MockHttpResponseGeneratorAllApxCls());
        // UCD_UnusedMethodProcessLighting.getAllApexClasses();
        //UCD_UnusedMethodProcessLighting.createContainer();
     /*   UCD_UnusedMethodProcessLighting.createContainerAsyncRequest('{}');
        UCD_UnusedMethodProcessLighting.createContainerAsyncRequestStatus('{}');
        UCD_UnusedMethodProcessLighting.createApexClassMembers('{/ApexClass}');
        UCD_UnusedMethodProcessLighting.createApexTriggerMembers('{/ApexTrigger}');
        UCD_UnusedMethodProcessLighting.getSymbolTable('{}');
        UCD_UnusedMethodProcessLighting.getTriggerMethods('{}');
        UCD_UnusedMethodProcessLighting.getTriggerSymbolTable('{}');
        UCD_UnusedMethodProcessLighting.getAllMethods('{/ApexClass}'); */
   // }
    
    
    
}
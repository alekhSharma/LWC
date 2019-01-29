@isTest(seeAllData=false)
public class UCDA_AllApexClassesParserCtrlTest {
    public static testMethod void TestMethod1(){
        
        
        UCDA_AllApexClassesParserCtrl.Attributes a = new UCDA_AllApexClassesParserCtrl.Attributes();
        a.type_Z = '';
        a.url = '';
      
        
        UCDA_AllApexClassesParserCtrl.Records r = new UCDA_AllApexClassesParserCtrl.Records();
        r.attributes = a;
        r.Id = '';
        r.Body = '';
        r.IsValid = true;
        
        
        
        UCDA_AllApexClassesParserCtrl allApexObj = new UCDA_AllApexClassesParserCtrl();
        
        
        //UCDA_AllApexClassesParserCtrl.Records(a,a.id,'',true);
        
        
        allApexObj.size = 0;
        allApexObj.totalSize = 0;
        allApexObj.done = false;
        allApexObj.queryLocator = '';
        allApexObj.entityTypeName = '';
        allApexObj.records = new List<UCDA_AllApexClassesParserCtrl.Records>();
        //allApexObj.records.add(r);
        
    }
}
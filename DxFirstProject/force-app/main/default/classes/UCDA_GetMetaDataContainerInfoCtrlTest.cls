@isTest(seeAllData=false) 
public class UCDA_GetMetaDataContainerInfoCtrlTest {
    public static testMethod void cover(){
    UCDA_GetMetaDataContainerInfoCtrl c = new UCDA_GetMetaDataContainerInfoCtrl();
        
    
    c.size = '10';
    c.totalSize = '33';
    c.done = false;
    c.queryLocator ='fczsf';
    c.entityTypeName = '{get;set;}' ;
    c.records = new List<UCDA_GetMetaDataContainerInfoCtrl.Records>();
    
    UCDA_GetMetaDataContainerInfoCtrl.Attributes a = new UCDA_GetMetaDataContainerInfoCtrl.Attributes();   
    a.type_Z = 'asdas';
    a.url = 'asdas';
   
    UCDA_GetMetaDataContainerInfoCtrl.Records r = new UCDA_GetMetaDataContainerInfoCtrl.Records();   
   
    r.attributes = a;
    r.id = 'asdas';
    r.Name = 'asdas';
        
   
    }
}
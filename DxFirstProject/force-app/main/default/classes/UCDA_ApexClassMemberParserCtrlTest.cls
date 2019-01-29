@isTest(seeAllData=false)
public class UCDA_ApexClassMemberParserCtrlTest {
    public static testMethod void TestMethod1(){
        
        UCDA_ApexClassMemberParserCtrl.Errors error= new UCDA_ApexClassMemberParserCtrl.Errors();
        list<UCDA_ApexClassMemberParserCtrl.Errors> lsterrors = new list<UCDA_ApexClassMemberParserCtrl.Errors>();
        lsterrors.add(error);
        
        UCDA_ApexClassMemberParserCtrl.HttpHeaders httpObj= new UCDA_ApexClassMemberParserCtrl.HttpHeaders();
        httpObj.Location = '';
        
        UCDA_ApexClassMemberParserCtrl.Body BodyObj= new UCDA_ApexClassMemberParserCtrl.Body();
        BodyObj.id = '';
        BodyObj.success = true;
        BodyObj.errors = lsterrors;
        BodyObj.warnings = lsterrors;
        
        UCDA_ApexClassMemberParserCtrl.CompositeResponse CompositeResponseObj= new UCDA_ApexClassMemberParserCtrl.CompositeResponse();
        CompositeResponseObj.body  =  BodyObj;
        CompositeResponseObj.httpHeaders  =  httpObj;
        CompositeResponseObj.httpStatusCode  =  0;
        CompositeResponseObj.referenceId  =  '';
        
        list<UCDA_ApexClassMemberParserCtrl.CompositeResponse> lstcr = new list<UCDA_ApexClassMemberParserCtrl.CompositeResponse>(); 
        lstcr.add(CompositeResponseObj);
        
        UCDA_ApexClassMemberParserCtrl ac = new UCDA_ApexClassMemberParserCtrl();
        ac.compositeResponse = lstcr;
    }
}
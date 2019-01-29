@isTest(seeAllData=false)
public class UCDA_CompositeRequestParserCtrlTest {
    public static testMethod void UCDA_CompositeRequestParserCtrlTest(){
        UCDA_CompositeRequestParserCtrl v = new UCDA_CompositeRequestParserCtrl();
        v.method = 'get';
    	v.url='asdasd';
   	 	v.referenceId='qawdewaqd';
        v.body = new UCDA_wrapperApexMember();
    }
}
@isTest(seeAllData=false)
public class UCDA_SymbolTableParserCtrlTest {
      public static testMethod void UCDA_UnusedMethodProcessCtrlTest()
      {
          UCDA_SymbolTableParserCtrl uc = new UCDA_SymbolTableParserCtrl();
          uc.size=10;
        uc.totalSize=19;
        uc.done=true; 
        uc.queryLocator='teswt'; 
        uc.entityTypeName='qweqw'; 
        uc.records = new   List<UCDA_SymbolTableParserCtrl.Records>();
       
        UCDA_SymbolTableParserCtrl.Attributes attributes =new UCDA_SymbolTableParserCtrl.Attributes();
        attributes.type_Z = 'asdasas';
     	attributes.url = 'asdasas';
         UCDA_SymbolTableParserCtrl.Variables v = new UCDA_SymbolTableParserCtrl.Variables();
          v.location = new UCDA_SymbolTableParserCtrl.Location();
          v.name = 'test';
          v.references = new List<UCDA_SymbolTableParserCtrl.Location>();
          v.type_Z = 'test';
       
          UCDA_SymbolTableParserCtrl.ExternalReferences e = new UCDA_SymbolTableParserCtrl.ExternalReferences();
          e.methods = new List<UCDA_SymbolTableParserCtrl.Methods>();
          e.name ='sdf';
          e.namespace = 'sdf';
          e.references = new List<UCDA_SymbolTableParserCtrl.Location>();
          
          UCDA_SymbolTableParserCtrl.TableDeclaration t = new UCDA_SymbolTableParserCtrl.TableDeclaration();
		  t.annotations = new List<UCDA_SymbolTableParserCtrl.Annotations>();
     	  t.location = new UCDA_SymbolTableParserCtrl.Location(); 
          t.modifiers = new List<String> ();
          t.name = 'qerw';
         //public List<Annotations> references {get;set;} 
          t.type_Z = 'wwww';
          
          
          UCDA_SymbolTableParserCtrl.SymbolTable st = new UCDA_SymbolTableParserCtrl.SymbolTable();
          st.constructors = new List<UCDA_SymbolTableParserCtrl.Constructors>();
          st.externalReferences= new List<UCDA_SymbolTableParserCtrl.ExternalReferences>();
          st.id = 'asdfa';


        st.key = 'asdas';

        st.name = 'asdas';
        st.namespace = 'asdas';
        st.parentClass = 'asdas';

        st.tableDeclaration = new UCDA_SymbolTableParserCtrl.TableDeclaration();
        st.variables = new List<UCDA_SymbolTableParserCtrl.Variables>();
         
          
        UCDA_SymbolTableParserCtrl.Constructors  c = new  UCDA_SymbolTableParserCtrl.Constructors();
        c.annotations = new List<UCDA_SymbolTableParserCtrl.Annotations>();
        c.location = new UCDA_SymbolTableParserCtrl.Location();
        c.modifiers = new List<String>();
        c.name= 'ads'; 
        //public List<Annotations> parameters {get;set;} 
        //public List<Annotations> references {get;set;} 
       c.type_Z = 'asda';
   
		UCDA_SymbolTableParserCtrl.Records re =  new UCDA_SymbolTableParserCtrl.Records();
   
        re.attributes = new UCDA_SymbolTableParserCtrl.Attributes();
        re.Id = 'ads';
        re.SymbolTable = new UCDA_SymbolTableParserCtrl.SymbolTable();
 
    
  		UCDA_SymbolTableParserCtrl.Methods me = new UCDA_SymbolTableParserCtrl.Methods();
        me.argTypes = new List<UCDA_SymbolTableParserCtrl.Annotations>();
        me.isStatic = true;
        me.methodDoc= 'fsaf';
        me.name = 'fsadf';
        me.parameters = new List<UCDA_SymbolTableParserCtrl.Parameters>();
        me.references = new List<UCDA_SymbolTableParserCtrl.Location>();
        me.returnType = 'asf'; 


      UCDA_SymbolTableParserCtrl.Parameters  p = new UCDA_SymbolTableParserCtrl.Parameters();
      p.name = 'asd';
      p.type_Z = ' {get;set;}';
   
    
       UCDA_SymbolTableParserCtrl.Location lo = new UCDA_SymbolTableParserCtrl.Location();
       lo.column= 12; 
       lo.line = 1; 

     
      }
}
@isTest(seeAllData=false)
public class UCDA_GetAllMethodsParserTest {
    public static testMethod void TestMethod1(){
        
        UCDA_GetAllMethodsParser gam = new UCDA_GetAllMethodsParser();
        
        
        UCDA_GetAllMethodsParser.HttpHeaders httpObj = new UCDA_GetAllMethodsParser.HttpHeaders();
        httpObj.Last_Modified = '';
        
        
        
        UCDA_GetAllMethodsParser.Parameters ParametersObj = new UCDA_GetAllMethodsParser.Parameters();
        ParametersObj.name = '';
        ParametersObj.type_Z = '';
        
        list<UCDA_GetAllMethodsParser.Parameters> lstParameters = new  list<UCDA_GetAllMethodsParser.Parameters>();
        lstParameters.add(ParametersObj);
        
        
        UCDA_GetAllMethodsParser.Attributes AttributesObj = new UCDA_GetAllMethodsParser.Attributes();
        AttributesObj.type_Z = '';
        AttributesObj.url = '';
        
        
        list<string> lstString = new list<string>();
        
        UCDA_GetAllMethodsParser.Location LocationsObj = new UCDA_GetAllMethodsParser.Location();
        LocationsObj.column = 1;
        LocationsObj.line = 1;
        
        
        UCDA_GetAllMethodsParser.Constructors ConstructorsObj = new UCDA_GetAllMethodsParser.Constructors();
        ConstructorsObj.location = LocationsObj;
        ConstructorsObj.modifiers = lstString;
        ConstructorsObj.name = '';
        ConstructorsObj.type_Z = '';
        
        list<UCDA_GetAllMethodsParser.Constructors> lstConstructor = new list<UCDA_GetAllMethodsParser.Constructors>();
        lstConstructor.add(ConstructorsObj);
        
        UCDA_GetAllMethodsParser.Methods MethodsObj = new UCDA_GetAllMethodsParser.Methods();
        MethodsObj.location = LocationsObj;
        MethodsObj.modifiers = lstString;
        MethodsObj.name = '';
        MethodsObj.parameters = lstParameters;
        MethodsObj.returnType = '';
        MethodsObj.type_Z = '';
        
        list<UCDA_GetAllMethodsParser.Methods> lstMethods = new list<UCDA_GetAllMethodsParser.Methods>();
        
        lstMethods.add(MethodsObj);
        
        UCDA_GetAllMethodsParser.Properties PropertiesObj = new UCDA_GetAllMethodsParser.Properties();
        PropertiesObj.location = LocationsObj;
        PropertiesObj.modifiers = lstString;
        PropertiesObj.name = '';
        PropertiesObj.type_Z = '';
        
        list<UCDA_GetAllMethodsParser.Properties> lstProperties = new list<UCDA_GetAllMethodsParser.Properties>();
        
        lstProperties.add(PropertiesObj);
        
        
        
        UCDA_GetAllMethodsParser.TableDeclaration TableDeclarationObj = new UCDA_GetAllMethodsParser.TableDeclaration();
        TableDeclarationObj.location = LocationsObj;
        TableDeclarationObj.name = '';
        TableDeclarationObj.type_Z = '';
        
        list<UCDA_GetAllMethodsParser.TableDeclaration> lstTableDeclaration = new list<UCDA_GetAllMethodsParser.TableDeclaration>();
        lstTableDeclaration.add(TableDeclarationObj);
        
        UCDA_GetAllMethodsParser.InnerClasses InnerClassesObj = new UCDA_GetAllMethodsParser.InnerClasses();
        InnerClassesObj.constructors = lstConstructor;
        InnerClassesObj.id = '';
        InnerClassesObj.methods = lstMethods;
        InnerClassesObj.name = '';
        InnerClassesObj.namespace = '';
        InnerClassesObj.parentClass = '';
        InnerClassesObj.properties = lstProperties;
        InnerClassesObj.tableDeclaration = TableDeclarationObj;
        InnerClassesObj.variables = lstTableDeclaration;
        
        list<UCDA_GetAllMethodsParser.InnerClasses> lstInnerClasses = new list<UCDA_GetAllMethodsParser.InnerClasses>();
        lstInnerClasses.add(InnerClassesObj);
        
        UCDA_GetAllMethodsParser.SymbolTable SymbolTableObj = new UCDA_GetAllMethodsParser.SymbolTable();
        SymbolTableObj.constructors = lstConstructor;
        SymbolTableObj.id = '';
        SymbolTableObj.innerClasses = lstInnerClasses;
        SymbolTableObj.methods = lstMethods;
        SymbolTableObj.name = '';
        SymbolTableObj.namespace = '';
        SymbolTableObj.parentClass = '';
        SymbolTableObj.properties = lstProperties;
        SymbolTableObj.tableDeclaration = PropertiesObj;
        SymbolTableObj.variables = lstTableDeclaration;
        
        UCDA_GetAllMethodsParser.Metadata MetadataObj = new UCDA_GetAllMethodsParser.Metadata();
        MetadataObj.module = '';
        MetadataObj.status = '';
        MetadataObj.urls = '';
        
        
        UCDA_GetAllMethodsParser.Body BodyObj = new UCDA_GetAllMethodsParser.Body();
        BodyObj.attributes = AttributesObj;
        BodyObj.Id = '';
        BodyObj.NamespacePrefix = '';
        BodyObj.Name = '';
        BodyObj.ApiVersion = '';
        BodyObj.Status = '';
        BodyObj.IsValid = true;
        BodyObj.BodyCrc = '';
        BodyObj.Body = '';
        BodyObj.LengthWithoutComments = 1;
        BodyObj.CreatedDate = '';
        BodyObj.CreatedById = '';
        BodyObj.LastModifiedDate = '';
        BodyObj.LastModifiedById = '';
        BodyObj.SystemModstamp = '';
        BodyObj.ManageableState = '';
        BodyObj.SymbolTable = SymbolTableObj;
        BodyObj.Metadata = MetadataObj;
        BodyObj.FullName = '';
        
        
        
        
        
        
        UCDA_GetAllMethodsParser.CompositeResponse CompositeResponseObj = new UCDA_GetAllMethodsParser.CompositeResponse();
        CompositeResponseObj.body = BodyObj;
        CompositeResponseObj.httpHeaders = httpObj;
        CompositeResponseObj.httpStatusCode = 0;
        CompositeResponseObj.referenceId = '';
        
        
        
    }
}
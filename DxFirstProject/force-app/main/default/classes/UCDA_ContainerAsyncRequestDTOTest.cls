@isTest(seeAllData=false)
public class UCDA_ContainerAsyncRequestDTOTest {
    public static testMethod void UCDA_ContainerAsyncRequestDTOTest(){
      		UCDA_ContainerAsyncRequestDTO.AllComponentMessages xy = new UCDA_ContainerAsyncRequestDTO.AllComponentMessages();
        	XY.changed = false;
            XY.columnNumber = null;
            XY.componentType = 'aSD';
            XY.created = false;
            XY.createdDate = 'aSD';
            XY.deleted = false;
            XY.fileName = 'aSD';
            XY.forPackageManifestFile =  false;
            XY.fullName =  'aSD';
            XY.id = 'aSD';
            XY.knownPackagingProblem = false;
            XY.lineNumber = null;
            XY.problem = null;
            XY.problemType = null;
            XY.requiresProductionTestRun =  false;
            XY.success = false;
            XY.warning = false;
        
        
        UCDA_ContainerAsyncRequestDTO.ContainerAsyncRequest cr = new UCDA_ContainerAsyncRequestDTO.ContainerAsyncRequest();
        cr.attributes = new UCDA_ContainerAsyncRequestDTO.Attributes();
        cr.Id = 'sdas';
        cr.IsDeleted = true;
        cr.CreatedDate = 'sdas';
        cr.CreatedById = 'sdas';
        cr.LastModifiedDate = 'sdas';
        cr.LastModifiedById = 'sdas';
        cr.SystemModstamp = 'sdas';
        cr.MetadataContainerId = 'sdas';
        cr.MetadataContainerMemberId = null;
        cr.ErrorMsg = null;
        cr.IsRunTests = true;
        cr.State = 'sdfsd';
        cr.IsCheckOnly = true;
        cr.DeployDetails = new UCDA_ContainerAsyncRequestDTO.DeployDetails();
        
        
        UCDA_ContainerAsyncRequestDTO.DeployDetails dd = new UCDA_ContainerAsyncRequestDTO.DeployDetails();
       	dd.allComponentMessages = new List<UCDA_ContainerAsyncRequestDTO.AllComponentMessages>();
        dd.componentFailures = new List<UCDA_ContainerAsyncRequestDTO.ComponentFailures>();
        dd.componentSuccesses = new List<UCDA_ContainerAsyncRequestDTO.AllComponentMessages>();
        dd.runTestResult = null;
      
        UCDA_ContainerAsyncRequestDTO.Attributes aa = new UCDA_ContainerAsyncRequestDTO.Attributes();
        aa.type_Z = 'asd';
        aa.url = 'asdas';
    }
    
}
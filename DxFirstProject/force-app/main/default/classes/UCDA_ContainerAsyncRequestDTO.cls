public class UCDA_ContainerAsyncRequestDTO {
    	public class DeployDetails {
            public List<AllComponentMessages> allComponentMessages {get;set;} 
            public List<ComponentFailures> componentFailures {get;set;} 
            public List<AllComponentMessages> componentSuccesses {get;set;} 
            public Object runTestResult {get;set;} 
        }

	public class AllComponentMessages {
        public AllComponentMessages(){}
		public Boolean changed {get;set;} 
		public Object columnNumber {get;set;} 
		public String componentType {get;set;} 
		public Boolean created {get;set;} 
		public String createdDate {get;set;} 
		public Boolean deleted {get;set;} 
		public String fileName {get;set;} 
		public Boolean forPackageManifestFile {get;set;} 
		public String fullName {get;set;} 
		public String id {get;set;} 
		public Boolean knownPackagingProblem {get;set;} 
		public Object lineNumber {get;set;} 
		public Object problem {get;set;} 
		public Object problemType {get;set;} 
		public Boolean requiresProductionTestRun {get;set;} 
		public Boolean success {get;set;} 
		public Boolean warning {get;set;} 

		
		
	}
	
	public class Attributes {
		public String type_Z {get;set;} // in json: type
		public String url {get;set;} 

			
	}
	
	public class ComponentFailures {

			
	}
	
	public class ContainerAsyncRequest {
		public Attributes attributes {get;set;} 
		public String Id {get;set;} 
		public Boolean IsDeleted {get;set;} 
		public String CreatedDate {get;set;} 
		public String CreatedById {get;set;} 
		public String LastModifiedDate {get;set;} 
		public String LastModifiedById {get;set;} 
		public String SystemModstamp {get;set;} 
		public String MetadataContainerId {get;set;} 
		public Object MetadataContainerMemberId {get;set;} 
		public Object ErrorMsg {get;set;} 
		public Boolean IsRunTests {get;set;} 
		public String State {get;set;} 
		public Boolean IsCheckOnly {get;set;} 
		public DeployDetails DeployDetails {get;set;} 
	
	}
}
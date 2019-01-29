Public class NewCaseListController {
List<Case> results = new List<Case>();

    public List<Case> getNewCases() {
    
    results = [SELECT Id, CaseNumber FROM Case WHERE Status = 'New'];

    return results;
    }
}
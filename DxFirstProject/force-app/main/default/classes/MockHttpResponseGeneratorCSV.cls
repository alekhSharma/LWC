@isTest
global class MockHttpResponseGeneratorCSV implements HttpCalloutMock {
   global HTTPResponse respond(HTTPRequest request) {
        
         HttpResponse response = new HttpResponse();
     
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{\"columns\":[{\"ascendingLabel\":\"Z-A\",\"descendingLabel\":\"A-Z\",\"fieldNameOrPath\":\"Name\",\"hidden\":false,\"label\":\"Account Name\",\"selectListItem\":\"Name\",\"sortDirection\":\"ascending\",\"sortIndex\":0,\"sortable\":true,\"type\":\"string\"},{\"ascendingLabel\":null,\"descendingLabel\":null,\"fieldNameOrPath\":\"OwnerId\",\"hidden\":true,\"label\":\"Owner ID\",\"selectListItem\":\"OwnerId\",\"sortDirection\":null,\"sortIndex\":null,\"sortable\":false,\"type\":\"reference\"}],\"developerName\":\"alekhcognizant__AllAccounts\",\"done\":true,\"id\":\"00B7F000006Xaly\",\"label\":\"All Accounts\",\"records\":[{\"columns\":[{\"fieldNameOrPath\":\"Name\",\"value\":\"Account 1\"},{\"fieldNameOrPath\":\"Id\",\"value\":\"0017F00000LCmsbQAD\"},{\"fieldNameOrPath\":\"CreatedDate\",\"value\":\"Sun Nov 19 06:52:39 GMT 2017\"},{\"fieldNameOrPath\":\"LastModifiedDate\",\"value\":\"Sun Nov 19 06:52:39 GMT 2017\"},{\"fieldNameOrPath\":\"SystemModstamp\",\"value\":\"Wed Feb 07 08:38:50 GMT 2018\"},{\"fieldNameOrPath\":\"Owner.Id\",\"value\":\"0057F000000XavpQAC\"},{\"fieldNameOrPath\":\"OwnerId\",\"value\":\"0057F000000XavpQAC\"}]}],\"size\":1}');
        response.setStatusCode(200);
        return response;
    }
    
}
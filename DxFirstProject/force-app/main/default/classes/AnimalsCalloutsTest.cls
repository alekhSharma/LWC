@isTest
public class AnimalsCalloutsTest {
    @isTest static void testGetCallout(){
        //Create a Mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;chatset=UTF-8');
        
        //associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Call method to test
		HttpResponse result = AnimalsCallouts.MakeGetCallout();
        
        //Verify mock response is not null
        system.assertEquals(null, result, 'The callout is null request');
        
        //Verify status code
		System.assertEquals(200, result.getStatusCode(),'The status code is not 200');
        
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',result.getHeader('Content-Type'),'The content type value is not expected.');  

        // Verify the array contains 3 items     
        Map<String, Object> results = (Map<String, Object>) 

        JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(3, animals.size(),'The array should only contain 3 items.');   
    }
}
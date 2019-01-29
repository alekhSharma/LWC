global class customLookUpController {
    
    //--------------------------------------------- PredictionAddress Webservice Call-----------------------------------------------------------
    @AuraEnabled
    global static string getAddressAutoComplete(String input, String types, String langug) {
        String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' + EncodingUtil.urlEncode(input, 'UTF-8') + '&types=' + types + '&language=' + langug + '&key=' + customLookUpController.getGoogleMapsAPIKey();
        /** 
			Sample data call - Comment line while web service call 
		**/
        return customLookUpController.SampleDataAutoCompleteWebSerive(url);
        /** 
			Sample data call End
		**/
        /** 
			Webserive call - Uncomment line while web service call 
		**/
        //return customLookUpController.getHttp(url);
        /** 
			Webserive call End
		**/
    }
    
    @AuraEnabled
    global static string processWebResp1(String Res) {
        TestWrapper PredictionAddressWrapperList = customLookUpController.parse1(Res);
        system.debug('@@@@@@ PredictionAddressWrapperList ' + PredictionAddressWrapperList);
        return null;
    }
    
    public static TestWrapper parse1(String json) {
        return (TestWrapper) System.JSON.deserialize(json, TestWrapper.class);
    }
    
    //--------------------------------------------- ExactAddress Webservice Call-----------------------------------------------------------
    @AuraEnabled
    global static string getAddressComplete(String PlaceId) {
        String url = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=' + PlaceId + '&language=en&key=' + customLookUpController.getGoogleMapsAPIKey();
       	/** 
			Sample data call - Comment line while web service call 
		**/
        return customLookUpController.SampleDataExactCompleteWebSerive(url);
        /** 
			Sample data call End
		**/
        /** 
			Webserive call - Uncomment line while web service call 
		**/
        //return customLookUpController.getHttp(url); 
         /** 
			Webserive call End
		**/
    }
    
    //--------------------------------------------- Support Methods -----------------------------------------------------------
    global static String getGoogleMapsAPIKey() {
        //return 'AIzaSyBVeee44Wgi0s-XEOOb2TSAAw1ZZ1NzT0s';
        return 'AIzaSyAxi2mRbYaW8wI_srHtpp_mQbHtUEZS91s';
    }
    
    global static string getHttp(String url) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(url);
            request.setMethod('GET');
            request.setTimeout(120000);
            HttpResponse response = http.send(request);
            return response.getBody();
        }
        catch (Exception e) {
            return e.getMessage();
        }     
    }
    
    //Wrapper class
    
    public class TestWrapper{
        public List<PredictionAddressWrapper> predictions;
        public String status;    
        public TestWrapper(List<PredictionAddressWrapper> predictions , String status){
            this.predictions = predictions;
            this.status = status;
        }
    }
    
    public class PredictionAddressWrapper {
        public String description;
        public String place_id;
        public List<String> types;
        public PredictionAddressWrapper(String description,String place_id, List<String> types){
            this.description = description;
            this.place_id = place_id;
            this.types =types;
        }  
    }
    
    @AuraEnabled
    public static List<placeIdDecscriptionWrapper> fetchLookUpValues(String searchKeyWord) {
        String place_id= '';
        String description= '';
        List<placeIdDecscriptionWrapper> placeIdDecscriptionWrapperList = new  List<placeIdDecscriptionWrapper>();
        
        String ReturnStr = customLookUpController.getAddressAutoComplete('Pune','','English');
        Map<String, Object> results1 = (Map<String, Object>)JSON.deserializeUntyped(ReturnStr);
        
        Object resultStatus = (Object)results1.get('status');        
        system.debug('resultStatus'+resultStatus);
        if(resultStatus=='OK'){
            List<Object> results2 = (List<Object>)results1.get('predictions');
            for (Object prediction : results2) {
                Map<String, Object> results3 = (Map<String, Object>)prediction;
                system.debug('results3'+results3);
                {
                    place_id = String.valueOf(results3.get('place_id'));
                }
                {
                    description = String.valueOf(results3.get('description'));
                }
                placeIdDecscriptionWrapperList.add(new placeIdDecscriptionWrapper(place_id,description));
            }
            return placeIdDecscriptionWrapperList;
        }else{
            return null;
        }
    }
    
    @AuraEnabled
    public static AddressWrapper fetchAddress(String place_id) {
        String street = '';
        String city= '';
        String state= '';
        String country= '';
        String postal_code= '';
        
        String jsonAddress = customLookUpController.getAddressComplete(place_id);
        Map<String, Object> results1 = (Map<String, Object>)JSON.deserializeUntyped(jsonAddress);
        Map<String, Object> results2 = (Map<String, Object>)results1.get('result');
        List<Object> address_components = (List<Object>)results2.get('address_components'); 
        for (Object address : address_components) {
            Map<String, Object> results3 = (Map<String, Object>)address;
            List<Object> types = (List<Object>)results3.get('types');
            
            if(types.contains('street_number')){
                street = String.valueOf(results3.get('long_name'));
            }
            if(types.contains('route')){
                street = street + ', ' + String.valueOf(results3.get('long_name'));
            }
            if(types.contains('country')){
                country = String.valueOf(results3.get('long_name'));
            }
            if(types.contains('postal_code')){
                postal_code = String.valueOf(results3.get('long_name'));
            }
        }
        
        AddressWrapper AddressWrapperObj = new AddressWrapper();
        AddressWrapperObj.street = street;
        AddressWrapperObj.city = city;
        AddressWrapperObj.state = state;
        AddressWrapperObj.country = country;
        AddressWrapperObj.postal_code = postal_code; 
        return AddressWrapperObj;
    }
    
    @AuraEnabled
    public static void saveAddressInAccount(String recordId, String street, String city, String state, String country, String postal_code){
        System.debug('inside saveAddressInAccount');
        Account acnt = [SELECT Id FROM Account WHERE ID = :recordId];
        acnt.BillingStreet = street;
        acnt.BillingCity = city;
        acnt.BillingState = state;
        acnt.BillingCountry = country;
        acnt.BillingPostalCode = postal_code;       
        Database.update(acnt);
    }
    
    
    public class placeIdDecscriptionWrapper {
        @AuraEnabled public String place_id;
        @AuraEnabled  public String description;
        public placeIdDecscriptionWrapper(String place_id,String description){
            this.place_id = place_id;
            this.description = description;
        }  
    }
    
    public class AddressWrapper{
        @AuraEnabled public String street;
        @AuraEnabled public String city;
        @AuraEnabled public String state;
        @AuraEnabled public String country;
        @AuraEnabled public String postal_code;
        public AddressWrapper(){
            this.street = street;
            this.city = city;
            this.state = state;
            this.country = country;
            this.postal_code = postal_code;
        }
        /* public AddressWrapper(String street, String city, String state, String country, String postal_code){
this.street = street;
this.city = city;
this.state = state;
this.country = country;
this.postal_code = postal_code;   
}*/
    }
    
    global static string SampleDataAutoCompleteWebSerive(String url){
        try {
            String str = '';
            str = Str + '{';
            str = Str + '"predictions" : [';
            str = Str + '{';
            str = Str + '"description" : "Hinjawadi Phase 3, MIDC Phase III Main Road, Phase 3, Hinjewadi Rajiv Gandhi Infotech Park, Hinjewadi, Pimpri-Chinchwad, Maharashtra, India",';
            str = Str + '"id" : "a9254a3e25d933fae673aaedb440ab3a196ba5f8",';
            str = Str + '"matched_substrings" : [';
            str = Str + '{';
            str = Str + '"length" : 17,';
            str = Str + '"offset" : 0';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"length" : 9,';
            str = Str + '"offset" : 24';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"length" : 9,';
            str = Str + '"offset" : 92';
            str = Str + '}';
            str = Str + '],';
            str = Str + '"place_id" : "ChIJUdztPG67wjsRErWbfYac1lg",';
            str = Str + '"reference" : "CqQBmwAAAKTzde5nopPoYlSE0uU-EdIC3Jg-B8iGEZAPlaeotNC59kAwFOixIn_rEBVWyT079G0oDK0yijmKR66MKd3sxdeMJXxeMALDukDmU-MrB_mJxLUS7Q8o';
            str = Str + 'a4LIwyFbJ5NhOUZiS9sTGSZmb5nz4MBrzfWdlpOCeRXTPwrZTi28N9Iymj8xrAeUhMpAME4mCcLq-_PmlB4v2EewKMyEx4lJQTwSEKMMxXfhoiXwupMFMCjA29EaFKnx9sIcMM2Ko0jcz_OwagMU-HDY",';
            str = Str + '"structured_formatting" : {';
            str = Str + '"main_text" : "Hinjawadi Phase 3",';
            str = Str + '"main_text_matched_substrings" : [';
            str = Str + '{';
            str = Str + '"length" : 17,';
            str = Str + '"offset" : 0';
            str = Str + '}';
            str = Str + '],';
            str = Str + '"secondary_text" : "MIDC Phase III Main Road, Phase 3, Hinjewadi Rajiv Gandhi Infotech Park, Hinjewadi, Pimpri-Chinchwad, Maharashtra, India",';
            str = Str + '"secondary_text_matched_substrings" : [';
            str = Str + '{';
            str = Str + '"length" : 9,';
            str = Str + '"offset" : 5';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"length" : 9,';
            str = Str + '"offset" : 73';
            str = Str + '}';
            str = Str + ']';
            str = Str + '},';
            str = Str + '"terms" : [';
            str = Str + '{';
            str = Str + '"offset" : 0,';
            str = Str + '"value" : "Hinjawadi Phase 3"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 19,';
            str = Str + '"value" : "MIDC Phase III Main Road"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 45,';
            str = Str + '"value" : "Phase 3"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 54,';
            str = Str + '"value" : "Hinjewadi Rajiv Gandhi Infotech Park"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 92,';
            str = Str + '"value" : "Hinjewadi"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 103,';
            str = Str + '"value" : "Pimpri-Chinchwad"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 121,';
            str = Str + '"value" : "Maharashtra"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 134,';
            str = Str + '"value" : "India"';
            str = Str + '}';
            str = Str + '],';
            str = Str + '"types" : [ "transit_station", "point_of_interest", "establishment", "geocode" ]';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"description" : "Hinjawadi Phase 1, Mann Road, Phase 1, Hinjewadi Rajiv Gandhi Infotech Park, Hinjewadi, Pimpri-Chinchwad, Maharashtra, India",';
            str = Str + '"id" : "a9254a3e25d933fae673aaedb440ab3a196ba5f8",';
            str = Str + '"matched_substrings" : [';
            str = Str + '{';
            str = Str + '"length" : 17,';
            str = Str + '"offset" : 0';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"length" : 9,';
            str = Str + '"offset" : 24';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"length" : 9,';
            str = Str + '"offset" : 92';
            str = Str + '}';
            str = Str + '],';
            str = Str + '"place_id" : "ChIJUdztPG67wjsRErWbfYac1la",';
            str = Str + '"reference" : "CqQBmwAAAKTzde5nopPoYlSE0uU-EdIC3Jg-B8iGEZAPlaeotNC59kAwFOixIn_rEBVWyT079G0oDK0yijmKR66MKd3sxdeMJXxeMALDukDmU-MrB_mJxLUS7Q8o';
            str = Str + 'a4LIwyFbJ5NhOUZiS9sTGSZmb5nz4MBrzfWdlpOCeRXTPwrZTi28N9Iymj8xrAeUhMpAME4mCcLq-_PmlB4v2EewKMyEx4lJQTwSEKMMxXfhoiXwupMFMCjA29EaFKnx9sIcMM2Ko0jcz_OwagMU-HDY",';
            str = Str + '"structured_formatting" : {';
            str = Str + '"main_text" : "Hinjawadi Phase 3",';
            str = Str + '"main_text_matched_substrings" : [';
            str = Str + '{';
            str = Str + '"length" : 17,';
            str = Str + '"offset" : 0';
            str = Str + '}';
            str = Str + '],';
            str = Str + '"secondary_text" : "Mann Road, Phase 1, Hinjewadi Rajiv Gandhi Infotech Park, Hinjewadi, Pimpri-Chinchwad, Maharashtra, India",';
            str = Str + '"secondary_text_matched_substrings" : [';
            str = Str + '{';
            str = Str + '"length" : 9,';
            str = Str + '"offset" : 5';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"length" : 9,';
            str = Str + '"offset" : 73';
            str = Str + '}';
            str = Str + ']';
            str = Str + '},';
            str = Str + '"terms" : [';
            str = Str + '{';
            str = Str + '"offset" : 0,';
            str = Str + '"value" : "Hinjawadi Phase 1"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 19,';
            str = Str + '"value" : "Mann Road"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 45,';
            str = Str + '"value" : "Phase 1"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 54,';
            str = Str + '"value" : "Hinjewadi Rajiv Gandhi Infotech Park"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 92,';
            str = Str + '"value" : "Hinjewadi"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 103,';
            str = Str + '"value" : "Pimpri-Chinchwad"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 121,';
            str = Str + '"value" : "Maharashtra"';
            str = Str + '},';
            str = Str + '{';
            str = Str + '"offset" : 134,';
            str = Str + '"value" : "India"';
            str = Str + '}';
            str = Str + '],';
            str = Str + '"types" : [ "transit_station", "point_of_interest", "establishment", "geocode" ]';
            str = Str + '}';
            str = Str + '],';
            str = Str + '"status" : "OK"';
            str = Str + '}';
            return str;
            
        } catch (Exception e) {
            return e.getMessage();
        }
    }
    
    global static string SampleDataExactCompleteWebSerive(String place_id){
        try{
            String jsonAddress = '{'+
                '"html_attributions" : [],'+
                '"result" : {'+
                '"address_components" : ['+
                ' {'+
                '"long_name" : "5",'+
                '"short_name" : "5",'+
                '"types" : [ "floor" ]'+
                ' },'+
                ' {'+
                ' "long_name" : "48",'+
                '"short_name" : "48",'+
                '"types" : [ "street_number" ]'+
                '},'+
                '{'+
                '"long_name" : "Pirrama Road",'+
                '"short_name" : "Pirrama Rd",'+
                '"types" : [ "route" ]'+
                '},'+
                '{'+
                '"long_name" : "Pyrmont",'+
                '"short_name" : "Pyrmont",'+
                '"types" : [ "locality", "political" ]'+
                '},'+
                '{'+
                '"long_name" : "Australia",'+
                '"short_name" : "AU",'+
                '"types" : [ "country", "political" ]'+
                '},'+
                '{'+
                '"long_name" : "2009",'+
                '"short_name" : "2009",'+
                '"types" : [ "postal_code" ]'+
                '}'+
                ']'+
                '}'+
                '}';
            
            return jsonAddress;
        }catch (Exception e) {
            return e.getMessage();
        }
    }
}
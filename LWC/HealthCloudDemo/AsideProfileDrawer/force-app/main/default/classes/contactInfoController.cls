public with sharing class contactInfoController {
    public contactInfoController() {

    }


    @AuraEnabled(cacheable=true)
    public static list<contact> getContactList(Id accID){
        return [Select name, Relationship__c,Profile_Image__c from contact where account.id =: accID] ;
    }
}

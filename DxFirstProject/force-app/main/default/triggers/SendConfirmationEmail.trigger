// trigger to email when the record is saved
// after trigger so that it can use the record id

trigger SendConfirmationEmail on alekhcognizant__Session_Speaker__c (after insert) {

    // create the listo of ID so that we can save the ID
    // collects ID in one list of a single SOQL query
    list<Id> sessionspeakerId = new list<Id>();
    for(alekhcognizant__Session_Speaker__c newItem : trigger.new){
        // Save the new record in the list
		sessionspeakerId.add(newItem.id);
    }
    
    //list to temp create the record before inserting into the database
    //SOQL query to find out data from the about that record from the database
    //using __r are used for the relationship itteration
    //
    //list consist of the junction object record.
    //first we find out the session name using the __r relationship 
    //second we find out the session date using the __r relationship
    //third we find out the speaker name using the __r relationship
    //fourth we find out the first name using the __r relationship
    //
    //using IN operator allows to save multiple values in a where clause
    //IT IS THE SHORTHAND FOR MULTIPLE OR CONDITIONS
   
    list<alekhcognizant__Session_Speaker__c> sessionspeaker = 
       [SELECT alekhcognizant__Session__r.Name,
       		   alekhcognizant__Session__r.Session_Date__c,
        		alekhcognizant__Speaker__r.First_Name__c,
        alekhcognizant__Speaker__r.Last_Name__c,
        alekhcognizant__Speaker__r.Email__c
        FROM alekhcognizant__Session_Speaker__c WHERE Id IN :sessionspeakerId];
    
    // check if there is any record that to whom we have to send mail
    if(sessionspeaker.size()>0){
        
        // create a record from the above SOQL resulted list
        // use EmailManager.sendMail(address, subject, message)
        // we have to check whether the mail is empty or not
 		alekhcognizant__Session_Speaker__c sessionspeak = sessionspeaker[0];
        if(sessionspeak.speaker__r.Email__c != null){
            String address = sessionspeak.speaker__r.Email__c;
            String subject = 'Speaker confirmation';
            String message = 'Thank you';
            EmailManager.sendMail(address, subject, message);
            
        }
    }
    
}
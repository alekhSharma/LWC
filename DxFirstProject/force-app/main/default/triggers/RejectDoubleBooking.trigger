// before trigger is used for the field validation
// as we dont have to save the record if it is double booked

trigger RejectDoubleBooking on Session_Speaker__c (before insert, before update) {

    //collect ID's to reduce data calls
    List<Id> speakerIds = new List<Id>();
    system.debug('speakerIds' + speakerIds);
    //map to save the new data coming from user trigger.new
    //it uses ID, DateTime fields
    Map<Id,DateTime> requested_bookings = new Map<Id,DateTime>();
    system.debug('map requested booking'+requested_bookings);

    //get all speakers related to the trigger
    //set booking map with ids to fill later
    for(Session_Speaker__c newItem : trigger.new) {
        // we put the new data session in a list
        requested_bookings.put(newItem.Session__c,null);
        system.debug('requested_bookings'+requested_bookings);
        speakerIds.add(newItem.Speaker__c);
        system.debug('speaker Id -> '+speakerIds);
    }

    //fill out the start date/time for the related sessions
    List<Session__c> related_sessions = [SELECT ID, Session_Date__c from Session__c WHERE ID IN :requested_bookings.keySet()];
    system.debug('SOQL 1 session -> '+ related_sessions);
    // we find out the old data with SOQL but only the record which match the ID from the new data gets picked
    // we put the id of these fields which gets matched along with its date
    for(Session__c related_session : related_sessions) {
        requested_bookings.put(related_session.Id,related_session.Session_Date__c);
        system.debug('Map again related session :'+requested_bookings);
    }

    //get related speaker sessions to check against
    //SOQL to 
    List<Session_Speaker__c> related_speakers = [SELECT ID, Speaker__c, Session__c, Session__r.Session_Date__c from Session_Speaker__c WHERE Speaker__c IN :speakerIds];
	system.debug('SOQL 2 speacker -> '+related_speakers);
    //check one list against the other
    system.debug('checking the list against each other');
    for(Session_Speaker__c requested_session_speaker : trigger.new) {
        system.debug('requested_session_speaker'+requested_session_speaker);
        DateTime booking_time = requested_bookings.get(requested_session_speaker.Session__c);
        system.debug('Getting date time -> '+booking_time);
        for(Session_Speaker__c related_speaker : related_speakers) {
            system.debug('related speacker list ->'+related_speaker);
            if(related_speaker.Speaker__c == requested_session_speaker.Speaker__c &&
               related_speaker.Session__r.Session_Date__c == booking_time) {
                   requested_session_speaker.addError('The speaker is already booked at that time');
               }
        }
    }


}
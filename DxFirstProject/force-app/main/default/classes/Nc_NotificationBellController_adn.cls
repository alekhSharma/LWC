public class Nc_NotificationBellController_adn {
	//Fetch Notification records
    @AuraEnabled
    public static NotificationContainer getNotifications(Boolean loginFlow){
        //Check whether the logged in user has already seen notifications for today
        User loggedInUser = [select notification_read__c from User where Id =:UserInfo.getUserId()];
        //Prepare Wrapper - Fetch all notifications in order
        list<NotificationWrapper> nw = new list<NotificationWrapper>();
        if(loggedInUser.notification_read__c!=Date.today()){
            //Fetch Notification Mapping from Custom mdt
            map<String,Nc_Notification_Mapping__mdt> notifyMapping = new map<String,Nc_Notification_Mapping__mdt>();
            for(Nc_Notification_Mapping__mdt notifyMdt: [SELECT DeveloperName , Notification_Label__c, Notification_Type__c 
                                                         FROM Nc_Notification_Mapping__mdt])
            {
                notifyMapping.put(notifyMdt.Notification_Type__c, notifyMdt);
            }
            
            //Get list of all notifications users has opted out of remiders, Or has accepted it
            set<Id> notificationIdSet = new set<Id>();
            for(Nc_NotificationCenter__c rec: [select id,Notification__c from Nc_NotificationCenter__c 
                                               where User__c =:UserInfo.getUserId() and
                                               (Do_Not_Remind__c=true OR Acceptance__c=true)
                                              ])
            {
                notificationIdSet.add(rec.Notification__c);
            }
            NRWrapper nrw;
            for(Nc_Notification__c rec: [SELECT Id, Notification_Start_Date_Time__c, Notification_End_Date_Time__c, 
                                         Notification_Message__c, Name, Notification_Type__c, Notification_Title__c,
                                         External__c, Related_Document__c
                                         FROM Nc_Notification__c
                                         where Active__c = true //Notification should be active
                                         and Id Not IN : notificationIdSet //Exclude notifications
                                         and Notification_Start_Date_Time__c<=:DateTime.now()
                                         and Notification_End_Date_Time__c>=:DateTime.now()
                                         and External__c = :loginFlow//loginFlow identify whether the flow initiated by external user/internal
                                         order by Notification_Order__c])
            {
                nrw = new NRWrapper(rec);
                nw.add(new NotificationWrapper(nrw,notifyMapping.get(rec.Notification_Type__c)));
            }
            Nc_ServiceLayer_adn.updateRecords(new list<User>{loggedInUser},true,'update');//No partial processing
            System.debug('***rv:'+nw);
        }
        //Add into the container
        NotificationContainer nc = new NotificationContainer();
        nc.nw = nw;
        nc.orgId = UserInfo.getOrganizationId();
        return nc;
    }
    public class NotificationContainer{
        @AuraEnabled
        public list<NotificationWrapper> nw;
        @AuraEnabled
        public String orgId;
    }
    
	/*** Prepare Wrapper ***/
    public Class NotificationWrapper{
        @AuraEnabled
        public NRWrapper notificationRecord;
        @AuraEnabled
        public Nc_Notification_Mapping__mdt type;
        public NotificationWrapper(NRWrapper notificationRecord, Nc_Notification_Mapping__mdt type){
            this.notificationRecord = notificationRecord;
            this.type = type;
        }
    }
    /*** Notification Record Wrapper ***/
    public Class NRWrapper{
        @AuraEnabled
        public String Id, message, typeIs, name, title, relDoc;
        @AuraEnabled
        public Datetime startDate, endDate;
        @AuraEnabled
        public boolean isExt;
        public NRWrapper(Nc_Notification__c nr){
            Id = nr.Id;
            startDate = nr.Notification_Start_Date_Time__c;
            endDate = nr.Notification_End_Date_Time__c;
            message = nr.Notification_Message__c;
            name = nr.Name;
            typeIs = nr.Notification_Type__c;
            title = nr.Notification_Title__c;
            isExt = nr.External__c;
            relDoc = nr.Related_Document__c;
        }
    }
    /*
     * SaveNotifications
     * 
    */
    @AuraEnabled
    public static map<boolean,list<SObject>> saveNotifications(String notificationResponseLists){
        list<ResponseWrap> responseList = (list<ResponseWrap>)JSON.deserialize(notificationResponseLists,list<ResponseWrap>.class);
        System.debug('***ac:responseList'+responseList);
        //Set notification date for logged in user
        User loggedInUser = [select notification_read__c from User where Id =:UserInfo.getUserId()];
        loggedInUser.Notification_Read__c=Date.Today();
        update loggedInUser;
        
        //Update notification response records
        list<Nc_NotificationCenter__c> ncList = new list<Nc_NotificationCenter__c>();
        Nc_NotificationCenter__c ncRecord;
        //Get org namespace
        Organization org = [SELECT NamespacePrefix, Id FROM Organization];
        String ns = (String.isBlank(org.NamespacePrefix)?'':org.NamespacePrefix+'__');
        for(ResponseWrap rec: responseList){
            ncRecord = new Nc_NotificationCenter__c();
            ncRecord.put(ns+'Acceptance__c',Boolean.valueOf(rec.Acceptance));
            ncRecord.put(ns+'Do_not_Remind__c',Boolean.valueOf(rec.Do_not_Remind));
            ncRecord.put(ns+'Notification__c',rec.Notification);
            ncRecord.put(ns+'User__c',rec.User);
            ncList.add(ncRecord);
        }
        System.debug('***ncList:'+ncList);
        return Nc_ServiceLayer_adn.updateRecords(ncList,true,'insert');//No partial processing
    }
    public Class ResponseWrap{
		public string sobjectType;
        public string Acceptance;
        public string Do_not_Remind;
        public string Notification;
        public string User;
    }
}
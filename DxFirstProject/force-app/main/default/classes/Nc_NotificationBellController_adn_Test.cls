/**
 * Test Class for Nc_NotificationBellController_adn Class
 */
@isTest(seeAllData=false)
private class Nc_NotificationBellController_adn_Test {
	
	@testsetup
	private static void setupData(){
		//Create notification Records                
		list<Nc_Notification__c> notificationsList = new list<Nc_Notification__c>();
		notificationsList.add(new Nc_Notification__c(
			Notification_Start_Date_Time__c = Date.today() ,
			Notification_End_Date_Time__c = Date.today().addDays(10),
			Notification_Message__c = 'Sample Message1',
			Notification_Type__c = 'Reminder',
			Notification_Title__c = 'Sample Title1',
			Related_Document__c='',
			External__c=false,
			Active__c=true
		));
		notificationsList.add(new Nc_Notification__c(
			Notification_Start_Date_Time__c = Date.today() ,
			Notification_End_Date_Time__c = Date.today().addDays(10),
			Notification_Message__c = 'Sample Message2',
			Notification_Type__c = 'Acceptance',
			Notification_Title__c = 'Sample Title2',
			Related_Document__c='',
			External__c=false,
			Active__c=true
		));
		Database.insert(notificationsList);
		
		//Create notification center records - Supposing logged in user has opted out from both the created notifications
		list<Nc_NotificationCenter__c> ncList = new list<Nc_NotificationCenter__c>();
		ncList.add(new Nc_NotificationCenter__c(Notification__c=notificationsList[0].Id, User__c=userinfo.getUserId(),Do_Not_Remind__c=true));
		ncList.add(new Nc_NotificationCenter__c(Notification__c=notificationsList[0].Id, User__c=userinfo.getUserId(),Acceptance__c=true));
		Database.insert(ncList);
		
		//Create User Record records
		User T1_User = new User();
	    Profile Prof = [SELECT Id FROM Profile WHERE Name='System Administrator'];
	    String nameIs = 'newuser21269'+ Crypto.getRandomInteger() +'@testorg.com';
	    T1_User = new User (Alias = 'T1_User', 
	                        firstName = 'FirstName', LastName='Testing', UserName = nameIs,
	                        Email=nameIs, EmailEncodingKey='UTF-8', 
	                        LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = Prof.Id,
	                        TimeZoneSidKey='Asia/Kolkata',
	                        notification_read__c=Date.today()
	                        );
	 	Database.insert(T1_User);
	}
	/*
	* Test getNotification method - postive test case
	*/
	private static testMethod void getNotificationsTest_Positive() {
        //Fetch the created user
        User T1_User = [select id from User where Alias='T1_User'];
        T1_User.notification_read__c = Date.today().addDays(-1);
        Database.update(T1_User);
        System.runAs(T1_User){
	        Test.StartTest();
	        	//Assertion - 2 Notification records should exists
	        	Nc_NotificationBellController_adn.NotificationContainer nc = Nc_NotificationBellController_adn.getNotifications(false);
            	//Assertion - 2 records should be returned	
	        	System.assert(nc.nw.size()!=0);
	        	System.assert(nc.nw.size()==2);
	        	
	        	//Assertion - a Notification records should exists
	        	//Create one record for notification center junction object
	            Nc_Notification__c notificationRecord = [Select Id from Nc_Notification__c where Notification_Type__c='Reminder'];
	            insert new Nc_NotificationCenter__c(Notification__c=notificationRecord.Id, User__c=userinfo.getUserId(),Do_Not_Remind__c=true); 
	            nc = Nc_NotificationBellController_adn.getNotifications(false);
	        	//Assertion - 2 records should be returned	
	        	System.assert(nc.nw.size()!=0);
	        	System.assert(nc.nw.size()==1);
    	    Test.StopTest();
        }
    }
	/*
	* Test getNotification method - negative test case
	*/
    private static testMethod void getNotificationsTest_Negative() {
        //Fetch the created user
        User T1_User = [select id from User where Alias='T1_User'];
        System.runAs(T1_User){
	        Test.StartTest();
            	System.debug('**nr'+[select notification_read__c from User where Alias='T1_User']);
	        	Nc_NotificationBellController_adn.NotificationContainer nc = Nc_NotificationBellController_adn.getNotifications(false);
	        	//Assertion - no records should be returned	
	        	System.assert(nc.nw.size()==0);
    	    Test.StopTest();
        }
    }
    /*
	* Test getNotification method - negative test case
	*/
    private static testMethod void saveNotificationsTest() {
        //Fetch the created user
        User T1_User = [select id from User where Alias='T1_User'];
        System.runAs(T1_User){
	        Test.StartTest();
	        	//Create one record for notification center junction object
	            Nc_Notification__c notificationRecord = [Select Id from Nc_Notification__c where Notification_Type__c='Acceptance'];
	        	
            	//Create wrapper record for save
            	Nc_NotificationBellController_adn.ResponseWrap rw = new Nc_NotificationBellController_adn.ResponseWrap();
				rw.sobjectType='Notification__c';        	
                rw.Acceptance='false';
                rw.Do_not_Remind='true';
                rw.Notification=notificationRecord.Id;
                rw.User=userinfo.getUserId();
            	list<Nc_NotificationBellController_adn.ResponseWrap> rwList = new list<Nc_NotificationBellController_adn.ResponseWrap>();
            	rwList.add(rw);
	            map<boolean,list<SObject>> results = Nc_NotificationBellController_adn.saveNotifications(JSON.serialize(rwList));
            	//Assertion - map size should be one
	        	System.assert(results.size()==1);
	        	
    	    Test.StopTest();
        }
    }
    
}
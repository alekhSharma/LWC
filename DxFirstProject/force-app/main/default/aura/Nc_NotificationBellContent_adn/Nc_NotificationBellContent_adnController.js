({
    reset : function(component, event, helper){
      	console.log('***reset handled');
        component.set('v.notificationList',[]);  
    },
    setupComponentInstance : function(component, event, helper){
        var notificationVar = component.get('v.notification');
        var notificationListVar = component.get('v.notificationList');
        var notificationIndexVar = component.get('v.notificationIndex');
        var currentUserId = $A.get('$SObjectType.CurrentUser.Id');
        
        console.log('***notification var:'+JSON.stringify(notificationVar));
        console.log('***notification var2:'+JSON.stringify(notificationListVar));
        var recordedResponse, foundInList=false;
        for(var recordIs of notificationListVar) {
            if(recordIs[notificationIndexVar]){
                recordedResponse = recordIs[notificationIndexVar];
                foundInList=true;
            }
        };
        if(foundInList){
            component.set('v.notificationResponse',recordedResponse); 
        }else{
            //Set Empty notification record 
            var obj = new Object();
            obj['sobjectType']='Nc_NotificationCenter__c';
            obj['Acceptance']=false;
            obj['Do_not_Remind']=false;
            obj['Notification']=notificationVar.notificationRecord.Id;
            obj['User']=currentUserId;
            component.set('v.notificationResponse',obj);
        }
    },
    recordResponse : function(component, event, helper) {
        //record acceptance response
        var notificationListVar = component.get('v.notificationList');
        var notificationResponseVar = component.get('v.notificationResponse');
        var notificationIndexVar = component.get('v.notificationIndex');
        
        console.log('**record Response:0 '+JSON.stringify(notificationResponseVar));
        
        /*
         * Check whether the record is checked or not
         * If checked add it, If unchecked remove it
         * Set values in notification instance accordingly
         */
        var addRecord=false;//This flag is used to identify whether the record should be added not not in the list
        if(event.getSource().getLocalId()=='select'){
            notificationResponseVar['Acceptance']=true;
            addRecord=true;
        }else if(event.getSource().getLocalId()=='doNotRemind' && event.getSource().get('v.value')){
            addRecord=true; 
        }else{
            notificationResponseVar['Acceptance']=false;
            //Remove from notificationList - Identify the index & remove it
            var indexIs;
            for(var i=0; notificationListVar.length;i++){
                if(notificationListVar[i][notificationIndexVar]){
                    indexIs=i;
                    break;
                }
            }
            console.log('***spliced up:'+indexIs);
            //Remove element from this index
            notificationListVar.splice(indexIs,1);//splice removes the element & return removed element
            console.log('***spliced up:'+JSON.stringify(notificationListVar));
        }
        component.set('v.notificationResponse',notificationResponseVar);
        
        //Update notification list
        var notificationRec, foundInList=false;
        notificationListVar.forEach(function(recordIs){
            if(recordIs[notificationIndexVar]){
                recordIs[notificationIndexVar] = notificationResponseVar;
                foundInList=true;
            }
        });
        //If not found then add
        if(foundInList==false && addRecord==true){
            notificationRec = new Object();
            notificationRec[notificationIndexVar] = notificationResponseVar;
            notificationListVar.push(notificationRec);
        }
        console.log('**record Response: '+JSON.stringify(notificationListVar));
        component.set('v.notificationList',notificationListVar);
    },
    saveNotificationRecords : function(component, event, helper){
        /*
         * Get all notification response
         * Pass the response list to ther server method
         * Server method will save it
        */
        var responseList = [], notificationListVar = component.get('v.notificationList');
        notificationListVar.forEach(function(arrayRecord){
            for(var key in arrayRecord){
                responseList.push(arrayRecord[key]);
            }   
        });
        console.log('***response lists123:'+JSON.stringify(responseList));
        if(responseList.length>0){
            //Get server action
            var saveNotifications_sa = component.get('c.saveNotifications');
            //Set params
            saveNotifications_sa.setParams({
                'notificationResponseLists':JSON.stringify(responseList)
            });
            //set callback method
            saveNotifications_sa.setCallback(this, function(response){
                var state = response.getState();
                if(state==='SUCCESS'){
                    var responseValue = response.getReturnValue();
                    console.log('***response is: '+responseValue);
                }else{
                    console.log('***error:'+JSON.stringify(response.getError()));
                }
                //helper.handleShowHideSpinner(component, event, helper);
            });
            //Enqueue action
            $A.enqueueAction(saveNotifications_sa);   
        }else{
            console.log('*** No respones recorded.');
        }
        //Close the popup - Fire event to close the popup
        var closeEvent = component.getEvent('notificationEvent');
        closeEvent.setParams({
            'eventType':'close'
        });
        closeEvent.fire();
    },
    showHideSpinner : function(component, event, helper){
        helper.handleShowHideSpinner(component, event, helper);
    },
    checkValid : function(component, event, helper){
    	/* Function to check whehter acceptance form is accepted or note */
        //Get notification instances
        var notificationVar = component.get('v.notification');
        if(notificationVar.type.DeveloperName=='Acceptance'){
            //Check whether user accepted or not.
            var notificationResponseVar = component.get('v.notificationResponse');
            console.log('***Check valid called: '+notificationResponseVar['Acceptance']);
            return notificationResponseVar['Acceptance'];
        }else{
            return true;
        }
    }
})
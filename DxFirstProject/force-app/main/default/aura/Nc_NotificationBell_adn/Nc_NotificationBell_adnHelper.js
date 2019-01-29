({
    handleSetup : function(component, event, helper){
        //Get server action
        var getNotifications_sa = component.get('c.getNotifications');
        //Set Params
        getNotifications_sa.setParams({
            'loginFlow':component.get('v.loginFlow')
        });//No Parameters required
        //Set callback
        getNotifications_sa.setCallback(this,function(response){
            var state = response.getState();
            if(state==='SUCCESS'){
                var rvContainer = response.getReturnValue();
                var returnValue = rvContainer.nw;
                console.log('***'+returnValue);
                if(returnValue.length>0){
                    component.set('v.notifications',returnValue);
                    component.set('v.orgId',rvContainer.orgId);
                    //Notification Index will be 0 by default
                    this.setNotificationInstance(component, 0);
                    //Check return values
                    var stepsList = [];
                    if(returnValue.length>1){//If there are more than one notification
                        returnValue.forEach(function(recordIs){
                            stepsList.push(recordIs.notificationRecord.title);
                        });
                        component.set('v.progressSteps',stepsList);
                        component.set('v.hasNext',true);
                    }else{
                        //Reset already set parameters
                        component.set('v.progressSteps',[]);
                        component.set('v.hasNext',false);
                        component.set('v.hasPrevious',false);
                    }
                    //Get notification content component
                    var nbcVar = component.find('nbc');
                    nbcVar.reset();
                    //Show Popup
                    helper.showHideModal(component);
                    helper.resizePopup(component);   
                }
            }else{
                console.log('***'+JSON.stringify(response.getError()));
            }
        });
        //Enqueue action
        $A.enqueueAction(getNotifications_sa);   
    },
    setNotificationInstance: function(component,index){
        console.log('***handleNext index'+index);
        //Set notification instance
        component.set('v.notification',component.get('v.notifications')[index]);
        //Set current step
        component.set('v.currentStep',component.get('v.notifications')[index].notificationRecord.title);
        
        //Set button visibility
        var notificationList = component.get('v.notifications');
        console.log('***handleNextsd handled'+notificationList.length+index);
        if(notificationList.length > 1 && notificationList.length==(index+1) && index!=0){
            component.set('v.hasNext',false);
            component.set('v.hasPrevious',true);
        }else if(notificationList.length > 1 && (index+1) < notificationList.length && index!=0){
            component.set('v.hasNext',true);
            component.set('v.hasPrevious',true);
        }else if(notificationList.length > 1 && (index+1) < notificationList.length && index==0){
            component.set('v.hasNext',true);
            component.set('v.hasPrevious',false);
        }
        component.set('v.notificationIndex',index);
        //Hide spinner
        var nbcVar = component.find('nbc');
        nbcVar.showHideSpinner();
    },
    showHideModal : function(component) {
        var modal = component.find("NotificationContainer");
        $A.util.toggleClass(modal, 'slds-fade-in-open');
        var overlay = component.find("overlay");
        $A.util.toggleClass(overlay, 'slds-backdrop--open');
        //component.set("v.showDialog", "false");
        //Reset standard style
        component.set("v.cssStyle", ".forceStyle .viewport .oneHeader.slds-global-header_container {z-index:5} .forceStyle.desktop .viewport{overflow:hidden} .slds-global-header_container{z-index: 0;}");        
    },
    resizePopup : function(component){
        component.set("v.cssStyle", ".forceStyle .viewport .oneHeader.slds-global-header_container {z-index:0} .forceStyle.desktop .viewport{overflow:hidden} .slds-global-header_container{z-index: 0;}");        
    }
})
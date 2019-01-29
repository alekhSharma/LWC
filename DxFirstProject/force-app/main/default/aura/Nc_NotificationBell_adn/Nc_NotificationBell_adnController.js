({
    doInit : function(component, event, helper){
        console.log('***doInit');
        helper.handleSetup(component, event, helper); 
    },
    handleNotificationEvent : function(component, event, helper) {
    	//Show spinner
        var nbcVar = component.find('nbc');
        nbcVar.showHideSpinner();

        var paramIs = event.getParam('eventType');
        console.log('***event handled: '+paramIs);
        var notificationIndexVar = component.get('v.notificationIndex');
        var isValidVar = component.get('v.isValid');
        if(paramIs==='next'){
            var response = nbcVar.checkValid();
            component.set('v.isValid',response);//Used to show error message component
            if(response){
                notificationIndexVar++;//Increment index by 1
                helper.setNotificationInstance(component,notificationIndexVar);   
            }else{
                nbcVar.showHideSpinner();
            }
        }else if(paramIs==='previous'){
            //Reset isValid var if required
            if(!isValidVar){
                component.set('v.isValid',true);
            }
            notificationIndexVar--;//Decrement index by 1
            helper.setNotificationInstance(component,notificationIndexVar);
        }else if(paramIs==='save'){
            var response = nbcVar.checkValid();
            component.set('v.isValid',response);//Used to show error message component
            if(response){
                //call notification bell content method
                nbcVar.saveRecords();  
                //Set flow variables
                component.set('v.flowCompleted',true);
                nbcVar.showHideSpinner();
            }else{
                nbcVar.showHideSpinner();
            }
        }else if(paramIs==='close'){
            //Close & Hide spinner
            nbcVar.showHideSpinner();
            helper.showHideModal(component);
        }
    },
    toggleDialog : function(component, event, helper){
        helper.showHideModal(component);
    }
})
({
    // initialozes the component data with hard coded notifications 
    // and display a toast when the app is initialized 
	onInit : function(component, event, helper) {
		component.set('v.notifications',[
            {time: '00:01', message: 'Welcome !!'}
        ]);
        
        helper.displayToast(component, 'success','Ready');
	},
    
    // clear the notifications history
    onClear : function(component, event, helper){
        component.set('v.notifications',[]);
    },    
    
    // toggeles between muted and unmuted state
    onToggleMute : function(component, event, helper){
    	var isMuted = component.get('v.isMuted');
        component.set('v.isMuted',!isMuted);
        helper.displayToast(component,'success','Notifications '+ ((!isMuted) ? 'muted' : 'unmuted') +'.');
	}
})
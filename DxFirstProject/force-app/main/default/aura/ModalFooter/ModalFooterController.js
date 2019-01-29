({
	handleAction : function(component, event, helper){
        console.log('***handleAction Called:');
        var handleActionEvent = component.getEvent('notificationEvent');
        handleActionEvent.setParams({
            'eventType':event.getSource().get('v.name')
        });
        handleActionEvent.fire();
        console.log('**next action:'+handleActionEvent);
    }
})
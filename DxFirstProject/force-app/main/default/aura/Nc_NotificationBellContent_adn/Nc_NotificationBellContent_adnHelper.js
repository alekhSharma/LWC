({
	handleShowHideSpinner : function(component, event, helper) {
		var spinner = component.find('notificationSpinner');
        $A.util.toggleClass(spinner,'slds-hide');
	}
})
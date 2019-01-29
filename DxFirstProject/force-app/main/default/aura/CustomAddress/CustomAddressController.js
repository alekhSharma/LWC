({
    displayAddress : function(component, event, helper) {
        var address = event.getParam("address");
        component.set("v.street",address.street);
        component.set("v.city",address.city);
        component.set("v.state",address.state);
        component.set("v.country",address.country);
        component.set("v.postal_code",address.postal_code);
    },
    
    saveAddress : function(component, event, helper) {
        var recordId = component.get("v.recordId");
        var street = component.get("v.street");
        var city = component.get("v.city");
        var state = component.get("v.state");
        var country = component.get("v.country");
        var postal_code = component.get("v.postal_code");
        console.log('recordId : '+recordId);
        var action = component.get("c.saveAddressInAccount");
        action.setParams({
            'recordId' : recordId,
            'street' : street,
            'city' : city,
            'state' : state,
            'country' : country,
            'postal_code' : postal_code
        });
        action.setCallback(this, function(response){
            console.log('state : '+response.getState());
            if(response.getState() === 'SUCCESS'){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Saved',
                    message : 'Address Saved Successfully',
                    type : 'success',
                    mode : 'dismissible '
                });
                toastEvent.fire();
            }
            else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message : "Address couldn't be saved due to some error",
                    type : 'error',
                    mode : 'dismissible '
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})
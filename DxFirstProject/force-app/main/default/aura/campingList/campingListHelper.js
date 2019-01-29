({
createCampings : function(component,camping) {
    var allCampings = component.get("v.items");
    var newCamping = JSON.parse(JSON.stringify(camping));

    // set the sobjectType!
    camping.sobjectType='Camping_Item__c';

    var action = component.get("c.saveItem");
    action.setParams({"item" : camping});

    action.setCallback(this, function(response){
        var state = response.getState();
        if(component.isValid() && state === "SUCCESS"){
            allCampings.push(newCamping);
            component.set("v.items",allCampings);
        }else if(state === "ERROR"){
            var errors = response.getError();
            if (errors) {
                if (errors[0] && errors[0].message) {
                    console.log("Error message: " + errors[0].message);
                }else{
                    console.log("Unknown Error");
                }
            }
        }
    });        

    $A.enqueueAction(action);
}
})
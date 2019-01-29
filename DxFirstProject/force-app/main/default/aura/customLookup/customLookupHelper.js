({
    searchHelper : function(component,event,getInputkeyWord) {
        var action = component.get("c.fetchLookUpValues");
        action.setParams({
            'searchKeyWord': getInputkeyWord,
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                /***  Start
					By- Alekh sharma
                    ***/
                console.log(storeResponse);
                /***  End
					By- Alekh sharma
                    ***/
                // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if(storeResponse == null)
                    component.set("v.Message", 'No Result Found...');
                else if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);
                $A.util.removeClass(component.find("mySpinner"), "slds-show");
            }
        });
        $A.enqueueAction(action);
    },
})
({
    sendHelper: function(component, getEmail, getSubject, getbody, listAllMethods) {
        // call the server side controller method 	
        var action = component.get("c.sendMailMethod");
        // set the 3 params to sendMailMethod method   
        action.setParams({
            'mMail': getEmail,
            'mSubject': getSubject,
            'mbody': getbody,
            'listAllMethods': listAllMethods
        });
        action.setCallback(this, function(response) {
            //alert(state);
            var state = response.getState();
           // alert(state);
            if (state == "SUCCESS") {
                var storeResponse = response.getReturnValue();
                //alert(storeResponse);
                // if state of server response is comes "SUCCESS",
                // display the success message box by set mailStatus attribute to true
                 component.set("v.mailStatus", true);
                
               /* if(storeResponse!=true){
                component.set("v.mailStatus", true);
                }
                else
                {
                    component.set("v.mailStatus", false);
                }*/
            }
            else
            {
                alert(state+':: Send Email Failed, Please check your org.');
            }
  
        });
        $A.enqueueAction(action);
    },
})
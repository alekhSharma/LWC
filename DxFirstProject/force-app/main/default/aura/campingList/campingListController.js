/*
({ clickCreateItem: function(component, event, helper) 
  	{
                                                                                                    // validation for the inghtining basic component so that we can validate the fields
                                                                                                    // component.find('') finds the component and prepare its array of ID
                                                                                                    // reduce is a JS method which reduces the array to a single value 
                                                                                                    // reduce values are captured by validSoFar and it checks if the invalid field is there
                                                                                                    // 	invalid for this is when required field is not there
                                                                                                    // 	inputCmp stores the current input and .get('v.validity') gets it check form the currentinput value
                                                                                                    // 	inputcmp.showhelpmessageinvalid() display error for invalid fields
        var validExpense = component.find('Name').reduce(function (validSoFar, inputCmp) 
        {
																									// Displays error messages for invalid fields
         	inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
		}, true);
      
                                                                                                        // If we pass error checking, do some real work
                                                                                                        // check validExpense flag 
                                                                                                        // gets the newItem field and newItems attribute items
                                                                                                        // push it to the array
                                                                                                        // set to the component
                if(validExpense)
                    {
                    var newItem = component.get("v.newItem");
                    
       			helper.createItem(component.newItem);
                        
                            component.set("v.newItem", 
                          {'sobjectType' : 'Camping_Item__c',
                           'Name' : '',
                           'Quantity__c' : 0,
                           'Price__c' : 0,
                           'Packed__c' : false});

                    }
        

	},
                                                                                                        // this function is controlled with the handler tag on the component page
                                                                                                        // it is used to load the page and shows the list of all the records
  doInit: function(component, event, helper){
                                                                                                              // we use c.getitems to call the function from the apex controller
                                                                                                              // and save it in action
      var action = component.get("c.getitems");
      console.log(action);
      
                                                                                                      // we call the setCallback function to get the callback function 
      action.setCallback(this, function(response){
                                                                                                      // we save the state into the state variable
          var state = response.getState();
          console.log(state);
                                                                                                          // if state is SUCCESS
          if(state === "SUCCESS"){
                                                                                                          // set the component and get the return value
              component.set("v.items",response.getReturnValue());
          }
          else{
                                                                                                                      // else display error
              console.log("Failed with state: "+state);
          }
      });
      
                                                                                                                          // $A is the framework global variable that provides a number of important functions and services
                                                                                                                          // It adds the server call that we have confrigured to the lightning components framework reques queue.
                                                                                                                          // It along with other pending server requests
                                                                                                                          // will be sent to the server in the next request cycle.
      $A.enqueueAction(action);
  } ,
  
  
  
  handleAddItem: function(component, event , helper){
		var action = component.get("c.saveItem");
      action.setParams({"item":newItem});
      action.setCallback(this, function(response){
          var state = response.getState();
          if(component.isValid() && state==="SUCCESS"){
              
          }
      });
      
      $A.enqueueAction(action);
 }
 
 
}
)
*/
({
doInit : function(component, event, helper){
    var action =  component.get("c.getItems");
    action.setCallback(this,function(response){
        var state = response.getState();
        if(component.isValid() && state === "SUCCESS"){
            component.set("v.items", response.getReturnValue());
        }else if(state === "ERROR"){
            console.log('Failed with below state: ' + state);
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
},

handleAddItem : function(component, event, helper){
 var item=event.getParam("item");
        var action=component.get("c.saveItem");
        
        action.setParams
        ({
                "item" : item
        });
        
        action.setCallback(this, function(response)
                           {
                               var state=response.getState();
                               if(component.isValid() && state == 'SUCCESS')
                               {
                                   var itemArray=component.get("v.items");
                                   itemArray.push(response.getReturnValue());
                                   component.set("v.items", itemArray);
                               }
                               else
                               {
                                   console.log('Error in state: '+ state);
                               }
                           });
        
        $A.enqueueAction(action);
},
})
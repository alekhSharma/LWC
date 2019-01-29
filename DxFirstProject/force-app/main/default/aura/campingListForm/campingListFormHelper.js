({
createItem : function(component,item) {
    console.log("Inside the helper function");
    var addEvent = component.getEvent("addItem");
    addEvent.setParams({"item" : item});
    addEvent.fire();
    component.set("v.newItem",{'sObjectType':'Camping_Item__c',
                                       'Name': '',
                                       'Quantity__c': 0,
                                       'Price__c': 0,
                                       'Packed__c': false});
}
})
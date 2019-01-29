({
    doInit : function(component, event, helper){ 
        var oRecord = component.get("v.oRecord");
        component.set("v.primaryFieldValue",oRecord[component.get("v.primarySearchField")]);
        component.set("v.secondaryFieldValue",oRecord[component.get("v.secondarySearchField")]);
        //component.set("v.tertiaryFieldValue",oRecord[component.get("v.tertiarySearchField")]); 
    },
    
    
    selectRecord : function(component, event, helper){      
        var getSelectRecord = component.get("v.oRecord");
        var compEvent = component.getEvent("oSelectedRecordEvent");
        compEvent.setParams({
            //"recordByEvent" : getSelectRecord
            "place_id" : getSelectRecord.place_id
        });  
        compEvent.fire();
    },
})
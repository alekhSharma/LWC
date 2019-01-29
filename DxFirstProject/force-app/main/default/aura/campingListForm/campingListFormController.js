({
	clickCreateItem : function(component, event, helper) {
		var validCamping = true;
    var campingName = component.find("Name").get("v.value");
    var campingQuantity = component.find("quant").get("v.value");
    var campingPrice = component.find("price").get("v.value");
/*
    if($A.util.isEmpty(campingName)){
        validCamping = false;
        component.find("campName").set("v.errors",[{message: "Name can't be blank"}]);
    }else{
        component.find("campName").set("v.errors",null);
    }
    if($A.util.isEmpty(campingQuantity)){
        validCamping = false;
        component.find("campQuantity").set("v.errors",[{message: "Quantity can't be blank"}]);
    }else{
        component.find("campName").set("v.errors",null);
    }
    if($A.util.isEmpty(campingPrice)){
        validCamping = false;
        component.find("campPrice").set("v.errors",[{message: "Price can't be blank"}]);
    }else{
        component.find("campName").set("v.errors",null);
    }
*/
    if(validCamping){
        var newCamping = component.get("v.newItem");
        helper.createItem(component,newCamping);
    }
	}
})
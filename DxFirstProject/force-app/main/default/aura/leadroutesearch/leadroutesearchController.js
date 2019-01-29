({
    loadLeads : function(component, event, helper) {
        var load=component.get("c.getleads");//load the leads to display in the list
        load.setParams({
        });
        load.setCallback(this, function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                component.set("v.leadWrapperList", response.getReturnValue());
                component.set("v.leadWrapperList2", response.getReturnValue());
            }
            else{
                //you can put alert or toast event here if response state is unsuccessful
            }
        });
        $A.enqueueAction(load);
        
        var customLabelValue=component.get("c.CustomLabel");//load the google api key stored in custom label
        customLabelValue.setParams({
        });
        customLabelValue.setCallback(this, function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                component.set("v.customLabelValue", response.getReturnValue());
            }
            else{
                //you can put alert or toast event here if response state is unsuccessful
            }
        });
        $A.enqueueAction(customLabelValue);    
    },
    
    showOnSearch : function(component, event, helper){//method runs on pressing filter button
        var leadWrapperList2=[];
        var leadWrapperList=component.get("v.leadWrapperList");
        var nameSearch=component.get("v.nameSearch");
        var addressSearch=component.get("v.addressSearch");
        var statusSearch=component.get("v.statusSearch");
        var wordPattern=/^[a-zA-Z0-9 ]*$/;
        if(wordPattern.test(nameSearch) && wordPattern.test(addressSearch)){
            var patternname = new RegExp(nameSearch, 'i');
            var patternaddress = new RegExp(addressSearch, 'i');
            var patternstatus = new RegExp(statusSearch, 'i');
            var j,address;
            //pattern search runs inside the for loop for name, status and address entered
            for(j=0;j<leadWrapperList.length;j++){
                var ss=JSON.stringify(leadWrapperList[j].leadValue.Status);
                var ad=JSON.stringify(leadWrapperList[j].leadValue.Address);
                if(patternname.test(leadWrapperList[j].leadValue.Name) && patternstatus.test(ss) && patternaddress.test(ad)){
                    leadWrapperList2.push(leadWrapperList[j]);
                }
            }
        }
        component.set("v.leadWrapperList2",leadWrapperList2);
    },
    
    navigateToRecord : function(component, event, helper){//method runs when GoToMap is pressed
        var leadWrapperList2=component.get("v.leadWrapperList2");
     
        var leadcords=[];
        var latlng={"lat":"","lng":"","markerText":""};
        var counter=0;
        var i;
        for(i=0; i<leadWrapperList2.length; i++){
            if(leadWrapperList2[i].checked){
                counter++;
                //fetch the name and coordinates of checked leads 
                latlng={"lat":parseFloat(leadWrapperList2[i].leadValue.Latitude), 
                        "lng":parseFloat(leadWrapperList2[i].leadValue.Longitude),
                        "markerText": "This is the address of "+leadWrapperList2[i].leadValue.Name};
                leadcords.push(latlng);//array containing the name and coordinates of checked leads 
                
                if(latlng.lat){}
                else {break;}
            }
        }
        
        
        if(latlng.lat){ //navigate to the googlemap component if all leads selected have valid addresses
            var evt = $A.get("e.force:navigateToComponent");//system event 'navigateToComponent' used
            evt.setParams({
                componentDef : "c:googlemap",
                componentAttributes: {
                    mapdata : leadcords,
                    customLabelValue : component.get("v.customLabelValue")
                }
            });
            evt.fire();
            
        }
        
        else{  //if coordinates are undefined, display toastmessage
            //use toast event here
            if(counter==0){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "No records were selected",
                    "message": "Select at least one record"
                });
                toastEvent.fire();
            }
            else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Failed in retrieveing coordinates ",
                    "message": "Some or all leads selected have incomplete addresses"
                });
                toastEvent.fire();
            }
            
        }
        
    }
    
})
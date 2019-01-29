({
    handleComponentEvent : function(component, event, helper) {   
        var lcHost=window.location.hostname;
        component.set("v.lcHost", lcHost);
        
        window.addEventListener("message", function(event){//listens to the 'message' event sent from visualforce window
            if(event.data.state=='LOADED'){
                component.set("v.vfHost", event.data.vfHost);
                helper.sendToVF(component, helper);
            }
            
        }, false);
    }
})
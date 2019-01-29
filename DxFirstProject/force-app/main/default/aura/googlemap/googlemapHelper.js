({
    sendToVF : function(component, helper) {
        var message = {  //message contains the map related data to be sent to VF page
            "loadGoogleMap" : true,
            "mapData": component.get('v.mapdata'), //list of coordinates
            "mapOptions": component.get('v.mapOptions'),  //zoom information for map creation
            "customLabelValue": component.get('v.customLabelValue') //consists of the google api key
        } ;
        helper.sendMessage(component, helper, message); 
    },
    
    sendMessage : function(component, helper, message){
        message.origin=window.location.hostname;
        var message1= JSON.parse(JSON.stringify(message));
        var vfWindow= component.find("vfFrame").getElement().contentWindow;
        vfWindow.postMessage(message1, component.get("v.vfHost"));//javascript postmessage used to send data to the VF page
    }
})
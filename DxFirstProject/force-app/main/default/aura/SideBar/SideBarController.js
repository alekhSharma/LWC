({
    myAction : function(component, event, helper) {
            document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("main").style.marginLeft = "250px";
        console.log('hi');

    },
        
    myAction2 : function(component, event, helper) {
           document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft= "0";
        }
	
})
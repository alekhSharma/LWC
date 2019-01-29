({
     
    /**
     * Webkul Software.
     *
     * @category  Webkul
     * @author    Webkul
     * @copyright Copyright (c) 2010-2016 Webkul Software Private Limited (https://webkul.com)
     * @license   https://store.webkul.com/license.html
     */
 
    doinit : function(component, event, helper) {       
        component.set("v.frameSrc",'https://playful-goat-88566-dev-ed--alekhcognizant.ap5.visual.force.com/apex/mapp'); 
    },
    GetRoute: function(component, event, helper){
        var startpoint = component.find("start");
        var sp = startpoint.get("v.value");
        var endpoint = component.find("end");
        var ep = endpoint.get("v.value");
         
        var d = new Date();
        var n = d.getTime();
        component.set("v.frameSrc",'https://playful-goat-88566-dev-ed--alekhcognizant.ap5.visual.force.com/apex/mapp?t='+n+'&startpoint='+sp+'&endpoint='+ep);
    }
})
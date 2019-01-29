({
	doInit : function(component, event, helper) {
        //alert(component.get("v.ObjType"));
		var ObjType = component.get("v.ObjType");
        helper.fetchPickListVal(component, ObjType);
	},
    onPicklistChange: function(component, event, helper) {
        component.set('v.seletedListView',event.getSource().get("v.value"));
    },
    GenerateCSV: function(component, event, helper) {
        // get the value of select option
       // alert(event.getSource().get("v.value"));
       // checked Salected ListView
       var selectedLView = component.get("v.seletedListView");
        //alert(selectedLView);
       var CSVData= helper.createCSVFile(component,component.get("v.ObjType"),selectedLView);
        alert('CSVData'+CSVData);
         // using click() js function to download csv file        
    },

})
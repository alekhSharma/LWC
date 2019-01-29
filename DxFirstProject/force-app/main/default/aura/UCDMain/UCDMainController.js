({
    doInit : function(component, event, helper) {
        
        helper.getallClasses(component, event);
        
        $A.util.addClass(component.find('divReadme'), 'slds-hide');
        $A.util.addClass(component.find('divAnalytics'), 'slds-hide');
        $A.util.addClass(component.find('divEmail'), 'slds-hide');
    },
    
    // ## function call on Click on the "Download As CSV" Button. 
    downloadCsv : function(component,event,helper){
        
        // get the Records [contact] list from 'ListOfContact' attribute 
        var stockData = component.get("v.listAllMethods");
        
        // call the helper function which "return" the CSV data as a String   
        var csv = helper.convertArrayOfObjectsToCSV(component,stockData);   
        if (csv == null){return;} 
        
        // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_self'; // 
        hiddenElement.download = 'ExportData.csv';  // CSV file Name* you can change it.[only name not .csv] 
        document.body.appendChild(hiddenElement); // Required for FireFox browser
        hiddenElement.click(); // using click() js function to download csv file
    }, 
    
    shoereadme : function(component, event, helper)
    {
        component.set("v.EmailSending",false);
        helper.removeClasses(component);
        
        $A.util.addClass(component.find('divReadme'), 'slds-show');
        $A.util.addClass(component.find('divMethodTable'), 'slds-show');
        $A.util.addClass(component.find('divAnalytics'), 'slds-hide');
        $A.util.addClass(component.find('divEmail'), 'slds-hide');
        
        $A.util.addClass(component.find('liReadMe'), 'slds-is-active');
        $A.util.removeClass(component.find('liAnalytics'), 'slds-is-active');
        $A.util.removeClass(component.find('liEmail'), 'slds-is-active');
        
    },
    
    showAnalytics : function(component, event, helper)
    {
        component.set("v.EmailSending",false);
        component.set("v.asyncReqStatus",true);
        helper.removeClasses(component);
        
        $A.util.addClass(component.find('divAnalytics'), 'slds-show');
        $A.util.addClass(component.find('divMethodTable'), 'slds-hide');
        $A.util.addClass(component.find('divReadme'), 'slds-hide');
        $A.util.addClass(component.find('divEmail'), 'slds-hide');
        
        $A.util.addClass(component.find('liAnalytics'), 'slds-is-active');
        $A.util.removeClass(component.find('liReadMe'), 'slds-is-active');
        $A.util.removeClass(component.find('liEmail'), 'slds-is-active');
        // helper.createChart(component);
    },
     
    showEmail : function(component, event, helper)
    {
        component.set("v.EmailSending",true);
        helper.removeClasses(component);
        $A.util.addClass(component.find('divAnalytics'), 'slds-hide');
        $A.util.addClass(component.find('divMethodTable'), 'slds-hide');
        $A.util.addClass(component.find('divReadme'), 'slds-hide');
        $A.util.addClass(component.find('divEmail'), 'slds-show');
        
        $A.util.addClass(component.find('liEmail'), 'slds-is-active');
        $A.util.removeClass(component.find('liReadMe'), 'slds-is-active');
        $A.util.removeClass(component.find('liAnalytics'), 'slds-is-active');
        //helper.emailAttachment(component,event);
        // helper.removeClasses(component);
    },
    
    closeReadMe : function(component, event, helper)
    {
        component.set("v.EmailSending",false);
        helper.removeClasses(component);
        $A.util.addClass(component.find('divReadme'), 'slds-hide');
        $A.util.addClass(component.find('divAnalytics'), 'slds-hide');
        $A.util.addClass(component.find('divEmail'), 'slds-hide');
    }
})
({
    fetchPickListVal : function(component,ObjType) {		
        var action = component.get("c.getListViewLst");        
        action.setParams({
            "objName": ObjType
        });
        var opts = [];
        action.setCallback(this, function(response) {
            //alert(response.getState());
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue(); 
                alert(allValues);
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i].Name,
                        value: allValues[i].Id
                    });
                }
                
                component.find('accIndustry').set("v.options", opts);
            }
        });
        $A.enqueueAction(action);
    },
    createCSVFile : function(component,ObjType,listvId) {
        var createCSVaction=component.get("c.getCSVData"); 
        var redirectURL=component.get("v.redirectURL");
        createCSVaction.setParams({
            "sobjType": ObjType,
            "listViewId":listvId
        });
        createCSVaction.setCallback(this, function(response){
            if(response.getState()=="SUCCESS"){
                
                var allValues = response.getReturnValue();
                
                // declare variables
                var csvStringResult, counter, keys, columnDivider, lineDivider;       
                // check if "objectRecords" parameter is null, then return from function
                if (allValues == null || !allValues.recordList.length){
                    //alert('in');
                    
                    return null;
                }
                // store ,[comma] in columnDivider variabel for sparate CSV values and 
                // for start next line use '\n' [new line] in lineDivider varaible  
                columnDivider = ',';
                lineDivider =  '\n'; 
                // in the keys valirable store fields API Names as a key 
                // this labels use in CSV file header
                keys = allValues.headerList;
                csvStringResult = '';
                csvStringResult += keys.join(columnDivider);
                csvStringResult += lineDivider; 
                for(var i=0; i < response.getReturnValue().recordList.length; i++){   
                    counter = 0;
                    //alert(response.getReturnValue().recordList[i]);
                    csvStringResult += response.getReturnValue().recordList[i]; 
                    // inner for loop close 
                    csvStringResult += lineDivider;
                }
                if (csvStringResult == null){return;}
                // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
                var hiddenElement = document.createElement('a');
                hiddenElement.download = ObjType+(new Date()).getTime()+'.csv'; 
                hiddenElement.href = 'data:text/csv;charset=utf-8;' + encodeURI(csvStringResult);
                hiddenElement.target = '_blank'; // 
                 // CSV file Name* you can change it.[only name not .csv] 
                document.body.appendChild(hiddenElement); // Required for FireFox browser
                hiddenElement.click();
                if(confirm("Do you want export more Data?")){
                	return false;
                }else{
                    
                    window.location.href = redirectURL;
                }
            }
        });
        $A.enqueueAction(createCSVaction);
    },
})
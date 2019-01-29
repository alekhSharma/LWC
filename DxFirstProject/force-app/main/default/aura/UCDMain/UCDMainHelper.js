({
    getallClasses : function(component, event) {
        
        var action = component.get("c.getAllApexClasses");
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            //console.log("From server: " + state);
            
            if (state == "SUCCESS") {
                var responseIndex = response.getReturnValue();
                if(responseIndex.indexOf('Unauthorized endpoint') !=1 )
                {
                    var allApexClasses = JSON.parse(response.getReturnValue());
                    var arrApexClasses = [];
                    arrApexClasses = allApexClasses.records;
                    this.getAllTrigger(component);
                    if(arrApexClasses.length > 0)
                    {
                        var arrCompositeReq = [];
                        component.set("v.totalClass",arrApexClasses.length);
                        var reqCounter = 0;
                        var arrApexClassesClone = [];
                        for(var item in arrApexClasses)
                        {
                            
                            var cBody = arrApexClasses[item].Body;
                            var testflag = cBody.search(/@isTest/i);
                            var batchflag = cBody.search(/Database.Batchable/i);
                            var schflag = cBody.search(/schedulable/i);
                            
                            if(testflag == -1 && batchflag == -1 && schflag == -1)
                            {
                                arrApexClassesClone[reqCounter] =  arrApexClasses[item];
                                var apexClassItem = new Object();
                                var apexMember = new Object();
                                apexClassItem.method = 'GET';
                                apexClassItem.url = '/services/data/v41.0/tooling/sobjects/ApexClass/'+arrApexClasses[item].Id;
                                apexClassItem.referenceId = arrApexClasses[item].Id;
                                arrCompositeReq[reqCounter] = apexClassItem;
                                reqCounter++;
                            }
                            
                        }
                        arrApexClasses = arrApexClassesClone;
                        component.set("v.listApexClasses",arrApexClasses);
                        
                        if(arrCompositeReq.length <= 25)
                        {
                            this.getAllMethods(component,JSON.stringify(arrCompositeReq));
                        }
                        else
                        {
                            var arrCompositeReqClone = [];
                            var itemCounter = 0;
                            
                            for(var item in arrCompositeReq)
                            {
                                if(itemCounter < 25)
                                {
                                    arrCompositeReqClone[itemCounter] = arrCompositeReq[item];
                                }
                                else
                                {
                                    if(arrCompositeReqClone[0]==null)
                                        arrCompositeReqClone.splice(0,1);
                                    
                                    this.getAllMethods(component,JSON.stringify(arrCompositeReqClone));
                                    arrCompositeReqClone.length = 0;
                                    itemCounter = 0;
                                }
                                
                                if(item == (arrCompositeReq.length - 1) && itemCounter > 0)
                                {
                                    if(arrCompositeReqClone[0]==null)
                                        arrCompositeReqClone.splice(0,1);
                                    this.getAllMethods(component,JSON.stringify(arrCompositeReqClone));
                                    itemCounter = 0;
                                } 
                                itemCounter++;
                            } 
                        }
                    }
                    else
                    {
                        this.overlaystatus(component,'Completed');
                    }
                }
                else
                {
                    var unauthorizedendpoint = response.getReturnValue();
                    unauthorizedendpoint = unauthorizedendpoint.replace("Unauthorized endpoint","::");
                    unauthorizedendpoint = 'Service Unavailable :: Please set endpoint before use ' + unauthorizedendpoint;
                    this.navigateToMyComponent(component, event, unauthorizedendpoint);
                }
            }
        });
        $A.enqueueAction(action);
    },
    navigateToMyComponent : function(component, event, unauthorizedendpoint) {
        
        $A.createComponent(
            "c:UCD_ErrorPage",
            {
                "aura:id": "findableAuraId",
                "unauthorizedendpoint":unauthorizedendpoint
            },
            function(msgcmp, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(msgcmp);
                    component.set("v.body", body);
                    $A.util.addClass(component.find('divUCD'), 'slds-hide'); 
                    //  this.overlaystatus(component,'Completed');
                    $A.util.addClass(component.find('overlay'), 'slds-hide');  
                } 
            }
        );
        
    },
    
    getAllTrigger:function(component)
    {
        var action = component.get("c.getTriggerMethods");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            //console.log("From serverAllTrigger::: " + state);
            if (state == "SUCCESS") {
                
                var allApexTriggers = response.getReturnValue();
                var arrApexTriggers = [];
                arrApexTriggers = allApexTriggers.records;
                if(arrApexTriggers != 'undefined' && arrApexTriggers != null && arrApexTriggers != '')
                {
                    component.set("v.totalTriggers",arrApexTriggers.length);
                }
                this.createContainer(component,arrApexTriggers);
            }
        });
        $A.enqueueAction(action);      
    },
    
    createContainer:function(component,arrApexTriggers)
    {
        var arrApexClasses = component.get("v.listApexClasses"); 
        var action = component.get("c.createContainer");
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            //console.log("From serverContainer::: " + state);
            if (state == "SUCCESS") {
                component.set("v.containerId",response.getReturnValue());
                component.set("v.stage",'Creating Container');
                if(arrApexTriggers != 'undefined' && arrApexTriggers != null && arrApexTriggers != '')
                {
                    var arrApexTrigMembersCompositeReq = [];
                    for(var item in arrApexTriggers)
                    {
                        var apexTrigMember = new Object();
                        apexTrigMember.method = 'POST';
                        apexTrigMember.url = '/services/data/v41.0/tooling/sobjects/ApexTriggerMember';//+arrApexClasses[item].Id;
                        apexTrigMember.referenceId = arrApexTriggers[item].Id;
                        var memberObj = new Object();
                        memberObj.contentEntityId = arrApexTriggers[item].Id;
                        memberObj.metadataContainerId = component.get("v.containerId");
                        memberObj.body = arrApexTriggers[item].Body;
                        apexTrigMember.body = memberObj;
                        arrApexTrigMembersCompositeReq[item] = apexTrigMember;
                    }
                    
                    if(arrApexTrigMembersCompositeReq.length <= 25)
                    {
                        this.createApexTriggerMembers(component,JSON.stringify(arrApexTrigMembersCompositeReq));
                    }
                    else
                    {
                        var arrApexTrigMembersClone = [];
                        var itemCounter = 0;
                        
                        for(var item in arrApexTrigMembersCompositeReq)
                        {
                            if(itemCounter < 25)
                            {
                                arrApexTrigMembersClone[itemCounter] = arrApexTrigMembersCompositeReq[item];
                            }
                            else
                            {                            
                                if(arrApexTrigMembersClone[0]==null)
                                    arrApexTrigMembersClone.splice(0,1);
                                this.createApexTriggerMembers(component,JSON.stringify(arrApexTrigMembersClone));
                                arrApexTrigMembersClone.length = 0;
                                itemCounter = 0;
                            }
                            
                            if(item == (arrApexTrigMembersCompositeReq.length - 1) && itemCounter > 0)
                            {
                                if(arrApexTrigMembersClone[0]==null)
                                    arrApexTrigMembersClone.splice(0,1);
                                this.createApexTriggerMembers(component,JSON.stringify(arrApexTrigMembersClone));
                                itemCounter = 0;
                                
                            }
                            itemCounter++;
                        }
                    }
                }
                
                var arrApexMembersCompositeReq = [];
                
                for(var item in arrApexClasses)
                {
                    var apexMember = new Object();
                    apexMember.method = 'POST';
                    apexMember.url = '/services/data/v41.0/tooling/sobjects/ApexClassMember';//+arrApexClasses[item].Id;
                    apexMember.referenceId = arrApexClasses[item].Id;
                    var memberObj = new Object();
                    memberObj.contentEntityId = arrApexClasses[item].Id;
                    memberObj.metadataContainerId = component.get("v.containerId");
                    memberObj.body = arrApexClasses[item].Body;
                    apexMember.body = memberObj;
                    arrApexMembersCompositeReq[item] = apexMember;
                }
                if(arrApexMembersCompositeReq.length <= 25)
                {
                    this.createApexMembers(component,JSON.stringify(arrApexMembersCompositeReq));
                    component.set("v.callAsyncRequest",true);
                }
                else
                {
                    var arrApexMembersClone = [];
                    var itemCounter = 0;
                    
                    for(var item in arrApexMembersCompositeReq)
                    {
                        if(itemCounter < 25)
                        {
                            arrApexMembersClone[itemCounter] = arrApexMembersCompositeReq[item];
                        }
                        else
                        {                            
                            if(arrApexMembersClone[0]==null)
                                arrApexMembersClone.splice(0,1);
                            this.createApexMembers(component,JSON.stringify(arrApexMembersClone));
                            arrApexMembersClone.length = 0;
                            itemCounter = 0;
                        }
                        
                        if(item == (arrApexMembersCompositeReq.length - 1) && itemCounter > 0)
                        {
                            
                            if(arrApexMembersClone[0]==null)
                                arrApexMembersClone.splice(0,1);
                            this.createApexMembers(component,JSON.stringify(arrApexMembersClone));
                            itemCounter = 0;
                            
                        }
                        if(item == (arrApexMembersCompositeReq.length - 1))
                        {
                            component.set("v.callAsyncRequest",true);
                        }
                        
                        itemCounter++;
                    }
                }
                
            }
        });
        $A.enqueueAction(action);
        
    },
    
    getAllMethods:function(component,jsonString)
    {
        var action = component.get("c.getAllMethods");
        action.setParams({ jsonString : jsonString });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            ("From serverAllMethods::: " + state);
            if (state == "SUCCESS") 
            {
                component.set("v.stage",'Fetching Methods');
                var arrAllMethods = []; 
                var listMethod = component.get("v.listAllMethods");
                var counter = component.get("v.methodCounter");
                
                arrAllMethods = response.getReturnValue();
                if(arrAllMethods != 'undefined' && arrAllMethods != '' && arrAllMethods != null)
                {
                    if(arrAllMethods.compositeResponse != 'undefined' && arrAllMethods.compositeResponse != '' && arrAllMethods.compositeResponse != null)
                    {
                        for(var item in arrAllMethods.compositeResponse)
                        {
                            var body = arrAllMethods.compositeResponse[item].body;
                            if(body != 'undefined' && body != '' && body != null)
                            {
                                var symbolTable = body.SymbolTable;
                                if(symbolTable != 'undefined' && symbolTable != '' && symbolTable != null)
                                {
                                    var methods = symbolTable.methods;
                                    if(methods != 'undefined' && methods != '' && methods != null)
                                    {
                                        for(var item in methods)
                                        {
                                            var objItem = new Object();
                                            objItem.uniqueId = counter;
                                            objItem.classId = body.Id;
                                            objItem.className = body.Name;
                                            objItem.key = body.Name+'_'+methods[item].name;
                                            objItem.classBody = body.Body;
                                            objItem.methodName = methods[item].name;
                                            objItem.locationLineNo = methods[item].location.line;
                                            objItem.isUsed = false;
                                            listMethod.push(objItem);
                                            counter++;
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                        component.set("v.listAllMethods",listMethod);
                        component.set("v.methodCounter",counter);
                    }
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    createApexMembers:function(component,arrApexMembers)
    {
        var action = component.get("c.createApexClassMembers");
        action.setParams({ jsonString : arrApexMembers });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            //console.log("From serverApexMembers::: " + state);
            if (state == "SUCCESS") {
                //component.set("v.stage",' Creating Class Members ');
                if(component.get("v.callAsyncRequest")==true)
                {
                    this.createContainerAsyncRequest(component);
                    component.set("v.callAsyncRequest",false);
                }
                
            }
        });
        $A.enqueueAction(action);
        
    },
    
    createApexTriggerMembers:function(component,arrApexTrigMembersClone)
    {
        var action = component.get("c.createApexTriggerMembers");
        action.setParams({ jsonString : arrApexTrigMembersClone });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            //console.log("From serverTriggerMembers::: " + state);
            if (state == "SUCCESS") {
                
            }
        });
        $A.enqueueAction(action);
        
    },
    
    createContainerAsyncRequest:function(component)
    {
        var action = component.get("c.createContainerAsyncRequest");
        action.setParams({ containerId : component.get("v.containerId") });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            //console.log("From serverAsyncRequest::: " + state);
            if (state == "SUCCESS") {
                this.createContainerAsyncRequestStatus(component,response.getReturnValue());
            }
        });
        $A.enqueueAction(action);      
    },
    
    createContainerAsyncRequestStatus:function(component,asyncRequestId)
    {
        var action = component.get("c.createContainerAsyncRequestStatus");
        action.setParams({ asyncRequestId : asyncRequestId });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            //console.log("From serverRequestStatus::: " + state);
            if (state == "SUCCESS") {
                var res = JSON.parse(response.getReturnValue());
                var reqState = res.State;
                //console.log('reqState::'+reqState);
                component.set("v.stage",'Stage::'+reqState);
                if(reqState=='Queued')
                {
                    this.createContainerAsyncRequestStatus(component,asyncRequestId);
                }
                else if(reqState=='Completed')
                {
                    this.getSymbolTable(component,asyncRequestId);
                }
                    else
                    {
                        var res = JSON.parse(response.getReturnValue());
                        var DeployDetails = res.DeployDetails;
                        if(DeployDetails != 'undefined' && DeployDetails != null && DeployDetails != '')
                        {
                            var componentFailures = DeployDetails.componentFailures;
                            if(componentFailures != 'undefined' && componentFailures != null && componentFailures != '')
                            {
                                if(componentFailures.length > 0)
                                { 
                                    var error = '';
                                    for(var item in componentFailures)
                                    {
                                        
                                        if(error != '')
                                            error = error+'; '+componentFailures[item].problemType+':: Class ::'+componentFailures[item].fullName+'::'+componentFailures[item].problem;
                                        else
                                            error = componentFailures[item].problemType+':: Class ::'+componentFailures[item].fullName+'::'+componentFailures[item].problem;
                                    }
                                    component.set("v.unauthorizedendpoint",'');
                                    this.navigateToMyComponent(component,event,error);
                                }
                            }
                            
                        }
                        $A.util.addClass(component.find('overlay'), 'slds-hide');
                    }
            }
        });
        $A.enqueueAction(action);      
    },
    
    getSymbolTable:function(component,asyncRequestId)
    {
        var arrsymbolTableRecords = [];
        var action = component.get("c.getSymbolTable");
        action.setParams({ asyncRequestId : asyncRequestId });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            //console.log("From serverSymbolTable::: " + state);
            if (state == "SUCCESS") {
                var recordsSymbolTable = response.getReturnValue();
                if(recordsSymbolTable.records != 'undefined' && recordsSymbolTable.records != '' && recordsSymbolTable.records != null)
                {
                    arrsymbolTableRecords = recordsSymbolTable.records;
                }
                this.getTrigSymbolTable(component,asyncRequestId,arrsymbolTableRecords);
            }
        });
        $A.enqueueAction(action);
    },
    
    getTrigSymbolTable:function(component,asyncRequestId,arrsymbolTableRecords)
    {
        var action = component.get("c.getTriggerSymbolTable");
        action.setParams({ asyncRequestId : asyncRequestId });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            //console.log("From serverSymbolTableTrig::: " + state);
            if (state == "SUCCESS") {
                 component.set("v.stage",'Checking Used Methods');
                var recordsTrigSymbolTable = response.getReturnValue();
                if(recordsTrigSymbolTable.records != 'undefined' && recordsTrigSymbolTable.records != null && recordsTrigSymbolTable.records != '')
                {
                    if(recordsTrigSymbolTable.records.length > 0)
                    {
                        for(var item in recordsTrigSymbolTable.records)
                        { 
                            arrsymbolTableRecords.push(recordsTrigSymbolTable.records[item]);    
                        }
                    }
                }
                // alert(1);
                this.compairRecords(component,arrsymbolTableRecords);
            }
        });
        $A.enqueueAction(action);
    },
    
    compairRecords:function(component,arrsymbolTableRecords)
    {    // alert(2);   				
        var arrListMethods = [];
        var keyName = '';
        var arrRecords = arrsymbolTableRecords;//component.get("v.symbolTableRecords");
        if(arrRecords.length > 0)
        {
            for(var item in arrRecords)
            {
                if(arrRecords[item].SymbolTable != 'undefined' && arrRecords[item].SymbolTable != null && arrRecords[item].SymbolTable != '')
                {
                    var symbolTable = arrRecords[item].SymbolTable;
                    if(symbolTable != 'undefined' && symbolTable != '' && symbolTable != null)
                    {
                        var externalReferences = symbolTable.externalReferences;
                        if(externalReferences != 'undefined' && externalReferences != null && externalReferences != '')
                        {
                            for(var i in externalReferences)
                            {
                                if(externalReferences[i].methods != 'undefined' && externalReferences[i].methods != '')
                                {
                                    var className = externalReferences[i].name;
                                    var methods = externalReferences[i].methods;
                                    for(var b in methods)
                                    {
                                        // var key = new Object();
                                        keyName = className+'_'+ methods[b].name;
                                        arrListMethods.push(keyName);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // alert(3);
        }
        
        if(arrListMethods.length > 0)
        {
            var arrListMethodsUsed = component.get("v.listAllMethods");
            if(arrListMethodsUsed.length > 0)
            {
                // alert(4);
                
                for(var searchItem in arrListMethodsUsed)
                {
                    ////console.log(arrListMethods.indexOf(arrListMethodsUsed[searchItem].key));
                    if(arrListMethods.indexOf(arrListMethodsUsed[searchItem].key) >= 0)
                    {
                        arrListMethodsUsed[searchItem].isUsed = true;
                    }
                    
                    if(arrListMethodsUsed[searchItem].isUsed == false)
                    {
                        var inputBody = arrListMethodsUsed[searchItem].classBody;
                        var mName = arrListMethodsUsed[searchItem].methodName;
                        var count = inputBody.match(new RegExp(mName, 'g')).length;
                        if(count > 1)
                        {
                            arrListMethodsUsed[searchItem].isUsed = true; 
                        }
                    }
                }
                
                //  alert(5);
                var arrListMethodsUsedClone = [];
                var counterOrder = 0;
                var sNo =1;
                for(var item in arrListMethodsUsed)
                {
                    if(arrListMethodsUsed[item].isUsed)
                    {
                        arrListMethodsUsedClone[counterOrder] = arrListMethodsUsed[item];
                        arrListMethodsUsedClone[counterOrder].uniqueId = sNo;
                        sNo++;
                        counterOrder++;
                    }  
                }
                
                for(var item in arrListMethodsUsed)
                {
                    if(arrListMethodsUsed[item].isUsed == false)
                    {
                        arrListMethodsUsedClone[counterOrder] = arrListMethodsUsed[item];
                        arrListMethodsUsedClone[counterOrder].uniqueId = sNo;
                        sNo++;
                        counterOrder++;
                    }  
                } 
                
                //console.log(arrListMethodsUsed.length);
                //console.log(arrListMethodsUsedClone.length);
                arrListMethodsUsed = arrListMethodsUsedClone;
                //  alert(6);
                component.set("v.listAllMethods",arrListMethodsUsed); // // update all methods either used or not.
                component.set("v.stage",'');
                //  alert(7);
            }
        }
        this.overlaystatus(component,'Completed');
        this.emailAttachment(component,event);
    },
    
    overlaystatus:function(component,state){
        if(state == 'Completed')
        {
            $A.util.addClass(component.find('overlay'), 'slds-hide');  
        }
    },
    
    // Export Excel 
    convertArrayOfObjectsToCSV : function(component,objectRecords){
        // declare variables
        var csvStringResult, counter, keys, columnDivider, lineDivider;
        
        // check if "objectRecords" parameter is null, then return from function
        if (objectRecords == null || !objectRecords.length) {
            return null;
        }
        // store ,[comma] in columnDivider variabel for sparate CSV values and 
        // for start next line use '\n' [new line] in lineDivider varaible  
        columnDivider = ',';
        lineDivider =  '\n';
        
        // in the keys valirable store fields API Names as a key 
        // this labels use in CSV file header  
        keys = ['SR NO.','KEY','#LINE NO','CLASS','USED' ];
        
        csvStringResult = '';
        csvStringResult += keys.join(columnDivider);
        csvStringResult += lineDivider;
        
        for(var i=0; i < objectRecords.length; i++){   
            counter = 0;
            
            for(var sTempkey in keys) {
                var skey = keys[sTempkey] ;  
                
                // add , [comma] after every String value,. [except first]
                if(counter > 0){ 
                    csvStringResult += columnDivider; 
                }   
                var recordKey = '';
                
                switch(skey) {
                    case 'SR NO.':
                        recordKey = 'uniqueId'
                        break;
                    case 'KEY':
                        recordKey = 'key'
                        break;
                    case '#LINE NO':
                        recordKey = 'locationLineNo'
                        break;
                    case 'CLASS':
                        recordKey = 'className'
                        break;
                    case 'USED':
                        recordKey = 'isUsed'
                        break;
                }
                
                csvStringResult += '"'+ objectRecords[i][recordKey]+'"'; 
                
                counter++;
                
            } // inner for loop close 
            csvStringResult += lineDivider;
        }// outer main for loop close 
        
        // return the CSV formate String 
        return csvStringResult;        
    },
    
    removeClasses : function(component)
    {
        $A.util.removeClass(component.find('divReadme'), 'slds-hide');
        $A.util.removeClass(component.find('divAnalytics'), 'slds-hide');
        $A.util.removeClass(component.find('divEmail'), 'slds-hide');
        $A.util.removeClass(component.find('divMethodTable'), 'slds-hide');
        $A.util.removeClass(component.find('divReadme'), 'slds-show');
        $A.util.removeClass(component.find('divAnalytics'), 'slds-show');
        $A.util.removeClass(component.find('divEmail'), 'slds-show');      
        $A.util.removeClass(component.find('divMethodTable'), 'slds-show');
        
    },
    // ## function call on Click on the "Download As CSV" Button. 
    emailAttachment : function(component,event){ 
        // get the Records [contact] list from 'ListOfContact' attribute 
        var stockData = component.get("v.listAllMethods");
        // call the helper function which "return" the CSV data as a String   
        var csv = this.convertArrayOfObjectsToCSV(component,stockData);   
        if (csv == null){return;} 
        // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_self'; // 
        hiddenElement.download = 'ExportData.csv';  // CSV file Name* you can change it.[only name not .csv] 
        document.body.appendChild(hiddenElement); // Required for FireFox browser
        component.set("v.attachment",csv);
    }
    
    
})
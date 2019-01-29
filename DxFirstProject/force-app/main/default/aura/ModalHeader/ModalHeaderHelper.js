({
    createPi : function(component, event, helper) {
        var progressStepsVar = component.get('v.progressSteps');
        //Create steps data
        var stepsData = [], stepRec;
        progressStepsVar.forEach(function(stepRecord){
            stepRec = new Object
            stepRec.label=stepRecord;
            stepRec.value=stepRecord;
            stepsData.push(stepRec);
        });
        
        //Bind the reference for current step
        var csr = component.getReference('v.currentStep');
        
        //Create progress indicator
        var stepsPreComponents = [[
            "lightning:progressIndicator",
            {
                "currentStep" : csr // reference to the attribute
            }
        ]];
        
        // Add the steps
        for (var index in stepsData) {
            var step = stepsData[index];
            stepsPreComponents.push([
                "lightning:progressStep",
                {
                    "label":step.label,
                    "value":step.value
                }
            ]);
        }
        
        $A.createComponents(
            stepsPreComponents,
            function(components, status, errorMessage){
                if (status === "SUCCESS") {
                    // Remove the father
                    var progressIndicator = components.shift();
                    // Add the rest to the father
                    progressIndicator.set('v.body',components);
                    // Assign it to the view Attribute
                    component.set('v.progressIndicator',progressIndicator);
                } else {
                    alert('Error');
                }
            }
        );
    }
})
({
    generateChart : function(component, event, helper) {
        var totalClassCount = component.get("v.totalClassCount");
        var totalTriggersCount = component.get("v.totalTriggersCount");
        var listAllMethodsChart = component.get("v.listAllMethodsChart");
        var usedMethodPerc = 0;
        var unusedMethodPerc = 0;
        if(listAllMethodsChart != null && listAllMethodsChart != 'undefined' && listAllMethodsChart != '')
        {
            if(listAllMethodsChart.length > 0)
            {
                var usedMethodCounter = 0;
                var unusedMethodCounter = 0;
                for(var item  in listAllMethodsChart)
                {
                    if(listAllMethodsChart[item].isUsed)
                        usedMethodCounter++;
                    else
                        unusedMethodCounter++;
                }
                
                usedMethodPerc = ((usedMethodCounter*100)/listAllMethodsChart.length).toFixed(2);
                unusedMethodPerc = ((unusedMethodCounter*100)/listAllMethodsChart.length).toFixed(2);
                
                var totalApex = totalClassCount + totalTriggersCount;
                if(totalApex != 0)
                {
                    totalClassCount = ((totalClassCount*100)/totalApex).toFixed(2);
                    totalTriggersCount = ((totalTriggersCount*100)/totalApex).toFixed(2);
                }
                else
                {
                    totalClassCount = totalTriggersCount = 0;
                }
                
            }
        }
        
        var chartdata = {
            labels: ['Apex Classes %','Total Apex Classes %'],
            datasets: [
                {
                    label:'Org Info',
                    data: [totalClassCount, totalTriggersCount],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)'
                    ],
                    borderWidth: 1,
                    // borderColor:'rgba(62, 159, 222, 1)',
                    fill: false,
                    pointBackgroundColor: "#FFFFFF",
                    pointBorderWidth: 4,
                    pointHoverRadius: 5,
                    pointRadius: 3,
                    bezierCurve: true,
                    pointHitRadius: 10
                }
            ]
        }
        //Get the context of the canvas element we want to select
        var ctx = component.find("piechartOrgInfo").getElement();
        // alert(ctx);
        var piechart = new Chart(ctx ,{
            type: 'pie',
            data: chartdata,
            options: {
                legend: {
                    position: 'bottom',
                    padding: 10,
                },
                responsive: true
            }
        });
        
        // Used/Unused method details
        
        var chartdataMethodDetails = {
            labels: ['Used Method %','Unused Method %'],
            datasets: [
                {
                    label:'Used/Unused method details',
                    data: [usedMethodPerc, unusedMethodPerc],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)'
                    ],
                    borderWidth: 1,
                    // borderColor:'rgba(62, 159, 222, 1)',
                    fill: false,
                    pointBackgroundColor: "#FFFFFF",
                    pointBorderWidth: 4,
                    pointHoverRadius: 5,
                    pointRadius: 3,
                    bezierCurve: true,
                    pointHitRadius: 10
                }
            ]
        }
        
        
        //Get the context of the canvas element we want to select
        var MethodDetails = component.find("piechartMethodDetails").getElement();
        // alert(ctx);
        var piechartMethodDetails = new Chart(MethodDetails ,{
            type: 'pie',
            data: chartdataMethodDetails,
            options: {
                legend: {
                    position: 'bottom',
                    padding: 10,
                },
                responsive: true
            }
        });
    }
})
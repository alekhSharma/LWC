({
    ParentMethodCall : function(component, event, helper) {
        component.set('v.parentVar', 'Called from Parent');
        console.log('inside the method');
    },

    LwcEvent : function(component, event, helper){
        component.set('v.lwcEvent','Called from parent');
    },

    onparentAura : function(component, event, helper){
        console.log(event);
        component.set('v.AuraEvent',event.getParam('message'));
    },

    apimethod : function(component, event, helper){
        component.find('ChildComponent').apimethod('called from parent');
    }

})

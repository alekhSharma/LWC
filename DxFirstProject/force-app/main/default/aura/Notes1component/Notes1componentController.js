({
	clickCreate : function(component, event, helper) {
        
		var newNote = component.get("v.newNote");
        helper.createNote(component, newNote);
	}
})
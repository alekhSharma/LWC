({
	createNote : function(component, note) {
       var theNote = component.get("v.newNotes");
        
        theNote.push(note);

		component.set("v.newNotes",theNote);        
	}
})
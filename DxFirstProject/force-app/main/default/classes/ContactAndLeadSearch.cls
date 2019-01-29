public class ContactAndLeadSearch {
    public static list<list<SObject>> searchContactsAndLeads(String search_text){
        list<list<SObject>> result_list = new list<list<SObject>>();
        result_list = [FIND 'Smith' IN ALL FIELDS RETURNING Contact,Lead];    
	        
        return result_list;
    }
}
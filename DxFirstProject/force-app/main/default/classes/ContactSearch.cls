public class ContactSearch {
    public static list<contact> searchForContacts(String last_name,string mailing_code){
        list<contact> c = new list<contact>();
        c = [SELECT Id, name from contact where LastName =: last_name AND MailingPostalCode =: mailing_code];   
        return c;
    }
}
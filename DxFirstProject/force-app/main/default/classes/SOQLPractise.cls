public class SOQLPractise {

    public static contact use_related_contact_from_account(Id account_Id){
        contact c = new contact();
        list<account> account_list = [SELECT Id, (SELECT name from contacts) from account where Id =:account_Id];
        system.debug(account_list);
        c = account_list[0].contacts[0];
        system.debug(c);
        return c;
    }
    
    public static account use_contact_to_find_account(Id contact_Id){
        account a = new account();
        list<contact> contact_list = [SELECT Id, carol.Account.Name from contact carol];
        system.debug(contact_list);
        return a;
    }
    
}
public class AccountHandler {
    public static account insertNewAccount(String account_name){
        Account a = new account();
        a.name = account_name;
        try{
            insert a;
            return a;
        }
        catch(DMLException e){
            return null;
        }
        
    }
}
trigger AccountAddressTrigger on Account (before insert, before update) 
{
    
    list<account> account_list = new list<account>();
        if(Trigger.isInsert || Trigger.isUpdate)
        {
        
            for(account a : trigger.new)
            {
                    if(a.Match_Billing_Address__c == true && a.BillingPostalCode != NULL)
                    {
                        a.ShippingPostalCode = a.BillingPostalCode;
                        account_list.add(a);
                    }
    		}	

        }
}
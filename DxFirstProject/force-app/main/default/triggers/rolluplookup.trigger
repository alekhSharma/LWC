trigger rolluplookup on alekhcognizant__child__c (after insert,after update, after delete) {
    
    set<id> parentid = new set<id>();
    list<parent__c> childid = new list<parent__c>();
    
    for(child__c newItem : trigger.new){
        parentid.add(newItem.parent__c);
        system.debug(childid);
    }
        
    if(trigger.isUpdate||trigger.isDelete){
        for(child__c olditem : trigger.old){
            parentid.add(olditem.parent__c);
        }
    }    
    
    map<id, parent__c> parentmap = new Map<id, parent__c>([select id, sum__c from parent__c where Id IN :parentid]);
    
    for(parent__c parent : [select Id, name, sum__c, (select id from children__r) from parent__c where id IN :parentid ]){
                parentmap.get(parent.id).sum__c = parent.children__r.size();
        		
        for(integer i =0;i<parent.children__r.size();i++){
            //parentmap.get(parent.id).sum__c = parentmap.get(parent.id).sum__c + parent.children__r[i];
        }
        
        
        		childid.add(parentmap.get(parent.id));
    }
    
    update childid;
}
import { LightningElement, track,api } from 'lwc';

export default class AuraLWCExample extends LightningElement {

    @track parentVar;
    @api eventVar;

    @api apimethod(message){
        console.log(message);
    }

    ParentMethodCall(){
        this.parentVar = 'Inside the Parent Method';
    }
    
    AuraEvent(){
        this.dispatchEvent(new CustomEvent('parentAura',{  detail: { message: 'Called form child'} }));
    }

}
import { LightningElement, track,api } from 'lwc';

export default class EventExampleChild extends LightningElement {

    @track childVar;
    @api fromParent;

    ChildMethodCall(){
        this.childVar = 'Method Called';
    }

    ParentEvent(){
        this.dispatchEvent(new CustomEvent('parent'));
    }

}
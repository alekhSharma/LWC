import { LightningElement, track,api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

export default class CounterExampleChild extends LightningElement {

    @wire(CurrentPageReference) pageRef;

    @track childVar=0;
    @api fromParent=0;
    @track parentCounter=0;
    @track DomVariable;

    ChildMethodCall(){
        this.childVar++;
    }

    ParentEvent(){
        this.parentCounter++;
        this.dispatchEvent(new CustomEvent('parent', { detail: this.parentCounter }));
    }

    connectedCallback(){
        registerListener('eventExample', this.handleSearchKeyChange, this);
    }

    handleSearchKeyChange(response){
        this.DomVariable = response;
    }

    disconnectedCallback() {
        // unsubscribe from searchKeyChange event
        unregisterAllListeners(this);
    }




}
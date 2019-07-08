import { LightningElement, track, wire} from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

export default class CounterExample extends LightningElement {

    @wire(CurrentPageReference) pageRef;

    @track parentVar=0;
    @track childVar=0;
    @track childEvent=0;
    @track domVariable;
    ParentMethodCall(){
        this.parentVar++;
    }

    ChildEvent(){
        this.childVar++;
    }

    EventDataCall(event){
        this.childEvent = event.detail;
    }

    connectedCallback() {
        // subscribe to searchKeyChange event
        registerListener('eventExample', this.handleSearchKeyChange, this);
    }

    handleSearchKeyChange(domVariable){
        this.domVariable = domVariable;
    }

    disconnectedCallback() {
        // unsubscribe from searchKeyChange event
        unregisterAllListeners(this);
    }


}
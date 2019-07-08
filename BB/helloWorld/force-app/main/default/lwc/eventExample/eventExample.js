import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';

export default class EventExample extends LightningElement {

    @track parentVar;
    @track childVar;
    @track childEvent;
    @track domVar;
    @wire(CurrentPageReference) pageRef;

    ParentMethodCall(){
        this.parentVar = 'Method Called';
    }

    ChildEvent(){
        this.childVar = 'Method Called From Parent';
    }

    EventDataCall(){
        this.childEvent = 'Method Called From Child';
    }

    DomEvent(){
        this.domVar = 'Dom Method Called';
        fireEvent(this.pageRef, 'eventExample', this.domVar );
    }

}
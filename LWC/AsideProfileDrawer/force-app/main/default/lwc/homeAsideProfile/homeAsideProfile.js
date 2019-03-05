import { LightningElement, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import userId from '@salesforce/user/Id';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ['Account.Name', 'Account.Picture__c'];

export default class HomeAsideProfile extends LightningElement {

    @track name;
    @track image;
    @track account;
    loggedInUserId = userId;

    @wire(getRecord, {recordId : '001p000000hNMkSAAW', fields: FIELDS})
    wiredRecord({ error, data }) {
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading contact',
                    message,
                    variant: 'error',
                }),
            );
        } else if (data) {
            this.account = data;
            this.name = this.account.fields.Name.value;
            this.image = this.account.fields.Picture__c.value;
        }
    }

}
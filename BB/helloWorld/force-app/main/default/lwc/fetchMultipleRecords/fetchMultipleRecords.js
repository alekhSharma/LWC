import { LightningElement, wire, track } from 'lwc';
import getAccountList from '@salesforce/apex/FetchMultipleRecords.search';

export default class FetchMultipleRecords extends LightningElement {
    @track accounts;
    @track error;

    @wire(getAccountList)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
            console.log(this.accounts);
        } else if (error) {
            this.error = error;
            this.accounts = undefined;
        }
    }

}
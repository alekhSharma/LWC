import { LightningElement, track,api } from 'lwc';
import apexSearch from '@salesforce/apex/googleTypeAheadClass.fetchLookUpValues';
import fetchAddress from '@salesforce/apex/googleTypeAheadClass.fetchAddress';
import { updateRecord, RecordFieldDataType } from 'lightning/uiRecordApi';
import {ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class GoogleTypeAheadComponent extends LightningElement {
    
    @api recordId;

    @track street='';
    @track city='';
    @track state='';
    @track postalCode='';
    @track country='';

    handleSearch(event) {
        apexSearch(event.detail)
            .then(results => {
                console.log('inside the handleSearch');
                console.log(results);
                this.template.querySelector('c-google-type-ahead').setSearchResults(results);
            })
            .catch(error => {
                // TODO: handle error
            });
    }

    handleSelectionChange(event){
        if(event.detail!=''){
            let contactId = event.detail.newSelection[0].place_id;
            console.log(contactId);
            if(contactId!='undefined'&& contactId!=''){
                fetchAddress({
                    place_id: contactId
                })
                .then((results) => {
                    console.log(results);
                    this.street         = results.street;
                    this.state          = results.state;
                    this.city           = results.city;
                    this.postalCode     = results.postal_code;
                    this.country        = results.country;
                })
                .catch((error) => {
                    this.message = 'Error received: code' + error.errorCode + ', ' +
                        'message ' + error.body.message;
                });
            }
        }else{
            this.street         = '';
            this.state          = '';
            this.city           = '';
            this.postalCode     = '';
            this.country        = '';
        }
    }

    saveAddress(){
        console.log(this.recordId);
        let record = {
            fields : {
                Id              : this.recordId,
                BillingStreet   : this.street,
                BillingCity     : this.city,
                BillingState    : this.state,
                BillingCountry  : this.country,
                BillingPostalCode: this.postalCode
            }
        }
        updateRecord(record)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record Is Updated',
                    variant: 'sucess',
                }),
            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error on data save',
                    message: error.message.body,
                    variant: 'error',
                }),
            );
        });
    }
}
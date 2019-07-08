import { LightningElement, track } from 'lwc';
import apexSearch from '@salesforce/apex/googleTypeAheadClass.fetchLookUpValues';
import fetchAddress from '@salesforce/apex/googleTypeAheadClass.fetchAddress';

export default class HelpTextBox extends LightningElement {

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
}
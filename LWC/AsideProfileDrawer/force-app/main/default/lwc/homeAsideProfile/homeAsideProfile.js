import { LightningElement, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import userId from '@salesforce/user/Id';
import { getRecord } from 'lightning/uiRecordApi';
import getContactInfo from '@salesforce/apex/contactInfoController.getContactList';

const FIELDS = ['Account.Name'];

export default class HomeAsideProfile extends LightningElement {

    @track name;
    @track image;
    @track account;
    @track contact ;
    recordId = '001N000001QLVTAIA5';
    loggedInUserId = userId;   

    @wire(getRecord, {recordId : '$recordId', fields: FIELDS})
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
            console.log(data);
            this.name = this.account.fields.Name.value;
            console.log('hi');
            this.image = '/sfsites/c/resource/1551859144000/ImagePicture' ;
        }
    }

    @wire(getContactInfo, { accID : '$recordId' })
    wiredContactRecord({ data}){
        if(data){
            this.contact = data;
            console.log(data);
        }
    }

} 
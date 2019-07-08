import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ToastMessage extends LightningElement {
    
    showSuccessToast() {
        const event = new ShowToastEvent({
            title: 'Success Message',
            variant : 'Success', 
            message : 'Your account has been updated successfully.'
        });
        this.dispatchEvent(event);
    }
    showWarningToast() {
        const event = new ShowToastEvent({
            title: 'Success Message',
            variant : 'Warning', 
            message : 'Can’t share file “report-q3.pdf” with the selected users.'
        });
        this.dispatchEvent(event);
    }
    showErrorToast() {
        const event = new ShowToastEvent({
            title: 'Success Message',
            variant : 'Error', 
            message : 'Can’t save lead “Sally Wong” because another lead has the same name.'
        });
        this.dispatchEvent(event);
    }    

}
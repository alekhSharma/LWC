import { LightningElement, track } from 'lwc';

export default class PlanDetailer extends LightningElement {

    @track value = [];

    get options() {
        return [
            { label: 'Email, compare, print', value: 'Emailcompareprint' },
        ];
    }

    get selectedValues() {
        return this.value.join(',');
    }

}
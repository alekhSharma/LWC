import { LightningElement, track } from 'lwc';

export default class ActivityTimeline extends LightningElement {

    @track radioValue = '';

    get radioOptions() {
        return [
            { label: 'Medical with optional Dental/Vision/Life Plans', value: 'option1' },
            { label: 'Dental with optional Vision/Life Plans', value: 'option2' },
            { label: 'Vision with optional Life Plans', value: 'option3' },
            { label: 'Show me only Life Plans', value: 'option4' },
        ];
    }

    @track tabaccoRadioValue = '';

    get tabaccoRadioOptions() {
        return [
            { label: 'Yes', value: 'option1' },
            { label: 'No', value: 'option2' },
        ];
    }

    
    @track coverageRadioValue = '';

    get coverageRadioOptions() {
        return [
            { label: 'Yes', value: 'option1' },
            { label: 'No', value: 'option2' },
        ];
    }
}
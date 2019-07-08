import { LightningElement } from 'lwc';
import cssStaticResource from '@salesforce/resourceUrl/cssStaticResource';
import { loadStyle } from 'lightning/platformResourceLoader';

export default class CssExample extends LightningElement {

    connectedCallback() {
        Promise.all([
           loadStyle(this, cssStaticResource + '/StaticResourceCSS.css')
        ]);
    }
   
}
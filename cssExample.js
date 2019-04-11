import { LightningElement } from 'lwc';
import cssStaticResource from '@salesforce/resourceUrl/cssStaticResource';
import { loadStyle } from 'lightning/platformResourceLoader';

export default class CssExample extends LightningElement {

    renderedCallback() {

        Promise.all([
            loadStyle(this, cssStaticResource + '/StaticCSS/StaticResourceCSS.css'),
        ]);

    }
   
}

import { LightningElement, track, wire, api } from 'lwc';
import downloadResource from '@salesforce/resourceUrl/downloadScript';
import { loadScript } from 'lightning/platformResourceLoader';
import objectlist from '@salesforce/apex/excelGenerator.getSObjects';
import fieldlist from '@salesforce/apex/excelGenerator.getSObjectFields';
import returnObjectData from '@salesforce/apex/excelGenerator.returnObjectData';

export default class ExcelGeneratorTabTwo extends LightningElement {

    @wire(objectlist)objectlist;
    @track fieldresult;
    // combo box attribute
    @track objvalue = '';
    @track _selected;
    @api file;

     // system functions
     connectedCallback() {
        Promise.all([
            loadScript(this, downloadResource)
        ]).then(() => { console.log('script loaded') });
    }

    // combox functions
    get objoptions() {
        return this.objectlist.data;
    }

    handleChange(event) {
        this._selected = [];
     //   this._selected.splice(0,this._selected.length);
        this.objvalue = event.detail.value;
    }

    // duallist functions
    get options() {
        var objname = [this.objvalue];
        fieldlist({
            objectTypes : objname
        }).then(result =>{
            this.fieldresult = result;
            return result;
        }) 
      return this.fieldresult;
    }

    get selected() {
        return this._selected.length ? this._selected : 'none';
    }

    handleFieldChange(e) {
        this._selected = e.detail.value;
    }

    // Button click functions
    buttonclick(){      
        console.log('insdide th button');
        var objname = [this.objvalue];
        if(!(this._selected.includes('Id')))
        this._selected.push('Id');
        var self= this;
        returnObjectData({
            objectName : objname[0],
            fieldName  : self._selected
        }).then(result =>{
           //var csvparsed = Papa.unparse(, result);
           var csvparsed = Papa.unparse({
            "fields": self._selected,
            "data": result
        });
            download(csvparsed, objname[0]+"-BulkQuery.csv",  "text/plain");
        }) 
    }

    
    cancel(){
        this.fieldresult = '';
        this._selected = [];
        this.objvalue = '';
        this.file = '';
    }

}
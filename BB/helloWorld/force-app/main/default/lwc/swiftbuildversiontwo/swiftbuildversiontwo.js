import { LightningElement, wire, track, api} from 'lwc';
import downloadResource from '@salesforce/resourceUrl/downloadScript';
import papaParse from '@salesforce/resourceUrl/papaParse';
import { loadScript } from 'lightning/platformResourceLoader';
import accountData from '@salesforce/apex/excelGenerator.returnAccount';
import objectlist from '@salesforce/apex/excelGenerator.getSObjects';
import fieldlist from '@salesforce/apex/excelGenerator.getSObjectFields';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import saveAttachment from '@salesforce/apex/excelGenerator.insertData';

const columns = [
    { label: 'File Name', fieldName: 'FileName' },
    { label: 'Object Details', fieldName: 'ObjectDetails', type: 'text' },
    { label: 'Field Details', fieldName: 'FieldDetails', type: 'text' },
    { label: 'Record Count', fieldName: 'RecordCount', type: 'Integer' },
];

export default class Swiftbuildversiontwo extends LightningElement {

    @wire(objectlist)objectlist;
    @track loaded = false;
    @track fieldresult;
    // combo box attribute
    @track objvalue = '';

    // duallist box attribute
    @track _selected = [];

    @api file;
    
    // Upload functionality
    @track headers=[];
    @track recordSize='';
    @track data = [];
    @track columns = columns;
    @track tableLoadingState = false;
    
    // system functions
    connectedCallback() {
        Promise.all([
            loadScript(this, downloadResource),
            loadScript(this, papaParse ),
        ]).then(() => { console.log('script loaded') });
    }

    

    // combox functions
    get objoptions() {
        return this.objectlist.data;
    }

    handleChange(event) {
        this._selected = [];
        this._selected.splice(0,this._selected.length);
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
        var objname = [this.objvalue];
        console.log(this._selected);
        accountData({
            objectName : objname[0],
            fieldName  : this._selected,
        }).then(result =>{
            let csv='';

            for(var i =0;i<result.length;i++){
                for(var j =0;j<this._selected.length;j++){
                    if(result[i][this._selected[j]]!==undefined){
                        if(result[i][this._selected[j]].indexOf(',')!==-1){
                            csv += '"'+result[i][this._selected[j]]+'",';
                         }else{
                        csv += result[i][this._selected[j]]+',';
                        }
                    }else{
                        csv += '';
                    }
                }
                csv += '\n';
            }
            console.log(csv);
            download(csv, "Account Template.csv",  "text/plain");
        }) 
    }

    // upload functionality
    get acceptedFormats() {
        return ['.csv'];
    }

    handleChangeFile(event){
        this.file=event.target.files;
        let fileInput=this.file[0];
        this.file=fileInput;
        let reader = new FileReader();
        reader.readAsText(fileInput, "UTF-8");
        let self = this;
        reader.onloadend = function(){
            let csv = reader.result;
            var arr =  csv.split('\n');
            let valuearr = arr[0].split(",");
            self.headers = [];
            valuearr.forEach(element => {
                self.headers.push(element.replace(/"/g,""));
            });
            self.recordSize = arr.length-2;
            if(self.recordSize<0){
                self.recordSize=0;
            }
            self.data = [
                { FileName : self.file.FileName, ObjectDetails :this.objvalue, FieldDetails: self.headers, RecordCount: self.recordSize }
            ]
        };
        reader.onerror = function (evt) {
            console.log("error reading file");
        }
    }

    save(){
        let MAX_FILE_SIZE = 4500000;
        let fileInput=this.file;
        if (!this.file) return;

        if (this.file.size > (MAX_FILE_SIZE)) {
    	alert('File size cannot exceed: ' + MAX_FILE_SIZE + ' bytes.\n' + 'Selected file size: ' + file.size);
        return;
        }
         
        let reader = new FileReader();
        reader.readAsText(fileInput, "UTF-8");
        let self = this;
        reader.onloadend = function(){
            var result = self.CSV2JSON(reader.result);
            console.log(result);
            saveAttachment({
                RecordMap : result,
                objectName : self.objvalue
            }).then(result =>{
                this.fieldresult = result;
                return result;
            }); 
        };
        reader.onerror = function (evt) {
            console.log("error reading file");
        }
    }

    CSV2JSON(csv){

        var results = Papa.parse(csv, {
            header: true
        });
        console.log(results);
        var json = JSON.stringify(results.data);
        return json;
    }
}
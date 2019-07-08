import { LightningElement, wire, track, api } from 'lwc';
import papaParse from '@salesforce/resourceUrl/papaParse';
import { loadScript } from 'lightning/platformResourceLoader';
import objectlist from '@salesforce/apex/excelGenerator.getSObjects';
import ExternalIdlist from '@salesforce/apex/excelGenerator.getExternalIdField';
import insertData from '@salesforce/apex/excelGenerator.insertData';

export default class ExcelGeneratorTabOne extends LightningElement {

    @wire(objectlist) objectlist;            // get objectlist

    @track fieldresult;                     // store field result
    @track currentStep = '1';                 // store the steps
    @track objvalue = '';                   // combo box attribute
    @track _selected = [];                  // duallist box attribute
    @track ExternalIdList;                  // store the external id list
    @track _ExternalIdSelected;             // store the selected external Id

    @api file;

    // Upload functionality
    @track headers = [];
    @track recordSize = '';
    @track data = [];

    // Status Report Variable
    @track ObjectSelectionStatus; @track HeaderStatus;
    @track FileSelectionStatus; @track RecordStatus;
    @track ExternalIdStatus; @track UploadStatus;

    // system functions
    connectedCallback() {
        Promise.all([
            loadScript(this, papaParse)
        ]).then(() => { console.log('uploaded the script') });
    }

    // combox functions
    get objoptions() {
        return this.objectlist.data;

    }

    // handle the object select value
    handleObjectChange(event) {
        this._selected = [];
        this._selected.splice(0, this._selected.length);
        this.objvalue = event.detail.value;
        this.ObjectSelectionStatus = this.objvalue;
        this.currentStep = '2';
    }

    // external ID field 
    handleExternalIdChange(event) {
        this._ExternalIdSelected = event.detail.value;
        this.ExternalIdStatus = this._ExternalIdSelected;
        this.currentStep = '4';
    }

    get ExternalIdoptions() {
        var objname = this.objvalue;
        ExternalIdlist({
            objectName: objname
        }).then(result => {
            this.ExternalIdList = result;
            return result;
        })
        return this.ExternalIdList;
    }

    // upload functionality
    get acceptedFormats() {
        return ['.csv'];
    }

    handleChangeFile(event) {
        this.file = event.target.files;
        let fileInput = this.file[0];
        this.file = fileInput;
        let reader = new FileReader();
        reader.readAsText(fileInput, "UTF-8");
        let self = this;

        reader.onloadend = function () {
            self.currentStep = '3';


            let csv = reader.result;
            var arr = csv.split('\n');
            let valuearr = arr[0].split(",");
            self.headers = [];
            valuearr.forEach(element => {
                self.headers.push(element.replace(/"/g, ""));
            });
            self.recordSize = arr.length - 2;

            if (self.recordSize < 0) {
                self.recordSize = 0;
            }
            self.FileSelectionStatus = self.file.name;
            self.HeaderStatus = self.headers;
            self.RecordStatus = self.recordSize;
            self.data = [
                { FileName: self.file.name, ObjectDetails: this.objvalue, FieldDetails: self.headers, RecordCount: self.recordSize }
            ]
        };
        reader.onerror = function (evt) {
            console.log("error reading file");
        }
    }

    save() {
        let MAX_FILE_SIZE = 4500000;
        let fileInput = this.file;
        if (!this.file) return;

        if (this.file.size > (MAX_FILE_SIZE)) {
            alert('File size cannot exceed: ' + MAX_FILE_SIZE + ' bytes.\n' + 'Selected file size: ' + file.size);
            return;
        }

        let reader = new FileReader();
        reader.readAsText(fileInput, "UTF-8");
        let self = this;
        this.UploadStatus = 'Uploading..';
        reader.onloadend = function () {
            var result = self.CSV2JSON(reader.result);
            insertData({
                RecordMap: result,
                objectName: self.objvalue,
                fieldName: self._ExternalIdSelected
            }).then(result => {
                self.fieldresult = result;
                self.UploadStatus = 'Uploaded';
                return result;
            });
        };
        reader.onerror = function (evt) {
            this.UploadStatus = 'Error reading file';
            console.log("error reading file");
        }
    }

    CSV2JSON(csv) {
        var results = Papa.parse(csv, { header: true });
        var json = JSON.stringify(results.data);
        return json;
    }

    cancel(){
        this.fieldresult = '';
        this._selected = [];
        this.objvalue = '';
        this.currentStep = '1';     
        this.file = '';
        this.ObjectSelectionStatus = '';  this.HeaderStatus= '';
        this.FileSelectionStatus = '';  this.RecordStatus= '';
        this.ExternalIdStatus= '';  this.UploadStatus= '';
    }

}
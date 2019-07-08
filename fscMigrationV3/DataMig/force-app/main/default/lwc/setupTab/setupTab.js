/* eslint-disable no-console */
import getObjectSetupWrapper    from '@salesforce/apex/ObjectFieldSetup.getObjectSetupWrapper';
import ObjectSetupInsertion     from '@salesforce/apex/ObjectFieldSetup.ObjectSetupInsertion';
import {LightningElement, track,api, wire } from 'lwc';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class SetupTab extends LightningElement {

    @wire(CurrentPageReference) pageRef;

    @api setupconnectedSalesforceOrgId;
    @track displayresult;
    @track sourceunmappedLst;
    @track destunmappedLst;
    @track toggleSpinner;

    connectedCallback() {
        // subscribe to searchKeyChange event
        registerListener('searchKeyChange', this.getCompleteData, this);
    }

    disconnectedCallback() {
        // unsubscribe from searchKeyChange event
        unregisterAllListeners(this);
    }

    getCompleteData(setupconnectedSalesforceOrgId) {
        this.toggleSpinner = true;
        getObjectSetupWrapper({ salesforceOrgId: setupconnectedSalesforceOrgId })
            .then(result => {
                if (result) {
                    console.log(result);
                    this.displayresult = result.mappedLst;
                    this.sourceunmappedLst = result.sourceunmappedLst;
                    this.destunmappedLst = result.destunmappedLst;
                    this.toggleSpinner  = false;
                }
            })
            .catch(error => {
                console.log(error);
            })
    }

    allowDrop(ev) {
        ev.preventDefault();
    }

    drag(ev) {
        ev.dataTransfer.setData("text", ev.currentTarget.getAttribute('data-id'));
    }

    drop(ev) {
        ev.preventDefault();
        let DestinationString = this.destunmappedLst.filter(unit => unit.Destination_Object_Api_Name__c === ev.dataTransfer.getData("text"));
        let DestinationUpdatedList = this.destunmappedLst.filter(unit => unit.Destination_Object_Api_Name__c !== ev.dataTransfer.getData("text"));
        this.destunmappedLst = DestinationUpdatedList;
        this.sourceunmappedLst.map(function (unit) {
            if (unit != null || unit !== undefined) {
                if (unit.Name != null || unit.Name !== undefined) {
                    if (ev.currentTarget.childNodes[0].className !== null) {
                        if (unit.Name === ev.currentTarget.childNodes[0].className) {
                            console.log(DestinationString);
                            if(unit.Destination_Object_Api_Name__c==null){
                                unit.Destination_Object_Api_Name__c = DestinationString[0].Destination_Object_Api_Name__c;
                                unit.Destination_Object_Name__c     = DestinationString[0].Destination_Object_Name__c;
                                }
                            }
                        }
                    }
                }
            }
        );
        console.log(this.sourceunmappedLst);
    }

    @api
    nextButtonTriggered(){
        ObjectSetupInsertion({ ObjectSetupInsertion : this.sourceunmappedLst})
            .then(result =>{
                    console.log(result);
            }).catch(error => {
                    console.log(error);
            }); 
    }


}
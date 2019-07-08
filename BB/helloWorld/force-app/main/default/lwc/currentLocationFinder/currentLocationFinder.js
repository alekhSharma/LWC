import { LightningElement, track } from 'lwc';


export default class CurrentLocationFinder extends LightningElement {

    @track lat; 
    @track lon;
    connectedCallback(){
        var startPos;
        let self = this;
        let geoSuccess = function(position) {
            startPos = position;
            self.lat = startPos.coords.latitude;
            self.lon = startPos.coords.longitude;
        };
        navigator.geolocation.getCurrentPosition(geoSuccess);
    }

   
}
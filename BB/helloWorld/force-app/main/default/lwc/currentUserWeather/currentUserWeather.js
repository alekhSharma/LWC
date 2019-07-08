import { LightningElement, track, wire } from 'lwc';
import { fireEvent } from 'c/pubsub';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
export default class CurrentUserWeather extends LightningElement{

    @track placename;
    @wire(CurrentPageReference) pageRef;
    @track date;
    @track day;
    @track weatherDescription; 
    @track icon;
    lat;
    connectedCallback(){
        var today = new Date();
        this.date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        var weekday = new Array(7);
        weekday[0] =  "Sunday";
        weekday[1] = "Monday";
        weekday[2] = "Tuesday";
        weekday[3] = "Wednesday";
        weekday[4] = "Thursday";
        weekday[5] = "Friday";
        weekday[6] = "Saturday";

        this.day = weekday[today.getDay()];
        registerListener('bearListUpdate', this.handleBearListUpdate, this);
        var startPos;
        let geoSuccess = function(position) {
            startPos = position;
            console.log(startPos.coords.latitude);
            this.lat = startPos.coords.latitude;
        };
        navigator.geolocation.getCurrentPosition(geoSuccess);
        console.log(this.lat);
        // Create a request variable and assign a new XMLHttpRequest object to it.
        let request = new XMLHttpRequest();
       // console.log(startPos);
        // Open a new connection, using the GET request on the URL endpoint
        request.open('GET', 'http://api.openweathermap.org/data/2.5/weather?lat='+18.5819136+'&lon='+73.7296384+'&APPID=6f37e666aaca8b7c3c88c360acc352b3', true);
        let self = this;
        request.onload = function () {
            // Begin accessing JSON data here
            let data  = JSON.parse(this.response);
            console.log(self.pageRef);
            fireEvent(self.pageRef, 'bearListUpdate', data);
        }
        // Send request
        request.send();
    }

	disconnectedCallback() {
		// unsubscribe from bearListUpdate event
		unregisterAllListeners(this);
    }
    
	handleBearListUpdate(bears) {
        console.log(bears);
        this.placename = bears.name;
        this.weatherDescription = bears.weather[0].description;
	}

}










//https://www.taniarascia.com/how-to-connect-to-an-api-with-javascript/

// error faced
/*
can't define property "x": "obj" is not extensible + saleles
How to get date / time in lwc
how to get day in lwc

*/
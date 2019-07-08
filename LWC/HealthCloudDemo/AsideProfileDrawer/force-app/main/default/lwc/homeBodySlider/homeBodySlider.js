import { LightningElement } from 'lwc';

export default class HomeBodySlider extends LightningElement {

  

       openNav() {
        this.template.querySelector(".mySidenav").style.width = "250px";
      }
      
       closeNav() {
        this.template.querySelector(".mySidenav").style.width = "0";
      }
}
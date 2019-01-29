import { LightningElement } from 'lwc';

export default class FactoryFunctionExample extends LightningElement {

    person1 = {
        name: "alekh",
        namePerson : function(){
            console.log(this.name);
        }
    };
    
    // Factory Function
    createPerson(name){
        return {
            // name : name | in JS if key value pair is same, we can use this shorthand
            name,
            namePerson(){
                console.log(this.name);
            }
        };
    }

    NormalClick(){
        console.log(this.person1);
    }

    FactoryClick(){
        console.log(this.createPerson('alekh'));
    }
    


}
import { LightningElement } from 'lwc';

export default class ThisMethodCall extends LightningElement {

    thisObject = {
        firstproperty: "Name",
        firstmethod(){
            console.log(this);
            console.log(this.firstproperty);
        }
    }

    thisFunction(){
        console.log(this);
    }

    thisArrayObject = {
        NameOfObject: "Array Object",
        Array:['a','b','c'],
        runArray(){
                this.Array.forEach(function(arr){
                console.log(arr);
                console.log(this.NameOfObject);
        }, this);

        }
    }

    MethodClick(){
        this.thisObject.firstmethod();
    }

    functionClick(){
        this.thisFunction();
    }

    arrayClick(){
        this.thisArrayObject.runArray();
    }


}
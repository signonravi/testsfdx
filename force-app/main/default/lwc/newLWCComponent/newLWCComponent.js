import { LightningElement, api, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class NewLWCComponent extends LightningElement {
    /*@api newapiVal;
    @track newtrackVal;
    @wire newwireVal;

    newapiVal = 'new api value';
    newtrackVal = 'new track value';
*/
handlesuccess(){
    //alert('Contact has been inserted');
    const evt=new ShowToastEvent({
        title:   "Success",
        message: "Contact has been inserted",
        variant: "success"
    });
    this.dispatchEvent(evt);
    console.log('calling cancel');
    this.template.querySelectorAll('lightning-input-field').forEach(Element => {
        Element.value = null;
    }
        );
}
handlecancel(){
    console.log('Inside cancel');
    this.template.querySelector('form').reset();
    console.log('after cancel');
}
}
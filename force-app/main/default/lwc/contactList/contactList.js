import { LightningElement, track } from 'lwc';
//import getContactList from '@salesforce/apex/ContactList.getContactList';
import Contact_Object from '@salesforce/schema/Contact';
import contactName from '@salesforce/schema/Contact.Name';
import contactEmail from '@salesforce/schema/Contact.Email';
import contactPhone from '@salesforce/schema/Contact.Phone';

export default class ContactList extends LightningElement {
    contacts;
    error;
    @track contact_object=Contact_Object;
    /*Name_field = Name_c;
    Email_field = Email_c;
    Phone_field = Phone_c;*/
    field_names=[contactName,contactEmail,contactPhone];

    @track recordId="0032w00001AUbzNAAT";
/*
    @wire(getContactList)
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            this.error = undefined;
            console.log(data);
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
	}
   */ 
}
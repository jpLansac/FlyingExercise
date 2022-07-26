import { LightningElement ,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createFlight from '@salesforce/apex/CreateFlightController.createFlight';

export default class CreateFlightForm extends LightningElement {

    @api selectedDeparture;
    @api selectedArrival;
    @api available = false;
    @api loading = false;
    @api message = '';

    handleDeparture(event){
        if(event.target.value != this.selectedArrival ){
            this.selectedDeparture = event.target.value;
            this.available = false;
        } else {
            const evt = new ShowToastEvent({
                title: 'Warning',
                message: 'The Departure and the Arrival Airport cannot be the same. Please check it again.',
                variant: 'warning',
            });
            this.available = true;
            this.dispatchEvent(evt);
        }
        
    }

    handleArrival(event){

        if(event.target.value != this.selectedDeparture ){
            this.selectedArrival = event.target.value;
            this.available = false;
        } else {
            const evt = new ShowToastEvent({
                title: 'Warning',
                message: 'The Departure and the Arrival Airport cannot be the same. Please check it again.',
                variant: 'warning',
            });
            this.available = true;
            this.dispatchEvent(evt);
        }

    }

    closeAction() {
        eval("$A.get('e.force:refreshView').fire();");
    }

    handleSubmit() {
        console.log("Departure: " + this.selectedDeparture);
        console.log("Arrival: " + this.selectedArrival);
        this.loading = true;
        if(this.selectedDeparture != null && this.selectedArrival != null){
            createFlight({departure : this.selectedDeparture, arrival : this.selectedArrival})
            .then(result => {
                this.message = result;
    
                if(this.message.includes('succesfully')){
                    this.variant = 'success';
                } else {
                    this.variant = 'error';
                }
                const evt = new ShowToastEvent({
                    title: 'Process Finished',
                    message: this.message,
                    variant: this.variant,
                    mode: 'sticky',
                });
                this.loading = false;
                this.dispatchEvent(evt);
            })
            .catch(error => {
                this.error = error;
            });
        } else {
            const evt = new ShowToastEvent({
                title: 'Error',
                message: 'You must choose a Departure and an Arrival Airport.',
                variant: 'error',
            });
            this.loading = false;
            this.dispatchEvent(evt);
        }

    }

}
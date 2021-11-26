import { LightningElement } from 'lwc';
import { subscribe } from 'lightning/empApi';
import getOldestCases from '@salesforce/apex/CaseController.getOldestCases';
import checkPlanet from '@salesforce/apex/IntegrationService.checkPlanet';

export default class CaseList extends LightningElement {

    channelName = '/event/PlanetNews__e';
    cases = [];
    message = '';
    columns = [
        { 
            label: 'Id', 
            fieldName: 'Id', 
            type: 'button',  
            typeAttributes: {
                label:  { fieldName: 'Id' },
                title: 'Id',
                name:  { fieldName: 'Id' },
                value: 'Id',
                variant: 'brand',
            }                                                            
        },
        { label: 'Subject', fieldName: 'Subject' },
        { label: 'Status', fieldName: 'Status' },
        { label: 'ContactEmail', fieldName: 'ContactEmail', type: 'email' },
        { label: 'ContactId', fieldName: 'ContactId', type: 'url' },
    ];


    subscription = {};

    handleClick(event){
        const Id = event.detail.row.Id;
        checkPlanet({
            caseId: Id            
        }).then(result => {
            this.message = result;
        });
       
    }

    connectedCallback() {
        this.refreshList();
        this.handleSubscribe();
    }

    handleSubscribe() {
        const messageCallback = function (response) {
            console.log('Evento recibido');
            this.refreshList();
        };

        subscribe(this.channelName, -1, messageCallback).then((response) => {
            this.subscription = response;
        });
    }

    refreshList(){
        getOldestCases().then(results => {
            this.cases = results;
            this.cases.forEach(elem => {
                elem.ContactId=window.location.origin + '/' + elem.ContactId;
            });
        });
       
    }
    

}
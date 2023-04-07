import { LightningElement,wire } from 'lwc';
import getFilteredSpecies from '@salesforce/apex/SpeciesService.getFilteredSpecies';

export default class SpeciesList extends LightningElement {
    //PROPERTIES, GETTERS Y SETTERS
    searchText = "";
    //LIFECICLE HOOKS

/*     species = [
        {
            "Name": "Jazmín Común",
            "Description__c": "Olorosa y bonita planta trepadora",
            "Location__c": "Indoors,Outdoors",
            "Image_URL__c": "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg"
    
        },
        {
            "Name": "Aloe Vera",
            "Description__c": "Conocida por sus propiedades medicinales y aplicaciones para la piela",
            "Location__c": "Indoors,Outdoors",
            "Image_URL__c": "https://www.farmaceuticonline.com/wp-content/uploads/2019/03/aloevera-1024x768.jpg"
    
        },
        {
            "Name": "Planta del Dinero (Hiedra Sueca)",
            "Description__c": "Planta decorativa de interior preciosa. Utilizada en fengshui.",
            "Location__c": "Indoors,Outdoors",
            "Image_URL__c": "https://images-na.ssl-images-amazon.com/images/I/61b9Wabg3rL._AC_.jpg"
    
        }
    ] */
    //wIRE 
    @wire(getFilteredSpecies,{searchText:'$searchText'})
    species;

    // species.data --> datos devueltos 
    
    // mETHODS
    handleInputChange(event){
        const searchTextAux = event.target.value;
        if(searchTextAux.length >= 2 ||searchTextAux.length === ''){
            this.searchText = searchTextAux;
        }

    }

}
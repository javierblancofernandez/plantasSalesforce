trigger PlantTrigger on Plant__c (before insert,before update) {
    PlantTriggerHandler handler = new PlantTriggerHandler();

    /* Before Insert */
    if (Trigger.isInsert && Trigger.isBefore) {
      handler.beforeInsert(Trigger.new);
    } else if (Trigger.isUpdate && Trigger.isBefore) {
      /* Before Update */
      handler.beforeUpdate(
        Trigger.old,
        Trigger.oldMap,
        Trigger.new,
        Trigger.newMap
      );
    }

    // //Trigger.isBefore,Trigger.isInsert

    // // cuando se crea o actualiza una planta cambiando su fecha riego ---> calcualr sig fecha riego
    // if(Trigger.isInsert ){

    // }
    // if(Trigger.isInsert || Trigger.isUpdate ){
    //     Set<Id> specieIds = new Set<Id>();
    //     for(Plant__c newPlanta : Trigger.new){
    //         //Plant__c oldPlant = Trigger.oldMap.get(newPlanta.id);
    //         Plant__c oldPlant = Trigger.isUpdate ?Trigger.oldMap.get(newPlanta.id):null;
    //         if(oldplant!=null || oldPlant.Last_Watered__c != newPlanta.Last_Watered__c){
    //             specieIds.add(newPlanta.Species__c);
    //         }
    //     }

    //     Map<Id,Species__c> species =new Map<Id,Species__c>( [SELECT Summer_Watering_Summer__c,Winter_Watering_Frequency__c
    //                                 FROM Species__c
    //                                 WHERE Id  IN :specieIds]);
    //     // si esta cambiando la fecha de riego calcular la sig fecha de riego
    //     // Trigger.old/Trigger.new(listas) | Trigger.oldMap Trigger.newMAp(mapas)
    //     //Obtener valor nuevo de fecha riego y fecha antigua y compararlos

    //     for(Plant__c newPlanta : Trigger.new){
    //         //Plant__c oldPlant = Trigger.oldMap.get(newPlanta.id);
    //         Plant__c oldPlant = Trigger.isUpdate ?Trigger.oldMap.get(newPlanta.id):null;
    //         if(oldPlant.Last_Watered__c != newPlanta.Last_Watered__c){
    //             Id specieId = newPlanta.Species__c;
    //             Species__c specie = species.get(specieId);
    //             Integer daysTOAdd = FrequencyService.getWaterinDays(specie);
    //             newPlanta.Next_Water__c = newPlanta.Last_Watered__c.addDays(daysTOAdd);
    //         }
    //     }
    // }
    // // cuando se crea o actualiza una planta cambiando su fecha riego ---> calcualr sig fecha riego

    
}
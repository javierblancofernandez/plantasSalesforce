@isTest
public with sharing class PlantTriggerTest {
    @isTest
    static void insertPlant_lastWateredSetup_nextWateringDateCalculatedCorrectly() {
        //GIVEN
        Species__c poto = new Species__c();
        poto.Winter_Watering_Frequency__c = 'Every other week';
        poto.Summer_Watering_Summer__c = 'Every other week';

        insert poto;

        Plant__c planta1 = new Plant__c();
        planta1.Last_Watered__c = System.today();
        planta1.Last_Fertilized__c = System.today();
        planta1.Species__c = poto.Id;
        //When
        Test.startTest();
        insert planta1;
        Test.stopTest();
        //Then
        planta1 = [SELECT Next_Water__c FROM Plant__c WHERE Id = :planta1.Id];
        System.assertEquals(System.today()+15,planta1.Next_Water__c);
    }


    @isTest
    static void updatePlant_lastWateredSetup_nextWateringDateCalculatedCorrectly() {
        //GIVEN
        Species__c poto = new Species__c();
        poto.Winter_Watering_Frequency__c = 'Every other week';
        poto.Summer_Watering_Summer__c = 'Every other week';

        insert poto;

        Plant__c planta1 = new Plant__c();
        planta1.Last_Watered__c = System.today() - 15;
        planta1.Last_Fertilized__c = System.today() - 15;
        planta1.Species__c = poto.Id;
        insert planta1;
        // then
        planta1 = [SELECT Next_Water__c FROM Plant__c WHERE Id = :planta1.Id];
        System.assertEquals(System.today(),planta1.Next_Water__c);

        planta1.Last_Watered__c = System.today();
        //When
        Test.startTest();
        update planta1;
        Test.stopTest();
        //Then
        planta1 = [SELECT Next_Water__c FROM Plant__c WHERE Id = :planta1.Id];
        System.assertEquals(System.today()+15,planta1.Next_Water__c);
    }
}
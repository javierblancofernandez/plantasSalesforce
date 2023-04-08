public with sharing class ForecastService {
    public static void postNotifications(){
        // Realizar als taresa que queremos planificar
        // 1.mirar la temperatura de hoy
        Forecast fc = ForecastService.getTodaysTemperatures();
        Integer maxTempToday = fc.temperaturas.max;
        Integer minTempToday = fc.temperaturas.min;

        // 2. mirara si temgpo alguna planta para la cual la temp no sea adecuado
        List<Plant__c> plantWithProblems = [SELECT Name,Species__r.Name,Species__r.Max_Temperature__c,Species__r.Min_Temperature__c
                                        FROM Plant__c 
                                        WHERE Species__c IN (
                                            SELECT Id 
                                            FROM Species__c 
                                            WHERE Max_Temperature__c <:maxTempToday 
                                            OR Min_Temperature__c >:minTempToday  )];
        // 3. si encuentro alguna, mandar notificación
            // Get the Id for our custom notification type
        for(Plant__c plantWithProblem : plantWithProblems){
                CustomNotificationType notificationType = 
                [SELECT Id, DeveloperName 
                FROM CustomNotificationType 
                WHERE DeveloperName='Temperature_Alert'];
            
            // Create a new custom notification
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            if(plantWithProblem.Species__r.Max_Temperature__c < maxTempToday){
                setNotficationMessage('hot', notification,maxTempToday,minTempToday,plantWithProblem); 
            }else if(plantWithProblem.Species__r.Min_Temperature__c > minTempToday){
                setNotficationMessage('cold', notification,maxTempToday,minTempToday,plantWithProblem); 
            }

            // Set the notification type and target
            notification.setNotificationTypeId(notificationType.Id);
            notification.setTargetId(plantWithProblem.Id);
            
            // Actually send the notification
            try {
                notification.send(new Set<String>{UserInfo.getUserId()});
            }
            catch (Exception e) {
                System.debug('Problem sending notification: ' + e.getMessage());
            }
        } 
        }

        private static void setNotficationMessage(String type,
        Messaging.CustomNotification notification,
        Integer maxTempToday,
        Integer minTempToday,
        Plant__c plant){
        // Set the contents for the notification
        if(type=='hot'){
            notification.setTitle('Mucho calor para tu planta!!!');
            notification.setBody(
                'Hoy el termómetro alcanzará ' +
                maxTempToday +
                ' grados.\n' +
                ' La temperatura máxima que ' +
                plant.Name +
                ' (' +
                plant.Species__r.Name +
                ') soporta es ' +
                plant.Species__r.Max_Temperature__c
            ); 
        }else if(type=='cold')
            notification.setTitle('Mucho frio para tu planta!!!');
            notification.setBody(
                'Hoy el termómetro bajará de los ' +
                minTempToday +
                ' grados.\n' +
                ' La temperatura mínima que ' +
                plant.Name +
                ' (' +
                plant.Species__r.Name +
                ') soporta es ' +
                plant.Species__r.Max_Temperature__c
            );

        }

    public static Forecast getTodaysTemperatures() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:El_tiempo/api/json/v2/provincias/18/municipios/18087');
        req.setMethod('GET');
      
        // Create a new http object to send the request object
        // A response object is generated as a result of the request  
     
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String body= res.getBody();
        System.debug('BOdy'+res.getBody());
        Forecast forecast = (Forecast)JSON.deserialize(body, Forecast.class);
        System.debug('BOdy Forecast'+forecast);
        return forecast;
    }
    
    public class Forecast{

        public  Temperatures temperaturas;
    }
        public class Temperatures{

            public Integer max;
            public Integer min;
        }
    

}
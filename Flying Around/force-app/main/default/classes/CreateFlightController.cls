/**
 * @description       : 
 * @author            : Jorge Pascual Lansac
 * @group             : 
 * @last modified on  : 07-22-2022
**/
public with sharing class CreateFlightController {

    /**
     * @description       : 
     * @author            : Jorge Pascual Lansac
     * @group             : 
     * @created on        : 07-22-2022
     * Entry Parameters   : Departure Airport Id, Arrival Airport Id
     * Return Value       : Result Message String
    **/
    @AuraEnabled
    public static String createFlight(String departure, String arrival) {

        String message;

        try{
            
            Airport__c departureAirport = [SELECT Id, Name, IATA__c, Geolocation__Latitude__s, Geolocation__Longitude__s FROM Airport__c WHERE Id =: departure LIMIT 1];
            Airport__c arrivalAirport = [SELECT Id, Name, IATA__c, Geolocation__Latitude__s, Geolocation__Longitude__s FROM Airport__c WHERE Id =: arrival LIMIT 1];

            Flight__c newFlight = new Flight__c();
            newFlight.ArrivalAirport__c = arrival;
            newFlight.DepartureAirport__c = departure;
            newFlight.Flight_Distance__c = calculateDistance(departureAirport.Geolocation__Latitude__s, departureAirport.Geolocation__Longitude__s,arrivalAirport.Geolocation__Latitude__s ,arrivalAirport.Geolocation__Longitude__s);

            insert newFlight;

            message = 'Flight created succesfully.';

        }catch (Exception e){
            System.debug('An exception occurred: ' + e.getMessage());
            message = e.getMessage();
        }

        return message;

    }

    public static Decimal calculateDistance(Decimal latitude1, Decimal longitude1, Decimal latitude2, Decimal longitude2) {

        Integer earthRadius = 6371 * 1000; // in meters

        // Transform coordinates from degrees to radians
        Decimal latitudeRadians1 = latitude1 * Math.PI/180;
        Decimal latitudeRadians2 = latitude2 * Math.PI/180;

        // Latitude and longitude differences in radians
        Decimal latitudeDelta = (latitude2 - latitude1) * Math.PI/180;
        Decimal longitudeDelta = (longitude2 - longitude1) * Math.PI/180;
        Decimal a = Math.sin(latitudeDelta/2) * Math.sin(latitudeDelta/2) + Math.cos(latitudeRadians1) * Math.cos(latitudeRadians2) * Math.sin(longitudeDelta/2) * Math.sin(longitudeDelta/2);

        Decimal arc = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        Decimal distance = earthRadius * arc; // in metres
        distance = distance / 1000;  //in kilometres

        return distance;
    }

}
/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-22-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class TestDataFactory {

    public static Airport__c createAirport(String name, String iataCode, Decimal latitude, Decimal longitude) {

        Airport__c newAirport = new Airport__c();
        newAirport.Name = name;
        newAirport.IATA__c = iataCode;
        newAirport.Geolocation__Latitude__s = latitude;
        newAirport.Geolocation__Longitude__s = longitude;

        insert newAirport;
        
        return newAirport;

    }
}

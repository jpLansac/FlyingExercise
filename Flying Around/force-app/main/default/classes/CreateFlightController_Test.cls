/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-22-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class CreateFlightController_Test {

    public static final String ZAZ_AIRPORT  = 'Zaragoza';
    public static final String LCY_AIRPORT  = 'Londres';
    public static final String ZAZ_IATA     = 'ZAZ';
    public static final String LCY_IATA     = 'LCY';

    
    @TestSetup
    public static void createTestData() {
        Airport__c airportTest1 = TestDataFactory.createAirport(ZAZ_AIRPORT, ZAZ_IATA, 41.649693, -0.887712);
        Airport__c airportTest2 = TestDataFactory.createAirport(LCY_AIRPORT, LCY_IATA, 51.5073509, -0.1277583);
    }

    //Test for Successful Flight creation
    @isTest
    public static void createFlight_Test() {

        List<Airport__c> airportList = [SELECT Id FROM Airport__c];
        String departureAirport = airportList[0].Id;
        String arrivalAirport   = airportList[1].Id;

        String testResult = CreateFlightController.createFlight(departureAirport, arrivalAirport);
        
        System.assertEquals(testResult , 'Flight created succesfully.');
        
    }

    //Test for Unsuccessful Flight creation
    @isTest
    public static void createFlightError_Test() {

        List<Airport__c> airportList = [SELECT Id FROM Airport__c];
        String departureAirport = airportList[0].Id;

        String testResult = CreateFlightController.createFlight(departureAirport, null);

        System.assertEquals(testResult , 'List has no rows for assignment to SObject');
                
    }
    
}

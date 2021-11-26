@isTest
public class IntegrationServiceTest {    
        
    static testMethod void testPostCallout() {
        Planet__c pla = new Planet__c(Code__c = 'A-00001', Name = 'Alderaan');
       	insert pla;
        
        User u = [SELECT Id FROM User WHERE Name = 'User User'];
        Case c1 = new Case(Origin = 'Email', OwnerId=u.Id, Planet__c = pla.Id);
        insert c1;
        Case caseId = [SELECT Id, Planet__c FROM Case WHERE Planet__c =: pla.Id];
        System.debug(caseId);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new IntegrationServiceMock());  
        String strResp = IntegrationService.checkPlanet(c1.Id);
        Test.stopTest();

    }   

}
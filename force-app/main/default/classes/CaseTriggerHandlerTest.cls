@isTest
public class CaseTriggerHandlerTest {
    
    static testMethod void testgetOldestCases(){
        
        List<Case> listCases = new List<Case>();
        List<Case> casesWPlanets = new List<Case>();
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User u = [SELECT Id FROM User WHERE Name = 'User User'];
        
        //Planet__c pla = new Planet__c(Code__c = 'A-00001', Name = 'Alderaan');
       	//insert pla;
        //Case c1 = new Case(Origin = 'Email', OwnerId=u.Id, Subject='Solicitud de escaneo', Description='Código de acceso al sistema de escaneo interplanetario: A-00000');
        //insert c1;
        
        Case c2 = new Case(Origin = 'Email', OwnerId = u.Id, Subject = 'Test', Description = 'Test');
        insert c2;
        listCases = [SELECT Id FROM Case WHERE Planet__c != null];  

        System.assertEquals(casesWPlanets.size(), listCases.size());
    }

}
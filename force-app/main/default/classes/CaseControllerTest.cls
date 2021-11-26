@isTest
public class CaseControllerTest {

    static testMethod void testgetOldestCases(){
        
        List<Case> listCases = new List<Case>();
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u = [SELECT Id FROM User WHERE Name = 'User User'];       
        Case c = new Case(Origin = 'Email', OwnerId=u.Id);
        insert c;
        System.assertEquals(CaseController.getOldestCases().size(), listCases.size());      
        
        
    }

}
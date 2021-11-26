public with sharing class CaseController {

    @AuraEnabled
    public static List<Case> getOldestCases(){
        return [SELECT Id, Subject, Status, ContactEmail, ContactId FROM Case WHERE OwnerId =: UserInfo.getUserId() and isClosed = false ORDER BY CreatedDate ASC LIMIT 5];
    }
}


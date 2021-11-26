public with sharing class IntegrationService {
    
    @AuraEnabled
    public static String checkPlanet(Id caseId){
        Case myCase = [SELECT Planet__r.Code__c FROM Case WHERE Id =: caseId];
        String extId = myCase?.Planet__r?.Code__c;
        String accessCode = [SELECT AccessCode__c FROM 	Access_Code__mdt WHERE External_Id__c =: extId].AccessCode__c;
        if(accessCode == null){
            return 'Codigo de acceso no encontrado';
        }
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://s4g-mandalorian-server.herokuapp.com/scan/'+accessCode);
        request.setMethod('GET');
        
        String username = 'mando';
        String password = '12345';
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);   
        system.debug(request.getHeader('Authorization'));
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            myCase.Status = 'Closed';
            myCase.SuccessfulScan__c = True;
            update myCase;
            return 'Baby Yoda encontrado!';
        }
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        return (String)result.get('error');
    }
}

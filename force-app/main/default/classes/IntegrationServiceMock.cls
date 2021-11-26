@isTest
global class IntegrationServiceMock implements HttpCalloutMock {
    
        global HTTPResponse respond(HTTPRequest request) {
            String accessCode = [SELECT AccessCode__c FROM 	Access_Code__mdt LIMIT 1].AccessCode__c;
            System.debug(accessCode);
            String str = 'https://s4g-mandalorian-server.herokuapp.com/scan/'+accessCode;
        	System.assertEquals('GET', request.getMethod());
            
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"found": true}');
            response.setStatusCode(200);
            return response; 
    }
}
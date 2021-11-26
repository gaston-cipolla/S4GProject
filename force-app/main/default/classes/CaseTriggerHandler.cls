public class CaseTriggerHandler {
	public static void handleBeforeInsert(List<Case> cases) {

        List<Case> listCaseEmails = new List<Case>();
        
        for (Case c: cases) {
            if(c.Subject.contains('Solicitud de escaneo') && c.Description.contains('Código de acceso al sistema de escaneo interplanetario')){
                listCaseEmails.add(c);        
            }            
        }

        emailHandler(listCaseEmails);
       
    }

    private static void emailHandler(List<Case> cases){
        List<String> extIdList = new List<String>();
        
        for (Case c: cases) {
            extIdList.add(getCodeFromDescription(c));
        }
        
        List<Planet__c> planetList= [SELECT Id, Code__c FROM Planet__c WHERE Code__c IN: extIdList];
        Map<String, Id> planetMap= new Map<String, Id>();
        
        for (Planet__c p: planetList) {
            planetMap.put(p.Code__c, p.Id);
        }
        
        Set<String> keySet = planetMap.keySet();
        
        for (Case c: cases) {
            String code = getCodeFromDescription(c);
            Id planetId = planetMap.get(code);
            if (planetId == null) {
                c.addError('Invalid code');
                continue;
            }
            c.Planet__c = planetId;
        }

    }

    public static void handleAfterInsert(List<Case> cases){
        PlanetNews__e event = new PlanetNews__e();
        EventBus.publish(event);
    }
    
    private static String getCodeFromDescription(Case c) {
        return c.Description.split(':')[1].trim();
    }
    
}
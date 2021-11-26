trigger caseTrigger on Case (before insert, after insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
    	CaseTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    if (Trigger.isAfter && Trigger.isInsert) {
    	CaseTriggerHandler.handleAfterInsert(Trigger.new);
    }
}
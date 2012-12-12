trigger UpdateN00bTrigger on n00b (before update) {
    if (!trigger.old.hasFiveCertsDone &&
        trigger.new.hasFiveCertsDone) {
            Monkey thatMoneky =
            trigger.new.myBack.remove('CertMonkey');
            system.debug('I finally got ' + thatMonkey.Name +
                         ' off ' + myBack.getName);
    }
}

public with sharing class n00b implements SFDCDreamJob {
    public Map<String, Monkey> myBack = SFDCn00b__c.n00bMonkeys__c;
    public Map<String, Cert> myCerts{get; set;}
    public boolean hasFiveCertsDone {
        get {return (myCert.containsKey('201') &&
                     myCert.containsKey('301') &&
                     myCert.containsKey('401') &&
                     myCert.containsKey('SalesCloudConsultant') &&
                     myCert.containsKey('ServceCloudConsultant'));}
    }

    @isTest
    static void testCertTest() {
        Profile p = [SELECT id, name FROM Profile 
                     WHERE name = 'Services - Enterprise Consulting
                     Temp'
                     LIMIT 1];
        User BBB = [SELECT id, name, myCert FROM user
                    WHERE profileID = :p.Id
                    AND Username = 'bblumenthal@salesforce.com'];

        String certName = ('ServiceCloudConsultant');
        Cert newCert = new Cert();
        newCert.setUp(certName);

        test.startTest(); // Again?                                             
        BBB.myCert = BBB.myCert.add(certName, newCert);
        database.update(BBB);
        test.stopTest();

        User checkBBB = [SELECT id, name, state FROM user 
                         WHERE id = :BBB.id];
        system.assert(!checkBBB.myBack.containsKey('CertMonkey'));

    }
}

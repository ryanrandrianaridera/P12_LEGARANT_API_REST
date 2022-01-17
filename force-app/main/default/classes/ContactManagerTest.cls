@isTest
private class ContactManagerTest {
    
    @isTest static void testGetContactById() {
        Id recordId = TestDataFactory.createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri ='https://ryanrandriap12-dev-ed.lightning.force.com/services/apexrest/Contact/v1/'+ recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Contact thisContact = ContactManager.getContactById();
        // Verify results
        System.assert(thisContact != null);
        System.assertEquals('Mister', thisContact.FirstName);
    }
    @isTest 
    static void testCreateNewContact() {
        
        // Call the method to test and add parameters
        Id thisContactId = ContactManager.createNewContact('Mr.','Mister', 'Test', 'Pass1234567890', '+330123456789', 'mistertest@testsf.com.fr');
        
        // Retrieve Id & Email of the created Contact 
        Contact thisContact = [SELECT Id, Salutation, Firstname, LastName, Password__c, Email FROM Contact WHERE Id = :thisContactId];
        
        // Verify results
        System.assert(thisContact != null);
        System.assertEquals(thisContact.Salutation, 'Mr.');
        System.assertEquals(thisContact.FirstName, 'Mister');
        System.assertEquals(thisContact.LastName, 'Test');
        System.assertEquals(thisContact.Password__c, 'Pass1234567890');
        System.assertEquals(thisContact.Email, 'mistertest@testsf.com.fr');
    }
    
    @isTest 
    static void testContactExist() {
        
        // Call the method to test
        Id ctcId = TestDataFactory.createTestRecord();
        Contact myContactId = [SELECT Id, Firstname, LastName, Phone, Email, Password__c FROM Contact WHERE Id =:ctcId LIMIT 1];         
        Id thisContactId = ContactManager.createNewContact('Mr.','Mister', 'Test', 'Pass1234567890bis', '+330123456789', 'mistertest@testsf.com.fr');        
        
        // Verify results
        System.assert(thisContactId != null);
        Contact thisContact = [SELECT Id, Salutation, Firstname, LastName, Phone, Email, Password__c FROM Contact WHERE Id=:thisContactId];
        System.assert(thisContact != null);
        System.assert(ctcId != null);
        System.assertEquals(myContactId.Email, thisContact.Email);
        System.assertEquals(myContactId.Id, thisContact.Id);        
    }
    
    
    @isTest 
    static void testUpdateContact() { 
        
        // Set up a test request
        Id recordId = TestDataFactory.createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI = 'https://ryanrandriap12-dev-ed.lightning.force.com/services/apexrest/Contact/v1/' + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Phone":"+330987654321"}');
        RestContext.request = request;
        
        // Update all fields of existing record (only phone has changed)
        Id thisContactId = ContactManager.updateContact('Mr','Mister', 'Test', 'Pass1234567890', '+330987654321', 'mistertest@testsf.com.fr');
        
        // Retrieve Id & Phone of the updated Contact
        Contact thisContact = [SELECT Id, Phone FROM Contact WHERE Id=:thisContactId];
        
        // Verify the Phone is equal to the updated Contact
        System.assertEquals(thisContact.Phone, '+330987654321');    
    }
    
    @isTest static void testDeactivateContact() {
        
        // Set up a test request
        Id recordId = TestDataFactory.createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI =  'https://ryanrandriap12-dev-ed.lightning.force.com/services/apexrest/Contact/v1/' + recordId;
        request.httpMethod = 'DELETE';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Active__c" : "false"}');
        RestContext.request = request;
        
        // Call the method to test
        Id thisContactId = ContactManager.deactivateContact();
        
        // Retrieve Id & Deactivated__c fields of the updated Contact 
        Contact thisContact = [SELECT Id, Active__c FROM Contact WHERE Id =:thisContactId];
        
        // Verify Deactivated__c value is updated to true
        System.assertEquals(thisContact.Active__c, false);
    }   
}
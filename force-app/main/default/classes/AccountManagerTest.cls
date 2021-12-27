@isTest
private class AccountManagerTest {
    @isTest 
    static void testCreateNewAccount() {
        
        // Call the method to test and add a parameter 
        ID thisAccountId = AccountManager.createNewAccount('TestAccountAPIREST');
        
        // Retrieve the name of the created Account 
        Account thisAccount = [SELECT Name FROM Account WHERE Id =:thisAccountId];
        
        // Verify the Name is equal to the created Account
        System.assertEquals(thisAccount.Name, 'TestAccountAPIREST');
    }
    
    @isTest static void testUpdateAccount() {
        
        // Set up a test request
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI = 'https://ryanrandriap12-dev-ed.lightning.force.com/services/apexrest/Accounts/v1/' + recordId;
        request.httpMethod = 'PUT';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Name":"TestAccountRESTUpdate"}');
        RestContext.request = request;
        
        // Update Name of existing record to 'TestAccountRESTupdt'
        Id thisAccountId = AccountManager.updateAccount('TestAccountRESTUpdate');
        
        // Retrieve Name & Id of the updated Account
        Account thisAccount = [SELECT Id,Name FROM Account WHERE Id=:thisAccountId];
        
        // Verify the Name is equal to the updated Account
        System.assertEquals(thisAccount.Name, 'TestAccountRESTUpdate');
    }
    
    // Helper method
    static Id CreateTestRecord(){
        
        // Create test record for Account
        Account accountTest = new Account(Name = 'TestRecordForAccountAPIREST');
        insert accountTest;
        return accountTest.Id;
    }
    
}
public with sharing class TestDataFactory {
    public static Id createTestRecord() {
        // Create test record
        Contact contactTest = new Contact(Salutation='Mr.', FirstName='Mister', LastName='Test', Password__c='Pass1234567890', Phone='+330123456789', Email='mistertest@testsf.com.fr');
        insert contactTest;
        return contactTest.Id;
    }
    
    public static Id createAccount() {
        // Create test record for Account
        Account accountTest = new Account();
        accountTest.Name ='TestAccount';
        insert accountTest;
        return accountTest.id;
    }
    
    public static Id createAccountAndContractRecord() {
        // Create test record for Account
        Account accountTest = new Account();
        accountTest.Name ='TestAccount';
        insert accountTest;
        
        // Create test record for Contract
        Contract contractTest = new Contract(
            Name = 'TestContract',
            Status = 'Draft',
            AccountId = accountTest.Id,
            StartDate = Date.valueOf('2022-01-30'),
            ContractTerm = 12
        );
        insert contractTest;
        return contractTest.Id;
    }  
}
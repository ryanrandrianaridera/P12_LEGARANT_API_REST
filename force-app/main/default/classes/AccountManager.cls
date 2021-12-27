@RestResource(urlMapping='/Accounts/v1/*')

global with sharing class AccountManager {
    @HttpPost
    global static Id createNewAccount(String Name) {
        // Creation of a new Account 
        Account thisAccount = new Account(Name = Name);
        insert thisAccount;
        // Return the Account Id
        return thisAccount.Id;
    }    
    
    @HttpPut
    global static Id updateAccount(String Name){
        // Add the Account Id as a parameter in the URL
        RestRequest request = RestContext.request;
        String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        
        // Retrieve the Account based on the Id
        Account result = [SELECT Id FROM Account WHERE Id = :id];
        Account thisAccount = new Account(); 
        thisAccount.Id = id;  
        thisAccount.Name = Name;
        
        // Update the field Name on the Account 
        update thisAccount;
        
        // Return the Account Id
        return thisAccount.Id;
    }
}
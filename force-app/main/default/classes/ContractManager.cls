@RestResource(urlMapping='/Contract/v1/*')
global with sharing class ContractManager {  
    @HttpGet
    global static Contract getContractById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String contractId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Contract result =  [SELECT ContractNumber, AccountId, StartDate, EndDate, ContractTerm, Status, CustomerSignedId
                            FROM Contract
                            WHERE Id = :contractId];
        return result;
    }
    
    
    @HttpPost
    global static Id createNewContract(String Name, String Status, Id AccountId, Date StartDate, Integer ContractTerm) {
        
        // Creation of a new Contract
        Contract thisContract = new Contract(
            Name = Name,
            Status = Status,
            AccountId = AccountId,
            StartDate = StartDate,
            ContractTerm = ContractTerm);
        
        insert thisContract;
        
        // Return the Contract Id
        return thisContract.Id;
    }
    
    @HttpPatch
    global static Id updateContract(String Name, String Status, Id AccountId, Date StartDate, Integer ContractTerm){
        
        // Add the Contract Id as a parameter in the URL
        RestRequest request = RestContext.request;
        String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        
        // Retrieve the Contract based on the Id
        Contract result = [SELECT Id FROM Contract WHERE Id = :id];
        Contract thisContract = new Contract(); 
        thisContract.Id = id;  
        thisContract.Name = Name;
        thisContract.Status = Status;
        thisContract.AccountId = AccountId;
        thisContract.StartDate = StartDate;
        thisContract.ContractTerm = ContractTerm;
        
        // Update the contract fields on the Account 
        update thisContract;
        
        // Return the Contract Id
        return thisContract.Id;
    }
}
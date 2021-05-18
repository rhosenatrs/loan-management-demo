public class ApplicationWizard{
    
    Application__c app = new Application__c();
    Applicant__c applicant = new Applicant__c();
    Guarantor__c guarantor  = new Guarantor__c();
    Vehicle__c vehicle = new Vehicle__c();
    Document__c document = new Document__c();
    
    public List<Vehicle__c> vehicleList{ get; set; }
    public List<Guarantor__c> guarantorList{ get; set; }
    public List<Document__c> documentList{ get; set; }
    List<Application__c> applicationList = 
        [
            select Name,
            LoanAmount__c, 
            LoanTerm__c, 
            InterestRate__c, 
            DownPayment__c, 
            Status__c, 
            IsActive__c,
            Applicant__c
            FROM Application__c
        ];
    
    public ApplicationWizard() {
        vehicleList = new list<Vehicle__c>();
        guarantorList = new list<Guarantor__c>();
        documentList = new list<Document__c>();
    }
    
    
    public List<Application__c> GetApplicationList(){
        return applicationList;
    }
    
    public Application__c GetApp(){
        return app;
    }
    
    public Applicant__c GetApplicant(){
        return applicant;
    }
    
    public Vehicle__c GetVehicle(){
        return vehicle;
    }
    
    public Guarantor__c GetGuarantor(){
        return guarantor;
    }
    
    public Document__c GetDocument(){
        return document;
    }
    
    public PageReference AddVehicle() {
        Vehicle__c  newVehicle = new Vehicle__c();
        newVehicle.Name = vehicle.Name;
        newVehicle.Make__c = vehicle.Make__c;
        newVehicle.Price__c = vehicle.Price__c;
        newVehicle.Type__c = vehicle.Type__c;
        newVehicle.Model__c = vehicle.Model__c;
        newVehicle.Year__c = vehicle.Year__c;
        vehicleList.add(newVehicle);
        return Page.VehicleList;
    }
    
    public PageReference AddGuarantor() {
        Guarantor__c newGuarantor = new Guarantor__c();        
        newGuarantor.Name = guarantor.Name;
        newGuarantor.FatherName__c = guarantor.FatherName__c;
        newGuarantor.MotherName__c = guarantor.MotherName__c;
        newGuarantor.BirthDate__c = guarantor.BirthDate__c;
        newGuarantor.EmailAddress__c = guarantor.EmailAddress__c;
        newGuarantor.PhoneNumber__c = guarantor.PhoneNumber__c;
        newGuarantor.PermanentAddress__c = guarantor.PermanentAddress__c;
        newGuarantor.PresentAddress__c = guarantor.PresentAddress__c;
        newGuarantor.NationalIdentityNumber__c = guarantor.NationalIdentityNumber__c;
        newGuarantor.PresentAddress__c = guarantor.PresentAddress__c;
        newGuarantor.Profession__c = guarantor.Profession__c;
        newGuarantor.MonthlyIncome__c = guarantor.MonthlyIncome__c;
        newGuarantor.Percentage__c = guarantor.Percentage__c;
        newGuarantor.MaritalStatus__c = guarantor.MaritalStatus__c;
        newGuarantor.Relation__c = guarantor.Relation__c;
        newGuarantor.Remarks__c = guarantor.Remarks__c;
        guarantorList.add(newGuarantor);
        return Page.GuarantorList;
    }
    
    
    public PageReference AddDocument() {
        Document__c newDocument = new Document__c();        
        newDocument.Name = document.Name;
        documentList.add(newDocument);
        return Page.DocumentList;
    }
    
    private void ShowAmountMessage(){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Total Asset amount and Loan amount doesn\'t match'));
    }
    
    private void ShowPercentageMessage(){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Total Guarantor percentage must be equal to 100'));
    }
    
    private boolean IsLoanAmountEquivalentToAssetAmount(){
        decimal totalAssetAmount = 0;
        for (Vehicle__c v : vehicleList) {
            totalAssetAmount += v.Price__c;
        }
        return totalAssetAmount == app.LoanAmount__c;
    }
    
    private boolean IsPercentageEqualto100(){
        decimal totalGuaratorPercentage = 0;
        for (Guarantor__c g : guarantorList) {
            totalGuaratorPercentage += g.Percentage__c;
        }
        return totalGuaratorPercentage == 100;
    }
    
    public PageReference Save(){ 
        if(!IsLoanAmountEquivalentToAssetAmount()){
            ShowAmountMessage();
            return null;
        }
        if(!IsPercentageEqualto100()){
            ShowPercentageMessage();
            return null;
        }
        insert applicant;
        app.Applicant__c = applicant.ID;
        insert app;
        for (Vehicle__c v : vehicleList) {
            v.Application__c = app.ID;
        }
        for (Guarantor__c g : guarantorList) {
            g.Application__c = app.ID;
        }
        for (Document__c d : documentList) {
            d.Application__c = app.ID;
        }
        insert vehicleList;
        insert guarantorList;
        insert documentList;
        return Page.ApplicationList;
    }
    
    public PageReference GoToApplication(){
        return Page.Application;
    }
    
    public PageReference GoToApplicationList(){
        return Page.ApplicationList;
    }
    
    public PageReference GoToVehicle(){
        return Page.Vehicle;
    }
    
    public PageReference GoToVehicleList(){
        return Page.VehicleList;
    }
    
    public PageReference GoToGuarantor(){
        return Page.Guarantor;
    }
    
    public PageReference GoToGuarantorList(){
        return Page.GuarantorList;
    }
    
    public PageReference GoToDocument(){
        return Page.Document;
    }
    
    public PageReference GoToDocumentList(){
        return Page.DocumentList;
    }
    
    public PageReference GoToSummary(){
        return Page.Summary;
    }
}
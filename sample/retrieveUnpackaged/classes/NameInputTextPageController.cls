public with sharing class NameInputTextPageController {
    public NameInputTextPageController() {}

    public DataWrapper theName {
        get {
            if (theName == null) {
                theName = new DataWrapper('First Name');
            }
            return theName;
        }
        set;
    }

    public PageReference empty() {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, (String)theName.value));
        return null;
    }
}
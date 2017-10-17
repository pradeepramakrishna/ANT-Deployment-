public with sharing class NameInputTextComponentController {
    public NameInputTextComponentController() {}

    public DataWrapper theValue { get; set; }

    public String name {
        get {
            return (String)theValue.value;
        }
        set {
            System.debug('the new value : ' + value);
            theValue.value = value;
        }
    }

    public PageReference formatName() {
        List<String> splits = name.split(' ');
        List<String> capitalizedSplits = new List<String>();
        for (String s : splits) {
            capitalizedSplits.add(s.capitalize());
        }
        name = String.join(capitalizedSplits, ' ');
        return null;
    }
}
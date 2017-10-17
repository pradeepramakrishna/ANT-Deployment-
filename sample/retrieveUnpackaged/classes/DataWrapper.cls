public with sharing class DataWrapper {
    public Object value { get; set; }

    public DataWrapper() {}
    public DataWrapper(Object theValue) {
        value = theValue;
    }
}
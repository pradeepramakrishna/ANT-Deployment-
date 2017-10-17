public class tpc{

    public PageReference dosubmit(){

        // create case, etc.

        system.debug('test');

        PageReference pr = new PageReference('http://www.google.com'); 
        pr.setRedirect(true);       
        return pr;
        }    
    

}
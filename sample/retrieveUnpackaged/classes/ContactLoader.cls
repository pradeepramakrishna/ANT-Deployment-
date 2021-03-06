public class ContactLoader
{
    //It holdes the Content of the CSV File which you have uploaded.
    public String nameFile{get;set;}
   
    //Rendering pageblocks
    public boolean display{get;set;}
    public boolean records{get;set;}
   
    //Retrieve Content from the CSV File
    public Blob csvFile{get;set;}
   
    //Read Lines from the CSV File
    String[] filelines = new String[]{};
       
        //It hold List of Contact Records
        List<Contact> contactInsert=new List<Contact>();
   
    public ContactLoader()
    {
        display=true;
        records=false;
    }
    public Pagereference ReadFile()
    {
       
        display=false;
        records=true;
       
        if(csvFile!=null)
        {
            // Convert the Blob content to String
            nameFile=csvFile.toString();
           
            //Read the CSV Rows using split method
            filelines = nameFile.split('\n');
        }
        else
        {
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Please select a record to upload...!');
            ApexPages.addMessage(errormsg);
        }
       
        try
        {
            for (Integer i=1;i<filelines.size();i++)
            {
               
                String[] inputvalues = new String[]{};
                   
                    //Read multiple column values within the same row using split method
                    inputvalues = filelines[i].split(',');
                Contact cnt= new Contact();
               
                // inputvalues[0] to inputvalues[3] holdes the index of the CSV file,Read and Map Field from CSV to Salesforce.
               
                //Note : If you want to insert Extra fields map those fields below and in your CSV file
               
                cnt.FirstName= inputvalues[0];
                cnt.LastName= inputvalues[1];
               
                if(String.isNotBlank(inputvalues[2]))
                {
                    cnt.AccountId= inputvalues[2];
                }
                else
                {
                    cnt.AccountId=null;
                }
               
                cnt.LeadSource= inputvalues[3];
               
                //Add uploaded values into List
                contactInsert.add(cnt);
            }
           
            //insert your Contact Records into Salesforce
            insert contactInsert;
        }
        catch (Exception e)
        {
            //throw Error if user choosen invalid template
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Invalid template or file while processing your records...!');
            ApexPages.addMessage(errormsg);
        }
        return null;
    }
   
    public List<Contact> getuploadedContacts()
    {
       
        //Below function return the inserted records in pageblock table
        set<id> recordid= new set<id>();
        for(contact ct:contactInsert)
        {
            recordid.add(ct.id);
        }
        list<contact> ctctlist=new list <contact>();
        ctctlist=[select FirstName,LastName,AccountId,LeadSource,Account.Name from Contact where id IN: recordid ];
        if (contactInsert!= NULL)
        {
            if (contactInsert.size() > 0)
                return ctctlist;
           
            else
                return null;
        }      
        else
        {
            return null;
        }
    }
    public pageReference refresh()
    {
        //redirect after pressed Go Back button
        PageReference pageRef= new PageReference('/apex/UploadContacts');
        pageRef.setRedirect(true);
        return pageRef;
    }
}
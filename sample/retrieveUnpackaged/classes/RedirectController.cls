public class RedirectController{
    public RedirectController(){
    }
    public PageReference redirectToSomePage(){
        PageReference result_page = Page.MyCustomPage;
        result_page.getParameters().put('secret_param', 'secret_value');
        return result_page;
    }
}
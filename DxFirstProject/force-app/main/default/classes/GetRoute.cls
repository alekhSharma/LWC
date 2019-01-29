public with sharing class GetRoute {
 
    /**
     * Webkul Software.
     *
     * @category  Webkul
     * @author    Webkul
     * @copyright Copyright (c) 2010-2016 Webkul Software Private Limited (https://webkul.com)
     * @license   https://store.webkul.com/license.html
     */
 
    public static string startpoint{get{
        startpoint = apexpages.currentpage().getparameters().get('startpoint');
        return startpoint;
    } set;}
    public static string endpoint{get{
        endpoint = apexpages.currentpage().getparameters().get('endpoint');
        return endpoint;
    } set;}
     
    public void nothing(){}   
}
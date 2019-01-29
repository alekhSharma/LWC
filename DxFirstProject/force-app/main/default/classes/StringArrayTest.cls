public class StringArrayTest {

    
    public static list<string> generateStringArray(integer n){
        list<string> teststring = new list<string>();
        for(integer i=0;i<n;i++)
        teststring.add('Test ' + i);
        return teststring;
    }
}
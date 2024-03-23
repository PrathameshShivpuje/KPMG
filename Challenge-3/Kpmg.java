import java.util.HashMap;
import java.util.Map;

public class Kpmg {

    public static Object getValue(Map<String, Object> obj, String key) {
        String[] keys = key.split("/");
        Map<String, Object> currentObj = obj;

        for (String k : keys) {
            Object value = currentObj.get(k);
            if (value instanceof Map) {
                currentObj = (Map<String, Object>) value;
            } else {
                return value;
            }
        }

        return null;
    }

    public static void main(String[] args) {

        Map<String, Object> obj1 = new HashMap<>();
        Map<String, Object> innerMap1 = new HashMap<>();
        innerMap1.put("c", "d");
        obj1.put("a", innerMap1);

        Map<String, Object> obj2 = new HashMap<>();
        Map<String, Object> innerMap2 = new HashMap<>();
        Map<String, Object> innerMap3 = new HashMap<>();
        innerMap3.put("z", "a");
        innerMap2.put("y", innerMap3);
        obj2.put("x", innerMap2);


        String key1 = "a/b/c";
        String key2 = "x/y/z";


        Object value1 = getValue(obj1, key1);
        Object value2 = getValue(obj2, key2);


        System.out.println("Value for key '" + key1 + "': " + value1);
        System.out.println("Value for key '" + key2 + "': " + value2);
    }
}

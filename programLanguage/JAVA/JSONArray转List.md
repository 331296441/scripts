import com.alibaba.fastjson.JSONArray;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        JSONArray jsonArray = JSONArray.parseArray("[\"item1\", \"item2\", \"item3\"]");
        List<String> stringList = jsonArrayToList(jsonArray);
        System.out.println(stringList);
    }

    private static List<String> jsonArrayToList(JSONArray jsonArray) {
        List<String> stringList = new ArrayList<>();
        for (Object obj : jsonArray) {
            if (obj instanceof String) {
                stringList.add((String) obj);
            }
        }
        return stringList;
    }
}

import com.alibaba.fastjson.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<JSONObject> jsonObjectList = new ArrayList<>();
        jsonObjectList.add(JSONObject.parseObject("{\"name\":\"name1\",\"id\":1,\"script\":\"{test:test1}\"}"));
        jsonObjectList.add(JSONObject.parseObject("{\"name\":\"name2\",\"id\":2,\"script\":\"{test:test2}\"}"));

        List<String> stringList = jsonObjectListToList(jsonObjectList);
        System.out.println(stringList);
    }

    private static List<String> jsonObjectListToList(List<JSONObject> jsonObjectList) {
        List<String> stringList = new ArrayList<>();
        for (JSONObject jsonObject : jsonObjectList) {
            stringList.add(jsonObject.toJSONString());
        }
        return stringList;
    }
}
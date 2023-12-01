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


如果`convertJsonListToCsv`函数可能接受的是`List<JSONObject>`或`List<String>`，并且需要将`List<JSONObject>`转换为`List<String>`，可以使用fastjson的`toJSONString`方法将`JSONObject`转换为`String`。以下是修改后的代码：

```java
import com.alibaba.fastjson.JSONObject;
import com.opencsv.CSVWriter;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<JSONObject> jsonObjectList = new ArrayList<>();
        jsonObjectList.add(JSONObject.parseObject("{\"name\":\"name1\",\"id\":1,\"script\":\"{test:test1}\"}"));
        jsonObjectList.add(JSONObject.parseObject("{\"name\":\"name2\",\"id\":2,\"script\":\"{test:test2}\"}"));

        List<String> stringList = convertJsonListToCsv(jsonObjectList);
        System.out.println(stringList);
    }

    private static List<String> convertJsonListToCsv(List<?> jsonList) {
        List<String> stringList = new ArrayList<>();
        for (Object obj : jsonList) {
            if (obj instanceof JSONObject) {
                stringList.add(((JSONObject) obj).toJSONString());
            } else if (obj instanceof String) {
                stringList.add((String) obj);
            }
        }
        return stringList;
    }
}
```

在这个示例中，我们首先创建一个`List<JSONObject>`，并使用fastjson的`parseObject`方法将JSON字符串解析为`JSONObject`对象，并将其添加到`List`中。然后，我们调用`convertJsonListToCsv`函数将`List<JSONObject>`转换为`List<String>`。该函数遍历`List`中的每个元素，如果是`JSONObject`类型，则使用`toJSONString`方法将其转换为`String`类型后添加到`List`中；如果是`String`类型，则直接添加到`List`中。

运行上述代码将输出`["{\"name\":\"name1\",\"id\":1,\"script\":\"{test:test1}\"}", "{\"name\":\"name2\",\"id\":2,\"script\":\"{test:test2}\"}"]`，表示成功将`List<JSONObject>`转换为`List<String>`。
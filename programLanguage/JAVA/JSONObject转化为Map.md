您可以使用Fastjson提供的`TypeReference`来将`JSONObject`转换为`Map`。以下是示例代码：

```java
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import java.util.Map;

public class Example {
    public static void main(String[] args) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("key1", "value1");
        jsonObject.put("key2", "value2");
        
        Map<String, Object> map = JSONObject.parseObject(jsonObject.toJSONString(),
                new TypeReference<Map<String, Object>>(){});
        
        System.out.println(map);
    }
}
```

在上面的代码中，我们首先创建了一个`JSONObject`对象，然后使用`toJSONString()`方法将其转换为JSON字符串。接下来，我们使用`TypeReference`将JSON字符串转换为`Map`对象。最后，我们打印`Map`对象以验证转换是否成功。
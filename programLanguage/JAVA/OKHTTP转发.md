以下是一个封装OkHttp的Java工具类方法，它可以将HTTP请求转发到指定地址，并将返回的结果封装到JSON中返回：

```java
import okhttp3.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class OkHttpUtils {

    private static final OkHttpClient client = new OkHttpClient();

    public static String sendHttpRequest(String url, String method, Map<String, String> headers, String requestBody) throws IOException {
        Request.Builder requestBuilder = new Request.Builder().url(url);

        if (headers != null) {
            for (Map.Entry<String, String> entry : headers.entrySet()) {
                requestBuilder.addHeader(entry.getKey(), entry.getValue());
            }
        }

        RequestBody body = null;
        if (requestBody != null) {
            body = RequestBody.create(MediaType.parse("application/json"), requestBody);
        }

        Request request = null;
        if (method.equalsIgnoreCase("GET")) {
            request = requestBuilder.build();
        } else if (method.equalsIgnoreCase("POST")) {
            request = requestBuilder.post(body).build();
        } else if (method.equalsIgnoreCase("PUT")) {
            request = requestBuilder.put(body).build();
        } else if (method.equalsIgnoreCase("DELETE")) {
            request = requestBuilder.delete(body).build();
        }

        Response response = client.newCall(request).execute();

        Map<String, Object> result = new HashMap<>();
        result.put("statusCode", response.code());
        result.put("headers", response.headers().toMultimap());
        result.put("body", response.body().string());

        return new Gson().toJson(result);
    }
}
```

使用示例：

```java
Map<String, String> headers = new HashMap<>();
headers.put("Content-Type", "application/json");

String requestBody = "{\"name\":\"John\", \"age\":30}";

String responseJson = OkHttpUtils.sendHttpRequest("http://example.com/api", "POST", headers, requestBody);

System.out.println(responseJson);
```

其中，`url`参数是要转发的HTTP请求的地址，`method`参数是HTTP请求的方法（GET、POST、PUT、DELETE），`headers`参数是HTTP请求的头部信息，`requestBody`参数是HTTP请求的请求体。返回值是一个JSON字符串，包含HTTP响应的状态码、头部信息和响应体。
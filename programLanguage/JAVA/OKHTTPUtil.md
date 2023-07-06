```java
// Java

import okhttp3.*;

import java.io.File;
import java.io.IOException;

import com.alibaba.fastjson.JSONObject;

public class OkHttpUtils {
    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private static final MediaType XML = MediaType.parse("application/xml; charset=utf-8");
    private static final MediaType FORM = MediaType.parse("application/x-www-form-urlencoded; charset=utf-8");
    private static final MediaType STREAM = MediaType.parse("application/octet-stream");

    private static OkHttpClient client = new OkHttpClient();

    public static JSONObject get(String url) throws IOException {
        Request request = new Request.Builder()
                .url(url)
                .build();
        return executeRequest(request);
    }

    public static JSONObject postJson(String url, String json) throws IOException {
        RequestBody body = RequestBody.create(JSON, json);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .build();
        return executeRequest(request);
    }

    public static JSONObject postXml(String url, String xml) throws IOException {
        RequestBody body = RequestBody.create(XML, xml);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .build();
        return executeRequest(request);
    }

    public static JSONObject postForm(String url, String form) throws IOException {
        RequestBody body = RequestBody.create(FORM, form);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .build();
        return executeRequest(request);
    }

    public static JSONObject postFile(String url, File file) throws IOException {
        RequestBody body = RequestBody.create(STREAM, file);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .build();
        return executeRequest(request);
    }

    private static JSONObject executeRequest(Request request) throws IOException {
        Response response = client.newCall(request).execute();
        String responseData = response.body().string();
        return JSONObject.parseObject(responseData);
    }
}

```
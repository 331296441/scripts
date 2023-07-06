// Java

import java.io.IOException;
import java.util.Map;

import okhttp3.*;

public class HttpUtils {
    private static final OkHttpClient client = new OkHttpClient();

    // GET request
    public static String get(String url, Map<String, Object> headers) throws IOException {
        Request.Builder builder = new Request.Builder().url(url);
        addHeaders(builder, headers);
        Request request = builder.build();
        Response response = client.newCall(request).execute();
        return response.body().string();
    }

    // POST request with form data
    public static String postForm(String url, Map<String, Object> headers, Map<String, Object> params) throws IOException {
        FormBody.Builder formBuilder = new FormBody.Builder();
        addParams(formBuilder, params);
        RequestBody formBody = formBuilder.build();
        Request.Builder builder = new Request.Builder().url(url).post(formBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        Response response = client.newCall(request).execute();
        return response.body().string();
    }

    // POST request with JSON data
    public static String postJson(String url, Map<String, Object> headers, String json) throws IOException {
        RequestBody requestBody = RequestBody.create(MediaType.parse("application/json"), json);
        Request.Builder builder = new Request.Builder().url(url).post(requestBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        Response response = client.newCall(request).execute();
        return response.body().string();
    }

    // Helper method to add headers to the request builder
    private static void addHeaders(Request.Builder builder, Map<String, Object> headers) {
        if (headers != null) {
            for (Map.Entry<String, Object> entry : headers.entrySet()) {
                builder.addHeader(entry.getKey(), String.valueOf(entry.getValue()));
            }
        }
    }

    // Helper method to add form data parameters to the form builder
    private static void addParams(FormBody.Builder builder, Map<String, Object> params) {
        if (params != null) {
            for (Map.Entry<String, Object> entry : params.entrySet()) {
                builder.add(entry.getKey(), String.valueOf(entry.getValue()));
            }
        }
    }

    // Example usage
    public static void main(String[] args) throws IOException {
        String url = "https://jsonplaceholder.typicode.com/posts";
        Map<String, Object> headers = Map.of("Authorization", "Bearer token");
        Map<String, Object> params = Map.of("title", "foo", "body", "bar", "userId", 1);

        // GET request
        String responseGet = HttpUtils.get(url, headers);
        System.out.println(responseGet);

        // POST request with form data
        String responsePostForm = HttpUtils.postForm(url, headers, params);
        System.out.println(responsePostForm);

        // POST request with JSON data
        String json = "{\"title\":\"foo\",\"body\":\"bar\",\"userId\":1}";
        String responsePostJson = HttpUtils.postJson(url, headers, json);
        System.out.println(responsePostJson);
    }
}

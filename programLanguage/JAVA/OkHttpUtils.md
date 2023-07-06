```java
// Java

import java.io.File;
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

    // POST request with XML data
    public static String postXml(String url, Map<String, Object> headers, String xml) throws IOException {
        RequestBody requestBody = RequestBody.create(MediaType.parse("application/xml"), xml);
        Request.Builder builder = new Request.Builder().url(url).post(requestBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        Response response = client.newCall(request).execute();
        return response.body().string();
    }

    // POST request with x-www-form-urlencoded data
    public static String postUrlEncoded(String url, Map<String, Object> headers, Map<String, Object> params) throws IOException {
        FormBody.Builder formBuilder = new FormBody.Builder();
        addParams(formBuilder, params);
        RequestBody requestBody = formBuilder.build();
        Request.Builder builder = new Request.Builder().url(url).post(requestBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        Response response = client.newCall(request).execute();
        return response.body().string();
    }

    // POST request with multipart/form-data
    public static String postMultipart(String url, Map<String, Object> headers, Map<String, Object> params, Map<String, File> files) throws IOException {
        MultipartBody.Builder multipartBuilder = new MultipartBody.Builder().setType(MultipartBody.FORM);
        addParams(multipartBuilder, params);
        addFiles(multipartBuilder, files);
        RequestBody requestBody = multipartBuilder.build();
        Request.Builder builder = new Request.Builder().url(url).post(requestBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        Response response = client.newCall(request).execute();
        return response.body().string();
    }

    // POST request with octet-stream data
    public static String postOctetStream(String url, Map<String, Object> headers, byte[] data) throws IOException {
        RequestBody requestBody = RequestBody.create(MediaType.parse("application/octet-stream"), data);
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

    // Helper method to add files to the multipart builder
    private static void addFiles(MultipartBody.Builder builder, Map<String, File> files) {
        if (files != null) {
            for (Map.Entry<String, File> entry : files.entrySet()) {
                File file = entry.getValue();
                String fileName = file.getName();
                String mimeType = getMimeType(fileName);
                RequestBody fileBody = RequestBody.create(MediaType.parse(mimeType), file);
                builder.addFormDataPart(entry.getKey(), fileName, fileBody);
            }
        }
    }

    // Helper method to get the MIME type of a file based on its extension
    private static String getMimeType(String fileName) {
        String extension = "";
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
            extension = fileName.substring(dotIndex + 1).toLowerCase();
        }
        switch (extension) {
            case "txt":
                return "text/plain";
            case "pdf":
                return "application/pdf";
            case "jpg":
            case "jpeg":
                return "image/jpeg";
            case "png":
                return "image/png";
            case "gif":
                return "image/gif";
            case "mp4":
                return "video/mp4";
            case "mp3":
                return "audio/mpeg";
            default:
                return "application/octet-stream";
        }
    }

    // Example usage
    public static void main(String[] args) throws IOException {
        String url = "https://...";
        
        // GET request
        String response1 = HttpUtils.get(url, null);

        // POST request with form data
        Map<String, Object> params2 = Map.of("username", "test", "password", "123456");
        String response2 = HttpUtils.postForm(url, null, params2);

        // POST request with JSON data
        String json3 = "{\"name\":\"test\",\"age\":18}";
        String response3 = HttpUtils.postJson(url, null, json3);

        // POST request with XML data
        String xml4 = "<root><name>test</name><age>18</age></root>";
        String response4 = HttpUtils.postXml(url, null, xml4);

        // POST request with x-www-form-urlencoded data
        Map<String, Object> params5 = Map.of("username", "test", "password", "123456");
        String response5 = HttpUtils.postUrlEncoded(url, null, params5);

        // POST request with multipart/form-data
        Map<String, Object> params6 = Map.of("username", "test", "password", "123456");
        Map<String, File> files6 = Map.of("file", new File("test.txt"));
        String response6 = HttpUtils.postMultipart(url, null, params6, files6);

        // POST request with octet-stream data
        byte[] data7 = new byte[]{0x01, 0x02};
        String response7 = HttpUtils.postOctetStream(url, null, data7);
    }
}
```
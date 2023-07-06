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
        return executeRequest(request);
    }

    // POST request with form data
    public static String postForm(String url, Map<String, Object> headers, Map<String, Object> params) throws IOException {
        FormBody.Builder formBuilder = new FormBody.Builder();
        addParams(formBuilder, params);
        RequestBody formBody = formBuilder.build();
        Request.Builder builder = new Request.Builder().url(url).post(formBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        return executeRequest(request);
    }

    // POST request with JSON data
    public static String postJson(String url, Map<String, Object> headers, String json) throws IOException {
        RequestBody requestBody = RequestBody.create(MediaType.parse("application/json"), json);
        Request.Builder builder = new Request.Builder().url(url).post(requestBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        return executeRequest(request);
    }

    // POST request with XML data
    public static String postXml(String url, Map<String, Object> headers, String xml) throws IOException {
        RequestBody requestBody = RequestBody.create(MediaType.parse("application/xml"), xml);
        Request.Builder builder = new Request.Builder().url(url).post(requestBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        return executeRequest(request);
    }

    // POST request with x-www-form-urlencoded data
    public static String postUrlEncoded(String url, Map<String, Object> headers, Map<String, Object> params) throws IOException {
        FormBody.Builder formBuilder = new FormBody.Builder();
        addParams(formBuilder, params);
        RequestBody requestBody = formBuilder.build();
        Request.Builder builder = new Request.Builder().url(url).post(requestBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        return executeRequest(request);
    }

    // POST request with multipart/form-data
    public static String postMultipart(String url, Map<String, Object> headers, Map<String, Object> params) throws IOException {
        MultipartBody.Builder multipartBuilder = new MultipartBody.Builder().setType(MultipartBody.FORM);
        addParams(multipartBuilder, params);
        RequestBody requestBody = multipartBuilder.build();
        Request.Builder builder = new Request.Builder().url(url).post(requestBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        return executeRequest(request);
    }

    // POST request with application/octet-stream data
    public static String postOctetStream(String url, Map<String, Object> headers, File file) throws IOException {
        RequestBody requestBody = RequestBody.create(MediaType.parse("application/octet-stream"), file);
        Request.Builder builder = new Request.Builder().url(url).post(requestBody);
        addHeaders(builder, headers);
        Request request = builder.build();
        return executeRequest(request);
    }

    // Helper method to add headers to the request builder
    private static void addHeaders(Request.Builder builder, Map<String, Object> headers) {
        if (headers != null) {
            for (Map.Entry<String, Object> entry : headers.entrySet()) {
                builder.addHeader(entry.getKey(), String.valueOf(entry.getValue()));
            }
        }
    }

    // Helper method to add parameters to the form or multipart builder
    private static void addParams(FormBody.Builder formBuilder, Map<String, Object> params) {
        if (params != null) {
            for (Map.Entry<String, Object> entry : params.entrySet()) {
                formBuilder.add(entry.getKey(), String.valueOf(entry.getValue()));
            }
        }
    }

    private static void addParams(MultipartBody.Builder multipartBuilder, Map<String, Object> params) {
        if (params != null) {
            for (Map.Entry<String, Object> entry : params.entrySet()) {
                if (entry.getValue() instanceof File) {
                    File file = (File) entry.getValue();
                    multipartBuilder.addFormDataPart(entry.getKey(), file.getName(), RequestBody.create(MediaType.parse("application/octet-stream"), file));
                } else {
                    multipartBuilder.addFormDataPart(entry.getKey(), String.valueOf(entry.getValue()));
                }
            }
        }
    }

    // Helper method to execute the request and handle exceptions
    private static String executeRequest(Request request) throws IOException {
        Response response = null;
        try {
            response = client.newCall(request).execute();
            return response.body().string();
        } catch (IOException e) {
            throw e;
        } finally {
            if (response != null) {
                response.close();
            }
        }
    }
}

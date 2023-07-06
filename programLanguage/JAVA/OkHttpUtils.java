import okhttp3.*;

import java.io.IOException;
import java.util.Map;

public class OkHttpUtils {
    private static final MediaType MEDIA_TYPE_JSON = MediaType.parse("application/json; charset=utf-8");
    private static final MediaType MEDIA_TYPE_XML = MediaType.parse("application/xml; charset=utf-8");
    private static final MediaType MEDIA_TYPE_FORM = MediaType.parse("application/x-www-form-urlencoded; charset=utf-8");
    private static final MediaType MEDIA_TYPE_MULTIPART = MediaType.parse("multipart/form-data; charset=utf-8");
    private static final MediaType MEDIA_TYPE_OCTET_STREAM = MediaType.parse("application/octet-stream; charset=utf-8");
    private static final MediaType MEDIA_TYPE_TEXT = MediaType.parse("text/plain; charset=utf-8");
    private static final MediaType MEDIA_TYPE_IMAGE = MediaType.parse("image/*; charset=utf-8");
    private static final MediaType MEDIA_TYPE_VIDEO = MediaType.parse("video/*; charset=utf-8");
    private static final MediaType MEDIA_TYPE_AUDIO = MediaType.parse("audio/*; charset=utf-8");

    private OkHttpClient client;

    public OkHttpUtils() {
        client = new OkHttpClient();
    }

    public String get(String url, Map<String, Object> headers, Map<String, Object> params, String contentType) throws IOException {
        Request request = buildRequest(url, headers, params, contentType).get().build();
        return executeRequest(request);
    }

    public String post(String url, Map<String, Object> headers, Map<String, Object> params, String contentType) throws IOException {
        Request request = buildRequest(url, headers, params, contentType).post(buildRequestBody(params, contentType)).build();
        return executeRequest(request);
    }

    public String postMultipart(String url, Map<String, Object> headers, Map<String, Object> params) throws IOException {
        MultipartBody.Builder builder = new MultipartBody.Builder().setType(MultipartBody.FORM);
        for (Map.Entry<String, Object> entry : params.entrySet()) {
            if (entry.getValue() instanceof byte[]) {
                builder.addFormDataPart(entry.getKey(), null, RequestBody.create(MEDIA_TYPE_OCTET_STREAM, (byte[]) entry.getValue()));
            } else {
                builder.addFormDataPart(entry.getKey(), entry.getValue().toString());
            }
        }
        Request request = buildRequest(url, headers, params, "multipart/form-data").post(builder.build()).build();
        return executeRequest(request);
    }

    private Request.Builder buildRequest(String url, Map<String, Object> headers, Map<String, Object> params, String contentType) {
        Request.Builder builder = new Request.Builder().url(url);
        if (headers != null && !headers.isEmpty()) {
            for (Map.Entry<String, Object> entry : headers.entrySet()) {
                builder.addHeader(entry.getKey(), entry.getValue().toString());
            }
        }
        if (contentType != null) {
            switch (contentType.toLowerCase()) {
                case "application/json":
                    builder.addHeader("Content-Type", "application/json");
                    break;
                case "application/xml":
                    builder.addHeader("Content-Type", "application/xml");
                    break;
                case "application/x-www-form-urlencoded":
                    builder.addHeader("Content-Type", "application/x-www-form-urlencoded");
                    break;
                case "multipart/form-data":
                    builder.addHeader("Content-Type", "multipart/form-data");
                    break;
                case "application/octet-stream":
                    builder.addHeader("Content-Type", "application/octet-stream");
                    break;
                case "text":
                    builder.addHeader("Content-Type", "text/plain");
                    break;
                case "image":
                    builder.addHeader("Content-Type", "image/*");
                    break;
                case "video":
                    builder.addHeader("Content-Type", "video/*");
                    break;
                case "audio":
                    builder.addHeader("Content-Type", "audio/*");
                    break;
                default:
                    break;
            }
        }
        return builder;
    }

    private RequestBody buildRequestBody(Map<String, Object> params, String contentType) {
        if (params == null || params.isEmpty()) {
            return null;
        }
        switch (contentType.toLowerCase()) {
            case "application/json":
                return RequestBody.create(MEDIA_TYPE_JSON, JsonUtils.toJson(params));
            case "application/xml":
                return RequestBody.create(MEDIA_TYPE_XML, XmlUtils.toXml(params));
            case "application/x-www-form-urlencoded":
                StringBuilder sb = new StringBuilder();
                for (Map.Entry<String, Object> entry : params.entrySet()) {
                    if (sb.length() > 0) {
                        sb.append("&");
                    }
                    sb.append(entry.getKey()).append("=").append(entry.getValue().toString());
                }
                return RequestBody.create(MEDIA_TYPE_FORM, sb.toString());
            default:
                return null;
        }
    }

    private String executeRequest(Request request) throws IOException {
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("Unexpected code " + response);
            }
            ResponseBody responseBody = response.body();
            if (responseBody == null) {
                return null;
            }
            return responseBody.string();
        }
    }
}

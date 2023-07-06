好的，以下是使用OkHttp实现这个功能的代码：

```java
import okhttp3.*;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.util.Map;

@SpringBootApplication
@RestController
public class FileUploadApplication {

    private final OkHttpClient httpClient = new OkHttpClient();

    @PostMapping("/forward")
    public String forwardRequest(@RequestBody RequestData requestData) throws IOException {
        // Create a multipart request builder
        MultipartBody.Builder builder = new MultipartBody.Builder()
                .setType(MultipartBody.FORM);

        // Add parameters to the request body
        for (Map.Entry<String, Object> entry : requestData.getParams().entrySet()) {
            builder.addFormDataPart(entry.getKey(), entry.getValue().toString());
        }

        // Add file to the request body
        File file = new File(requestData.getFile());
        builder.addFormDataPart("file", file.getName(),
                RequestBody.create(MediaType.parse("application/octet-stream"), file));

        // Create a request object with the provided URL and headers
        Request.Builder requestBuilder = new Request.Builder()
                .url(requestData.getUrl());
        for (Map.Entry<String, Object> entry : requestData.getHeader().entrySet()) {
            requestBuilder.header(entry.getKey(), entry.getValue().toString());
        }
        Request request = requestBuilder.post(builder.build()).build();

        // Send the request and get the response
        Response response = httpClient.newCall(request).execute();

        return response.body().string();
    }

    public static void main(String[] args) {
        SpringApplication.run(FileUploadApplication.class, args);
    }

}
```

这个代码中，我们定义了一个`forwardRequest`方法，用于接收包含文件的请求，并将其转发到指定的URL。该方法使用OkHttp库来发送请求，并使用`RequestData`类来封装请求数据。在方法中，我们首先将请求头和参数转换为OkHttp的`Request.Builder`对象，并将文件作为一个multipart请求体添加到请求中。然后，我们创建一个`Request`对象并使用OkHttp的`OkHttpClient`来发送请求，并返回响应体的内容。

希望这可以帮助到您！
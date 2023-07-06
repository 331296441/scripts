好的，以下是使用Spring Boot实现这个功能的代码：

```java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

@SpringBootApplication
@RestController
public class FileUploadApplication {

    @PostMapping("/forward")
    public ResponseEntity<byte[]> forwardRequest(@RequestBody RequestData requestData) throws URISyntaxException, IOException {
        // Create a RestTemplate object
        RestTemplate restTemplate = new RestTemplate();

        // Create a RequestEntity object from the request data
        HttpHeaders headers = new HttpHeaders();
        for (String key : requestData.getHeader().keySet()) {
            headers.add(key, requestData.getHeader().get(key).toString());
        }
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        for (String key : requestData.getParams().keySet()) {
            body.add(key, requestData.getParams().get(key));
        }
        body.add("file", new FileSystemResource(new File(requestData.getFile())));

        RequestEntity<MultiValueMap<String, Object>> requestEntity = new RequestEntity<>(body, headers, HttpMethod.POST, new URI(requestData.getUrl()));

        // Send the request and get the response
        ResponseEntity<byte[]> responseEntity = restTemplate.exchange(requestEntity, byte[].class);

        return responseEntity;
    }

    public static void main(String[] args) {
        SpringApplication.run(FileUploadApplication.class, args);
    }

}
```

这个代码中，我们定义了一个`forwardRequest`方法，用于接收包含文件的请求，并将其转发到指定的URL。该方法使用Spring Boot提供的`RestTemplate`类来发送请求，并使用`RequestData`类来封装请求数据。在方法中，我们首先将请求头和参数转换为`HttpHeaders`和`MultiValueMap`对象，并将文件作为一个`FileSystemResource`对象添加到参数中。然后，我们使用这些对象创建一个`RequestEntity`对象，并使用`RestTemplate`发送请求并返回响应。

请注意，为了使该代码能够正常运行，您需要添加以下依赖项到您的项目中：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web-services</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-validation</artifactId>
</dependency>
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-io</artifactId>
    <version>1.3.2</version>
</dependency>
```

希望这可以帮助您完成您的项目。如果您有任何问题或需要进一步的帮助，请告诉我。
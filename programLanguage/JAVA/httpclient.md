以下是使用Java发送multipart/form-data类型参数的示例代码：

```java
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.UUID;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

public class HttpClientConnectionExample {

    public static void main(String[] args) throws IOException {
        // Set the URL to send the request to
        String url = "{{url}}";

        // Set the file path of the file to upload
        String filePath = "{{file_path}}";

        // Set the name of the file to upload
        String fileName = "{{file_name}}";

        // Set the name of the form field to use for the file upload
        String formField = "{{form_field}}";

        // Create a boundary string for the multipart/form-data request
        String boundary = UUID.randomUUID().toString();

        // Create the request body
        HttpEntity requestEntity = MultipartEntityBuilder.create()
                .setMode(HttpMultipartMode.BROWSER_COMPATIBLE)
                .setBoundary(boundary)
                .addPart(formField, new FileBody(new File(filePath), ContentType.DEFAULT_BINARY, fileName))
                .build();

        // Create the HTTP POST request
        HttpPost postRequest = new HttpPost(url);
        postRequest.setEntity(requestEntity);

        // Send the request using HttpClientConnection
        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpResponse response = httpClient.execute(postRequest);

        // Print the response
        String responseBody = EntityUtils.toString(response.getEntity());
        System.out.println(responseBody);
    }

}
```

请注意，此示例假定您已经安装了Apache HttpClient库。如果您尚未安装，请根据您的项目和环境进行安装。



# java的httpclient发送application/x-www-form-urlencoded和multipart/form-data有什么区别，代码如何编写
在Java中使用HttpClient发送HTTP请求时，可以通过设置请求的Content-Type来指定发送的内容类型，从而实现发送application/x-www-form-urlencoded或multipart/form-data请求。区别：
1. 参数编码方式不同：application/x-www-form-urlencoded使用URL编码格式，而multipart/form-data使用多部分编码格式。
2. 参数封装方式不同：application/x-www-form-urlencoded将所有参数封装在请求主体中，multipart/form-data将参数和文件封装在不同的部分中。
 
下面是两种内容类型的请求代码示例：
1. 发送application/x-www-form-urlencoded请求：


```java
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.util.ArrayList;
import java.util.List;

public class FormUrlencodedExample {
    public static void main(String[] args) throws Exception {
        HttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("http://example.com/api");
// 设置请求参数        
        List<NameValuePair> params = new ArrayList<>();
        params.add(new BasicNameValuePair("username", "admin"));
        params.add(new BasicNameValuePair("password", "123456"));
        httpPost.setEntity(new UrlEncodedFormEntity(params));
// 发送请求        
        HttpResponse response = httpClient.execute(httpPost);
// 处理响应        
        HttpEntity entity = response.getEntity();
        String responseText = EntityUtils.toString(entity);
        System.out.println(responseText);
    }
}
```

2. 发送multipart/form-data请求：
```java
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.mime.MultipartEntityBuilder;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.File;

public class MultipartFormDataExample {
    public static void main(String[] args) throws Exception {
        HttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("http://example.com/api");
// 设置请求参数        
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.addTextBody("username", "admin");
        builder.addTextBody("password", "123456");
        builder.addBinaryBody("file", new File("path/to/file"));
        httpPost.setEntity(builder.build());
// 发送请求        
        HttpResponse response = httpClient.execute(httpPost);
// 处理响应        
        HttpEntity entity = response.getEntity();
        String responseText = EntityUtils.toString(entity);
        System.out.println(responseText);
    }
}
```

以上示例中，分别使用了`UrlEncodedFormEntity`和`MultipartEntityBuilder`来设置请求参数，并将其设置到`HttpPost`请求中。然后通过`HttpClient`执行请求，并处理响应。根据需要选择适合的内容类型和相应的参数封装方式。
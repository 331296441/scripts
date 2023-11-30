要在Spring Boot应用中调用远程的PUT接口发送CSV文件，你可以使用Java的HttpURLConnection或者HttpClient来实现。下面是一个示例代码，展示了如何生成该请求并发送CSV文件：

```java
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.FileEntity;
import org.apache.http.impl.client.HttpClients;

import java.io.File;
import java.io.IOException;

public class RemotePutRequest {
    public static void main(String[] args) {
        String url = "http://example.com/put-endpoint"; // 远程PUT接口的URL
        String filePath = "/path/to/csv/file.csv"; // CSV文件的路径

        HttpClient httpClient = HttpClients.createDefault();
        HttpPut httpPut = new HttpPut(url);

        File csvFile = new File(filePath);
        HttpEntity fileEntity = new FileEntity(csvFile, ContentType.create("text/csv"));
        httpPut.setEntity(fileEntity);

        try {
            HttpResponse response = httpClient.execute(httpPut);
            // 处理响应
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

你需要将上述代码放入你的Spring Boot应用中的适当位置，并根据实际情况修改URL和CSV文件的路径。这段代码使用Apache HttpClient库来发送PUT请求，并将CSV文件作为请求的实体。
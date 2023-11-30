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



如果你只有CSV数据而不是实际的CSV文件，并且不希望在服务端生成该数据，你可以使用OkHttp的RequestBody来直接发送CSV数据作为请求的主体。下面是一个示例代码：

```java
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import java.io.IOException;

public class RemotePutRequest {
    public static void main(String[] args) {
        String url = "http://example.com/put-endpoint"; // 远程PUT接口的URL
        String csvData = "your,csv,data,here"; // CSV数据

        OkHttpClient client = new OkHttpClient();

        RequestBody requestBody = RequestBody.create(MediaType.parse("text/csv"), csvData);

        Request request = new Request.Builder()
                .url(url)
                .put(requestBody)
                .build();

        try {
            Response response = client.newCall(request).execute();
            // 处理响应
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

你需要将上述代码放入你的Spring Boot应用中的适当位置，并根据实际情况修改URL和CSV数据。这段代码使用OkHttp库来发送PUT请求，并将CSV数据直接作为请求的主体。


CSV数据是以逗号分隔的文本文件，每一行表示一条记录，每个字段之间用逗号分隔。根据你提供的信息，假设每行有三列，分别是name、id和script。

下面是一个示例函数，用于生成任意多行的CSV数据：

```java
import java.util.ArrayList;
import java.util.List;

public class CSVGenerator {
    public static void main(String[] args) {
        List<String[]> data = new ArrayList<>();
        data.add(new String[]{"John", "1", "Script 1"});
        data.add(new String[]{"Jane", "2", "Script 2"});

        String csvData = generateCSV(data);
        System.out.println(csvData);
    }

    public static String generateCSV(List<String[]> data) {
        StringBuilder csv = new StringBuilder();

        for (String[] row : data) {
            for (int i = 0; i < row.length; i++) {
                csv.append(row[i]);
                if (i < row.length - 1) {
                    csv.append(",");
                }
            }
            csv.append("\n");
        }

        return csv.toString();
    }
}
```

在上述示例中，我们使用一个`List<String[]>`来存储每行的数据。你可以根据需要添加任意多行数据。`generateCSV`函数接受这个数据列表，并将其转换为CSV格式的字符串。

你可以将`generateCSV`函数放入你的Spring Boot应用中，并根据需要调用它来生成CSV数据。
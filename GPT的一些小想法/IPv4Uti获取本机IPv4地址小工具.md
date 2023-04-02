以下是一个获取本地IPv4地址（排除127.0.0.1）的Java工具类的示例代码：

```java
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

public class LocalIPAddress {

    public static String getLocalIPAddress() throws SocketException {
        Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();
        while (networkInterfaces.hasMoreElements()) {
            NetworkInterface networkInterface = networkInterfaces.nextElement();
            Enumeration<InetAddress> inetAddresses = networkInterface.getInetAddresses();
            while (inetAddresses.hasMoreElements()) {
                InetAddress inetAddress = inetAddresses.nextElement();
                if (!inetAddress.isLoopbackAddress() && inetAddress.getAddress().length == 4) {
                    return inetAddress.getHostAddress();
                }
            }
        }
        return null;
    }
}
```

使用示例：

```java
public static void main(String[] args) throws SocketException {
    String localIPAddress = LocalIPAddress.getLocalIPAddress();
    System.out.println(localIPAddress);
}
```

该工具类使用Java的`NetworkInterface`和`InetAddress`类来获取本地网络接口和IP地址。它遍历所有网络接口和IP地址，并返回第一个非回环地址的IPv4地址。如果没有找到IPv4地址，则返回`null`。
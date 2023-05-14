# 在Debian 11系统中，您可以使用以下命令来初始化一个Spring Boot项目：

1. 安装Java和Maven：

``` shell
sudo apt update
sudo apt install default-jdk maven
```

2. 创建一个新的Spring Boot项目：

``` shell
mvn archetype:generate -DgroupId=com.example -DartifactId=myproject -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

上面的命令将在当前目录下创建一个名为`myproject`的Spring Boot项目。

3. 进入项目目录并打开项目文件：

``` shell
cd myproject
vim pom.xml
```

4. 修改`pom.xml`文件以添加Spring Boot相关依赖：

```xml
<dependencies>
    <!-- Spring Boot Starter Web -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    
    <!-- Spring Boot DevTools（可选） -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-devtools</artifactId>
        <optional>true</optional>
    </dependency>
</dependencies>
```

5. 编写一个简单的Rest API：

``` shell
vim src/main/java/com/wood/myproject/MyController.java
```

```java
package com.example.myproject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MyController {
    
    @GetMapping("/")
    public String hello() {
        return "Hello, world!";
    }
}
```

6. 启动应用程序：

``` shell
mvn spring-boot:run
```

7. 测试API：

在浏览器中访问`http://localhost:8080/`，应该会看到“Hello, world!”的消息。

这就是使用命令方式初始化Spring Boot Demo项目的步骤。
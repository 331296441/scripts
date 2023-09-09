要创建一个有多个模块的Spring Boot项目，你可以按照以下步骤进行操作：

1. 创建一个新的Spring Boot项目。你可以使用Spring Initializr（https://start.spring.io/）来方便地生成项目的基本结构。

2. 在项目结构中创建三个模块文件夹：`automatic-server`、`automatic-agent`和`automatic-common`。

3. 在`automatic-common`模块中创建你的公共组件，并确保它不会独立运行。这可以通过将`automatic-common`模块的依赖范围设置为`provided`来实现。在`pom.xml`文件中对应的依赖项上添加以下配置：
```xml
<dependency>
    <groupId>com.example</groupId>
    <artifactId>automatic-common</artifactId>
    <version>1.0.0</version>
    <scope>provided</scope>
</dependency>
```

4. 在`automatic-server`和`automatic-agent`模块中，通过在`pom.xml`文件中添加对`automatic-common`模块的依赖来包含公共组件。在对应的`pom.xml`文件中添加以下配置：
```xml
<dependency>
    <groupId>com.example</groupId>
    <artifactId>automatic-common</artifactId>
    <version>1.0.0</version>
</dependency>
```

5. 确保在服务器和代理模块的打包过程中，默认包含`automatic-common`模块的所有文件。通过使用Maven的`maven-assembly-plugin`插件来实现这一点。在对应的`pom.xml`文件中添加以下配置：
```xml
<build>
    <plugins>
        <plugin>
            <artifactId>maven-assembly-plugin</artifactId>
            <configuration>
                <descriptorRefs>
                    <descriptorRef>jar-with-dependencies</descriptorRef>
                </descriptorRefs>
                <archive>
                    <manifest>
                        <addClasspath>true</addClasspath>
                        <mainClass>com.example.Main</mainClass> <!-- 指定主类 -->
                    </manifest>
                </archive>
            </configuration>
            <executions>
                <execution>
                    <id>make-assembly</id>
                    <phase>package</phase>
                    <goals>
                        <goal>single</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

6. 现在你可以在`automatic-server`和`automatic-agent`模块中开发你的代码，它们将默认包含`automatic-common`模块中的所有文件。

这样，你就创建了一个具有多个模块的Spring Boot项目，并确保`automatic-server`和`automatic-agent`模块默认包含了`automatic-common`模块中的所有文件。你可以根据自己的需求添加进一步的功能和组件。
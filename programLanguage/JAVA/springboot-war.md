# jiar包和war包的区别，springboot能否使用war包打包

JAR和WAR都是Java Web应用程序的打包格式，但它们有不同的用途。

JAR（Java Archive）是一种用于打包Java类文件、资源文件和元数据的格式。JAR文件通常用于打包Java库和应用程序，可以在Java虚拟机上直接运行。

WAR（Web Application Archive）是一种用于打包Web应用程序的格式。WAR文件包含了Web应用程序的所有内容，包括JSP、HTML、CSS、JavaScript、Java类文件、配置文件和其他资源文件。WAR文件可以部署到Web服务器上，例如Tomcat、Jetty等。

Spring Boot可以使用WAR包打包Web应用程序，只需要将项目的打包方式从JAR改为WAR即可。在pom.xml文件中，将打包方式设置为war即可：

```xml
<packaging>war</packaging>
```

然后在Spring Boot的启动类上添加`SpringBootServletInitializer`类的继承，并重写`configure`方法：

```java
@SpringBootApplication
public class MyApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(MyApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(MyApplication.class, args);
    }
}
```

这样就可以使用WAR包部署Spring Boot应用程序了。
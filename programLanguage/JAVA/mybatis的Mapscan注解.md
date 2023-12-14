# 问题
mybatis@MapperScan的注解和用法
# 答案
`@MapperScan`是MyBatis框架中的一个注解，用于扫描指定包下的Mapper接口，并将其注册为Spring的Bean。

使用`@MapperScan`注解可以简化MyBatis的配置，避免手动一个个地在Spring配置文件中配置Mapper接口。

下面是`@MapperScan`注解的用法示例：

```java
@Configuration
@MapperScan("com.example.mapper") // 指定要扫描的Mapper接口所在的包
public class MyBatisConfig {
    // MyBatis相关配置
}
```

在上面的示例中，`@MapperScan`注解被用于一个Spring的配置类上，通过指定要扫描的Mapper接口所在的包，自动将这些Mapper接口注册为Spring的Bean。

需要注意的是，`@MapperScan`注解需要与`@Configuration`注解一起使用，以确保它被正确地识别为一个配置类。

另外，`@MapperScan`注解还支持其他属性，例如`basePackages`、`basePackageClasses`和`markerInterface`等，用于更精确地指定要扫描的Mapper接口。你可以根据自己的需求选择合适的属性来使用。
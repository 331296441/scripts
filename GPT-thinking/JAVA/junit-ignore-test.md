# Junit 跳过测试

在 JUnit 中，可以使用 `@Ignore` 注解来忽略单个测试用例。如果要批量忽略多个测试用例，可以使用 `@Ignore` 注解加在测试类上面，这样该测试类中的所有测试用例都会被忽略。以下是一个示例：

```java
import org.junit.Ignore;
import org.junit.Test;

@Ignore("All test cases in this class are ignored")
public class MyTest {
    @Test
    public void test1() {
        // ...
    }

    @Test
    public void test2() {
        // ...
    }

    @Test
    public void test3() {
        // ...
    }
}
```

在上面的示例中，`@Ignore` 注解加在了 `MyTest` 类上面，这样该类中的所有测试用例都会被忽略。如果你只想忽略某个测试类中的部分测试用例，可以在这些测试用例上分别加上 `@Ignore` 注解。


在 Maven 的 POM 文件中，可以使用 `<exclude>` 标签来排除某些测试用例。如果你想批量排除多个测试用例，可以在 `<exclude>` 标签中使用通配符来匹配多个测试用例。以下是一个示例：

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>3.0.0-M5</version>
            <configuration>
                <excludes>
                    <exclude>**/*Test.java</exclude>
                    <exclude>**/*IntegrationTest.java</exclude>
                </excludes>
            </configuration>
        </plugin>
    </plugins>
</build>
```

在上面的示例中，`<excludes>` 标签中使用了两个 `<exclude>` 标签来排除所有以 `Test` 结尾和 `IntegrationTest` 结尾的测试用例。这样，这些测试用例就不会被执行了。

请注意，这种方法只是排除了测试用例的执行，但是这些测试用例仍然会被编译和打包到最终的构建结果中。如果你想完全移除这些测试用例，可以使用 `<testSourceDirectory>` 标签来指定测试代码的目录，并将不需要的测试用例从该目录中删除。
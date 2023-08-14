当使用TestNG进行数据驱动的测试时，可以使用`@DataProvider`注解来提供测试数据，并使用`@Test`注解来标记测试方法。以下是一个包含所有类型注解的TestNG测试用例模板：

```java
import org.testng.annotations.*;

public class DataDrivenTest {

    @DataProvider(name = "testData")
    public Object[][] testData() {
        // 返回测试数据的二维数组
        return new Object[][] {
            {"Test Data 1"},
            {"Test Data 2"},
            {"Test Data 3"}
        };
    }

    @BeforeClass
    public void setUp() {
        // 在测试类中的所有测试方法之前执行的设置代码
    }

    @BeforeMethod
    public void beforeMethod() {
        // 在每个测试方法之前执行的设置代码
    }

    @Test(dataProvider = "testData")
    public void testMethod(String testData) {
        // 测试方法的代码，使用提供的测试数据
        System.out.println("Test Data: " + testData);
    }

    @AfterMethod
    public void afterMethod() {
        // 在每个测试方法之后执行的清理代码
    }

    @AfterClass
    public void tearDown() {
        // 在测试类中的所有测试方法之后执行的清理代码
    }

    @BeforeSuite
    public void beforeSuite() {
        // 在测试套件之前执行的设置代码
    }

    @AfterSuite
    public void afterSuite() {
        // 在测试套件之后执行的清理代码
    }
}
```

在上面的示例中，我们定义了一个名为`DataDrivenTest`的测试类。`@DataProvider`注解用于提供测试数据，`@BeforeClass`和`@AfterClass`注解分别在测试类中的所有测试方法之前和之后执行设置和清理代码。`@BeforeMethod`和`@AfterMethod`注解分别在每个测试方法之前和之后执行设置和清理代码。`@BeforeSuite`和`@AfterSuite`注解分别在测试套件之前和之后执行设置和清理代码。

您可以根据需要修改示例代码来适应您的测试场景。使用`@DataProvider`注解提供适当的测试数据，并在`@Test`注解中使用该数据进行测试。确保在测试方法中使用提供的测试数据进行适当的断言和验证。
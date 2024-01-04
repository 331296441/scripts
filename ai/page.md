# pagehelper 使用注意

需要在查询前写好startpage

这个错误是由于在`com.fintech.automatic.module.fundloss.service.impl.TestCaseServiceImpl`类的`listTestCaseByPlan`方法中发生了类型转换错误。

根据错误信息，可以看到发生了`java.util.ArrayList`到`com.github.pagehelper.Page`的类型转换错误。这意味着你尝试将一个`ArrayList`对象转换为`Page`对象，但实际上它们是不兼容的类型。

要解决这个问题，你需要检查`listTestCaseByPlan`方法的实现，并确保在进行类型转换之前，对象的类型是正确的。

可能的解决方案之一是，确保在调用`listTestCaseByPlan`方法之前，你使用了适当的方法来获取`com.github.pagehelper.Page`对象，而不是`java.util.ArrayList`对象。

例如，你可以使用`PageHelper`工具类来进行分页查询，并确保返回的结果是`Page`对象。以下是一个示例：

```java
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

public class TestCaseServiceImpl implements TestCaseService {
    private final TestCaseMapper testCaseMapper;

    public TestCaseServiceImpl(TestCaseMapper testCaseMapper) {
        this.testCaseMapper = testCaseMapper;
    }

    public Page<TestCase> listTestCaseByPlan(int planId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<TestCase> testCaseList = testCaseMapper.listTestCaseByPlan(planId);
        return (Page<TestCase>) testCaseList;
    }
}
```

在上面的示例中，我们使用`PageHelper.startPage`方法来设置分页参数，并确保返回的结果是`Page<TestCase>`对象。然后，我们将`testCaseList`转换为`Page<TestCase>`对象进行返回。

请注意，具体的解决方案可能因你的代码和业务逻辑而有所不同。你需要根据实际情况进行调整和修改，以确保类型转换的正确性。
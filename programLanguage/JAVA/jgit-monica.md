# 以下是一个简单的Spring Boot代码示例，可以读取给定的Git地址和分支名，并使用JGit库来获取分支和master之间的差异。然后，使用Spring Boot的AOP功能来拦截Controller方法的调用，并记录每个调用所涉及的SQL语句。最后，将涉及差异的Controller和SQL语句输出到控制台。

```java
import org.eclipse.jgit.api.Git;
import org.eclipse.jgit.diff.DiffEntry;
import org.eclipse.jgit.diff.DiffFormatter;
import org.eclipse.jgit.lib.ObjectId;
import org.eclipse.jgit.lib.ObjectReader;
import org.eclipse.jgit.lib.Repository;
import org.eclipse.jgit.revwalk.RevCommit;
import org.eclipse.jgit.revwalk.RevWalk;
import org.eclipse.jgit.treewalk.CanonicalTreeParser;
import org.springframework.aop.interceptor.AbstractMonitoringInterceptor;
import org.springframework.stereotype.Component;
import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Component
public class GitDiffInterceptor extends AbstractMonitoringInterceptor {

    private final Git git;

    public GitDiffInterceptor(Git git) {
        this.git = git;
    }

    @Override
    protected Object invokeUnderTrace(HttpServletRequest request, Object target, Object... args) throws Exception {
        // 获取当前分支和master之间的差异
        Repository repository = git.getRepository();
        ObjectId head = repository.resolve("HEAD");
        ObjectId master = repository.resolve("master");
        List<DiffEntry> diffs = getDiffs(repository, head, master);

        // 获取所有Controller类的名称
        List<String> controllerNames = getControllerNames();

        // 拦截Controller方法的调用并记录SQL语句
        List<String> sqlStatements = new ArrayList<>();
        for (String controllerName : controllerNames) {
            Object result = monitorInvocation(() -> super.invokeUnderTrace(request, target, args), controllerName);
            if (result instanceof String) {
                sqlStatements.add((String) result);
            }
        }

        // 输出涉及差异的Controller和SQL语句
        for (DiffEntry diff : diffs) {
            String oldPath = diff.getOldPath();
            String newPath = diff.getNewPath();
            if (isControllerFile(oldPath) || isControllerFile(newPath)) {
                System.out.println("Controller file changed: " + newPath);
                System.out.println("Affected SQL statements:");
                for (String sqlStatement : sqlStatements) {
                    if (sqlStatement.contains(getControllerName(newPath))) {
                        System.out.println(sqlStatement);
                    }
                }
            } else if (isMybatisFile(oldPath) || isMybatisFile(newPath)) {
                System.out.println("Mybatis file changed: " + newPath);
                System.out.println("Affected SQL statements:");
                for (String sqlStatement : sqlStatements) {
                    if (sqlStatement.contains(getMybatisMapperName(newPath))) {
                        System.out.println(sqlStatement);
                    }
                }
            }
        }

        return null;
    }

    private List<DiffEntry> getDiffs(Repository repository, ObjectId head, ObjectId master) throws IOException {
        List<DiffEntry> diffs = new ArrayList<>();
        try (ObjectReader reader = repository.newObjectReader()) {
            CanonicalTreeParser oldTreeIter = new CanonicalTreeParser();
            oldTreeIter.reset(reader, master);
            CanonicalTreeParser newTreeIter = new CanonicalTreeParser();
            newTreeIter.reset(reader, head);
            try (Git git = new Git(repository)) {
                List<RevCommit> commits = git.log().addRange(master, head).call();
                for (RevCommit commit : commits) {
                    DiffFormatter formatter = new DiffFormatter(new ByteArrayOutputStream());
                    formatter.setRepository(repository);
                    formatter.format(commit.getParent(0), commit);
                    List<DiffEntry> commitDiffs = formatter.scan(oldTreeIter, newTreeIter);
                    diffs.addAll(commitDiffs);
                }
            }
        }
        return diffs;
    }

    private List<String> getControllerNames() {
        // TODO: 实现获取所有Controller类名称的逻辑
        return null;
    }

    private boolean isControllerFile(String filePath) {
        return filePath.endsWith("Controller.java");
    }

    private boolean isMybatisFile(String filePath) {
        return filePath.endsWith("Mapper.xml");
    }

    private String getControllerName(String filePath) {
        // TODO: 实现从文件路径中获取Controller类名称的逻辑
        return null;
    }

    private String getMybatisMapperName(String filePath) {
        // TODO: 实现从文件路径中获取Mybatis Mapper名称的逻辑
        return null;
    }
}
```

# 以下是获取所有Controller类名称的逻辑的代码示例：

```java
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.core.type.filter.AnnotationTypeFilter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

public class ControllerScanner {

    public static List<String> getControllerNames() {
        List<String> controllerNames = new ArrayList<>();
        ClassPathScanningCandidateComponentProvider scanner = new ClassPathScanningCandidateComponentProvider(false);
        scanner.addIncludeFilter(new AnnotationTypeFilter(Controller.class));
        scanner.addIncludeFilter(new AnnotationTypeFilter(RestController.class));
        for (BeanDefinition beanDefinition : scanner.findCandidateComponents("com.example")) {
            controllerNames.add(beanDefinition.getBeanClassName());
        }
        return controllerNames;
    }
}
```

该代码使用Spring的`ClassPathScanningCandidateComponentProvider`类扫描项目中所有带有`@Controller`或`@RestController`注解的类，并返回它们的类名列表。你需要将`com.example`替换为你的项目的根包名。


# 以下是从文件路径中获取Controller类名称的逻辑的代码示例：

```java
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class ControllerScanner {

    public static List<String> getControllerNamesFromPath(String path) {
        List<String> controllerNames = new ArrayList<>();
        File root = new File(path);
        if (root.isDirectory()) {
            scanDirectory(root, controllerNames);
        }
        return controllerNames;
    }

    private static void scanDirectory(File directory, List<String> controllerNames) {
        File[] files = directory.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isDirectory()) {
                    scanDirectory(file, controllerNames);
                } else if (file.isFile()) {
                    if (file.getName().endsWith(".java")) {
                        String className = getClassNameFromFile(file);
                        if (isControllerClass(className)) {
                            controllerNames.add(className);
                        }
                    }
                }
            }
        }
    }

    private static String getClassNameFromFile(File file) {
        String absolutePath = file.getAbsolutePath();
        String relativePath = absolutePath.substring(absolutePath.indexOf("src") + 4);
        return relativePath.replace(File.separator, ".").replace(".java", "");
    }

    private static boolean isControllerClass(String className) {
        try {
            Class<?> clazz = Class.forName(className);
            return clazz.isAnnotationPresent(org.springframework.stereotype.Controller.class)
                    || clazz.isAnnotationPresent(org.springframework.web.bind.annotation.RestController.class);
        } catch (ClassNotFoundException e) {
            return false;
        }
    }
}
```

该代码会递归扫描指定路径下的所有文件，筛选出以`.java`结尾的文件，并将其转换为类名。然后，通过反射检查类是否带有`@Controller`或`@RestController`注解，如果是，则将其添加到Controller类名列表中。你需要将`path`参数替换为你的文件路径。



# 以下是从文件路径中获取Mybatis Mapper名称的逻辑的代码示例：

```java
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class MapperScanner {

    public static List<String> getMapperNamesFromPath(String path) {
        List<String> mapperNames = new ArrayList<>();
        File root = new File(path);
        if (root.isDirectory()) {
            scanDirectory(root, mapperNames);
        }
        return mapperNames;
    }

    private static void scanDirectory(File directory, List<String> mapperNames) {
        File[] files = directory.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isDirectory()) {
                    scanDirectory(file, mapperNames);
                } else if (file.isFile()) {
                    if (file.getName().endsWith("Mapper.xml")) {
                        String mapperName = getMapperNameFromFile(file);
                        mapperNames.add(mapperName);
                    }
                }
            }
        }
    }

    private static String getMapperNameFromFile(File file) {
        String absolutePath = file.getAbsolutePath();
        String relativePath = absolutePath.substring(absolutePath.indexOf("src") + 4);
        return relativePath.replace(File.separator, ".").replace(".xml", "");
    }
}
```

该代码会递归扫描指定路径下的所有文件，筛选出以`Mapper.xml`结尾的文件，并将其转换为Mapper名称。你需要将`path`参数替换为你的文件路径。
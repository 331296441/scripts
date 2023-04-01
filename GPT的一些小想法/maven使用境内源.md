如果您不想保留官方源并全部使用中国境内的源，可以按照以下步骤操作：

1. 打开`settings.xml`文件。如果您没有该文件，请在`.m2`目录下创建一个，并将以下内容复制到其中：

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                              https://maven.apache.org/xsd/settings-1.0.0.xsd">
  <mirrors>
    <mirror>
      <id>aliyunmaven</id>
      <mirrorOf>*</mirrorOf>
      <name>阿里云公共仓库</name>
      <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
    <mirror>
        <id>mavencentral-china</id>
        <mirrorOf>central</mirrorOf>
        <name>Maven central China</name>
        <url>http://maven.aliyun.com/nexus/content/repositories/central/</url>
    </mirror>
    <mirror>
      <id>jcenter</id>
      <mirrorOf>*</mirrorOf>
      <name>jcenter</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>jdk-1.8</id>
      <activation>
        <activeByDefault>true</activeByDefault>
        <jdk>1.8</jdk>
      </activation>
      <properties>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
        <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
      </properties>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>jdk-1.8</activeProfile>
  </activeProfiles>
</settings>
```

2. 将`<mirror>`标签添加到`<mirrors>`元素中，以使用阿里云公共仓库和中国境内的其他镜像源。

3. 如果需要指定JDK版本，请将`<profiles>`和`<activeProfiles>`标签添加到文件中。这里的配置是使用JDK 1.8，可以根据需要进行更改。

4. 保存并关闭文件，重新运行`mvn`命令即可使用国内的Maven镜像源。

注意：使用国内镜像可能会存在依赖库更新不及时或缺失的问题。如果遇到依赖库下载不下来或者构建失败的情况，可以试着注释一下配置中的某些镜像源，或者将镜像源改回官方源进行尝试。
要在Ubuntu上安装ChromeDriver，可以按照以下步骤进行操作：

1. 打开终端。
2. 使用以下命令安装ChromeDriver的依赖项：

   ```bash
   sudo apt-get update
   sudo apt-get install -y unzip xvfb libxi6 libgconf-2-4
   ```

3. 在终端中使用以下命令下载ChromeDriver的最新版本：

   ```bash
   wget https://chromedriver.storage.googleapis.com/{{version}}/chromedriver_linux64.zip
   ```

   请将 `{{version}}` 替换为您想要下载的ChromeDriver版本号。您可以在[ChromeDriver官方网站](https://sites.google.com/a/chromium.org/chromedriver/downloads)上找到可用的版本号。

4. 使用以下命令解压缩下载的文件：

   ```bash
   unzip chromedriver_linux64.zip
   ```

5. 将解压缩后的ChromeDriver文件移动到系统的可执行路径中：

   ```bash
   sudo mv chromedriver /usr/local/bin/
   ```

6. 最后，使用以下命令验证ChromeDriver是否已成功安装：

   ```bash
   chromedriver --version
   ```

   如果成功安装，您将看到ChromeDriver的版本号。

现在，您已经成功在Ubuntu上安装了ChromeDriver。您可以在您的自动化测试脚本或其他需要使用ChromeDriver的应用程序中使用它。
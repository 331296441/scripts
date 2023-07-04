要在Docker中安装Redis，您可以按照以下步骤进行操作：

1. 首先，确保您已经安装了Docker。您可以在终端中运行以下命令来检查Docker是否已安装：

   ```bash
   docker --version
   ```

   如果您看到Docker的版本信息，则表示已经安装了Docker。否则，请根据您的操作系统安装Docker。

2. 接下来，使用以下命令从Docker Hub下载Redis镜像：

   ```bash
   docker pull redis
   ```

   这将从Docker Hub下载最新的Redis镜像。

3. 下载完成后，您可以使用以下命令来运行Redis容器：

   ```bash
   docker run --name my-redis -d -p 6379:6379 redis
   ```

   这将在后台运行一个名为"my-redis"的Redis容器，并将容器的6379端口映射到主机的6379端口。

4. 现在，您可以使用以下命令来验证Redis是否正在运行：

   ```bash
   docker ps
   ```

   如果您看到"my-redis"容器正在运行，则表示Redis已成功安装并正在运行。

您现在可以使用Redis客户端连接到Redis服务器，并开始使用Redis了。
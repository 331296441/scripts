要将一个 Docker 容器配置为始终重启，你可以使用 `--restart` 标志来指定重启策略。以下是一些常见的重启策略：

1. `no`：不重启容器（默认值）。
2. `on-failure`：只有在容器非正常退出时才重启。
3. `always`：无论容器如何退出，都始终重启。
4. `unless-stopped`：除非手动停止容器，否则始终重启。

要将容器配置为始终重启，可以使用以下命令：

```bash
docker run --restart=always {{容器名称}}
```

如果你已经在运行容器，可以使用以下命令来更新重启策略：

```bash
docker update --restart=always {{容器名称}}
```

此外，你还可以在 Docker Compose 文件中使用 `restart` 关键字来配置容器的重启策略。以下是一个示例：

```yaml
version: '3'
services:
  myservice:
    image: myimage
    restart: always
```

这将使 `myservice` 容器始终重启。

请注意，以上命令和配置适用于 Debian 系统上的 Docker。对于其他操作系统，可能会有一些差异，请根据你的操作系统进行相应的调整。
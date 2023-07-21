要在两台Linux服务器之间实现实时文件同步，您可以使用`rsync`结合`inotifywait`工具来实现。

`rsync`用于实现文件的同步，而`inotifywait`用于监视文件系统的更改事件。当文件发生更改时，`inotifywait`会触发一个事件，然后您可以使用`rsync`来将更改的文件同步到另一台服务器。

以下是一个示例的脚本，使用`rsync`和`inotifywait`实现实时文件同步：

```bash
#!/bin/bash

SOURCE_DIR="/path/to/source"
DESTINATION_DIR="/path/to/destination"
REMOTE_SERVER="user@remote-server"

# 启动inotifywait监视源目录的文件更改事件
inotifywait -m -r -e modify,create,delete,move "${SOURCE_DIR}" |
while read -r directory event file; do
    # 构建目标文件路径
    destination_file="${DESTINATION_DIR}${directory#${SOURCE_DIR}}/${file}"

    # 使用rsync将更改的文件同步到目标服务器
    rsync -avz --delete "${directory}/${file}" "${REMOTE_SERVER}:${destination_file}"
done
```

将上述脚本中的`/path/to/source`替换为源目录的路径，`/path/to/destination`替换为目标目录的路径，`user@remote-server`替换为远程服务器的用户名和地址。

这个脚本将监视源目录的文件更改事件，并使用`rsync`将更改的文件同步到目标目录。请确保在运行脚本之前安装了`rsync`和`inotify-tools`软件包。

请注意，实时文件同步可能会对系统资源产生一定的负载，因此请根据实际情况调整监视的频率和同步的方式。另外，建议在执行实时文件同步之前进行备份，以防止意外情况发生。
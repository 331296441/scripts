你可以使用以下命令来修改默认提交所有的行为：

```bash
git config --global add.all true
```

这将设置 `add.all` 选项为 `true`，表示默认提交所有文件，包括已删除的文件。如果你想恢复默认行为，可以使用以下命令：

```bash
git config --global --unset add.all
```

这将删除 `add.all` 选项，恢复默认行为。
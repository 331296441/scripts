你可以使用 `opkg` 包管理器来安装软件包。以下是在arm64的Linux中安装opkg的步骤：

1. 下载opkg二进制文件：

   ```shell
   $ wget http://downloads.openwrt.org/releases/18.06.1/targets/armvirt/64/packages/opkg_2017-12-13-3b417b9f-2_arm_cortex-a53-64_v8.ipk
   ```

2. 安装opkg：

   ```shell
   $ sudo mkdir -p /usr/local/opkg
   $ sudo tar -C /usr/local/opkg -xvf opkg_2017-12-13-3b417b9f-2_arm_cortex-a53-64_v8.ipk
   ```

3. 配置opkg：

   ```shell
   $ sudo mkdir -p /usr/local/etc/opkg
   $ sudo cp /usr/local/opkg/etc/opkg.conf /usr/local/etc/opkg/
   ```

4. 更新opkg软件包列表：

   ```shell
   $ sudo /usr/local/opkg/usr/bin/opkg update
   ```

现在你可以使用opkg来安装软件包了。例如，要安装curl，可以运行以下命令：

```shell
$ sudo /usr/local/opkg/usr/bin/opkg install curl
```

请注意，opkg是一个轻量级的包管理器，它不支持依赖关系解析。因此，你需要手动安装软件包的所有依赖项。
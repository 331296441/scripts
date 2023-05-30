


``` shell
#!/bin/bash
# Author: NueXini
core=$(cat /etc/opkg/distfeeds.conf | grep 'core' | awk '{print $3}')
old_kernel_md5=$(opkg info kernel | grep 'Version' | cut -d '-' -f 3)
new_kernel_md5=$(curl -s "$core/Packages.manifest" | grep -oE -m 1 'kernel \(=.*\)' | awk -F\- '{print $3}' | sed 's,\),,g')
sed -i "s/$old_kernel_md5/$new_kernel_md5/g" /usr/lib/opkg/status
echo 'Finished'
```
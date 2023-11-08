#!/bin/bash

# 查找无用的字体文件
unused_fonts=$(fc-list : file | cut -d: -f1 | sort | uniq | xargs -I{} sh -c 'test -f "{}" || echo "{}"')

# 删除无用的字体文件
echo "$unused_fonts" | xargs -I{} rm "{}"

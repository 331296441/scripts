FROM arm64v8/alpine:latest

# 替换为中科大源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# 安装所需的依赖
RUN apk add --no-cache build-base ncurses-dev zlib-dev git gettext wget unzip python3 argp-standalone musl-fts-dev musl-obstack-dev musl-libintl rsync tar bash diffutils grep gzip bzip2 findutils gawk coreutil

# 下载 OpenWrt 最新版本的源代码
RUN git clone https://git.openwrt.org/openwrt/openwrt.git /openwrt

# 进入 OpenWrt 源代码目录
WORKDIR /openwrt

# 配置编译环境
RUN ./scripts/feeds update -a && \
    ./scripts/feeds install -a && \
    make defconfig && \
    make menuconfig

# 配置适配 arm64 芯片的选项
RUN sed -i 's/# CONFIG_TARGET_ramips_mt76x8 is not set/CONFIG_TARGET_armvirt=y\nCONFIG_TARGET_armvirt_64=y\nCONFIG_TARGET_armvirt_64_DEVICE_generic=y/' .config

# 编译 OpenWrt
RUN make -j$(nproc)

# 设置环境变量
ENV PATH="/openwrt/staging_dir/toolchain-aarch64_generic_gcc-11.2.0_musl/bin:${PATH}"

# 打包镜像
CMD ["make", "image"]
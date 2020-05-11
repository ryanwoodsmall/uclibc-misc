# uclibc-misc
miscellaneous uClibc / uClibc-ng stuff (configs, wrappers, etc.)

initially a simple static-only config for uClibc-ng 1.0.x

_uclibc-ng-gcc_ and _uclibc-ng-gcc.spec_ GCC wrappers based on musl-libc's implementations

## centos 7 locale

centos 7 may need locale bits installed, particularly on armhf/aarch64 docker containers

```
localedef -i en_US -f UTF-8 en_US.UTF-8
```

## symlinks needed on rhel/centos 6/7 systems for compiling busybox

- ```/usr/include/asm``` -> ```/usr/local/uclibc-ng/include```
- ```/usr/include/asm-generic``` -> ```/usr/local/uclibc-ng/include```
- ```/usr/include/linux``` -> ```/usr/local/uclibc-ng/include```
- ```/usr/include/mtd``` -> ```/usr/local/uclibc-ng/include```

## symlinks needed for compiling uclibc-ng on raspbian/arm

- ```/usr/include/asm-generic``` -> ```/usr/include/arm-linux-gnueabihf/asm-generic```
- ```/usr/include/linux``` -> ```/usr/include/arm-linux-gnueabihf/linux```
- ```/usr/include/asm-generic``` -> ```/usr/include/asm```

_or_**(?)**

- ```/usr/include/arm-linux-gnueabihf/asm``` -> ```/usr/include/asm```

for busybox, ```/usr/local/uclibc-ng/include/asm``` definitely needs to point at ```/usr/include/arm-linux-gnueabihf/asm```

for gcc, some ```include-fixed``` headers need to be symlinked in, like so:

```
cat > /tmp/gnuc.c << EOF
#include <stdio.h>
int main(void)
{
  printf("%d.%d\n", __GNUC__, __GNUC_MINOR__);
  return(0);
}
EOF
gcc /tmp/gnuc.c -o /tmp/gnuc
gccv="$(/tmp/gnuc)"
# or this if you don't want to test the compiler:
#   gccv="$(gcc --version | head -1 | awk '{print $NF}' | cut -f1,2 -d.)" 
gcct="$(gcc --verbose 2>&1 | tr -d ' ' | awk -F: '/^Target/{print $NF}')"
gccd="/usr/lib/gcc/${gcct}/${gccv}"
for gcch in ${gccd}/include-fixed/*.h ; do
  test -e ${gccd}/include/$(basename ${gcch}) || {
    sudo ln -s ${gcch} ${gccd}/include
  }
done
```

are all of these raspbian-specific, do they apply to debian/ubuntu/...?
use the package system instead?
yocto/poky is probably a better choice for clean builds.
crosstool-ng is probably a better choice for a decoupled compiler.

## tinkerboard example

```
make \
  -j$(($(nproc)*2+1)) \
    install \
      CPU_CFLAGS="-I/usr/src/linux-headers-4.19.69-rockchip/arch/arm/include \
                  -I/usr/src/linux-headers-4.19.69-rockchip/arch/arm/include/generated/uapi \
                  -I/usr/src/linux-headers-4.19.69-rockchip/arch/arm/include/generated \
                  -I/usr/src/linux-headers-4.19.69-rockchip/include/generated/uapi \
                  -I/usr/src/linux-headers-4.19.69-rockchip/include/uapi \
                  -I/usr/src/linux-headers-4.19.69-rockchip/arch/arm/include/uapi \
                  -I/usr/src/linux-headers-4.19.69-rockchip/include"
```

## renegade example

```
make \
  -j$(($(nproc)*2+1)) \
    install \
      CPU_CFLAGS="-I/usr/src/linux-headers-4.4.77-rk3328/include/generated/uapi \
                  -I/usr/src/linux-headers-4.4.77-rk3328/include/uapi \
                  -I/usr/src/linux-headers-4.4.77-rk3328/include"
```

## todo

- figure out proper ```KERNEL_HEADERS``` setting for arm/aarch64

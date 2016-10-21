# uclibc-misc
miscellaneous uClibc / uClibc-ng stuff (configs, wrappers, etc.)

initially a simple static-only config for uClibc-ng 1.0.x

_uclibc-ng-gcc_ and _uclibc-ng-gcc.spec_ GCC wrappers based on musl-libc's implementations

## symlinks needed (at least on RHEL6/7-ish systems) for compiling busybox

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

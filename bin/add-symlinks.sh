#!/bin/bash

test -e /usr/local/uclibc-ng/include || {
	mkdir -p /usr/local/uclibc-ng/include
}

for d in asm asm-generic linux mtd ; do
	test -e /usr/local/uclibc-ng/include/${d} || {
		ln -s /usr/include/${d} /usr/local/uclibc-ng/include/${d}
	}
done

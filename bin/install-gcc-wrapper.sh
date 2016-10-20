#!/bin/bash

scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for d in bin lib ; do
	test -e /usr/local/uclibc-ng/${d} || {
		mkdir -p /usr/local/uclibc-ng/${d}
	}
done

install --mode=0755 ${scriptdir}/gcc-wrapper/uclibc-ng-gcc /usr/local/uclibc-ng/bin/
install --mode=0644 ${scriptdir}/gcc-wrapper/uclibc-ng-gcc.specs /usr/local/uclibc-ng/lib/

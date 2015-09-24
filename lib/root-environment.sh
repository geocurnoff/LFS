
prepare-root() {
	mkdir -p $1                                              && \
	mkdir -pv $1/{dev,proc,sys,run}                          && \
	mknod -m 600 $1/dev/console c 5 1                        && \
	mknod -m 666 $1/dev/null c 1 3                           && \
	mount -v --bind /dev $1/dev                              && \
	mount -vt devpts devpts $1/dev/pts -o gid=5,mode=620     && \
	mount -vt proc proc $1/proc                              && \
	mount -vt sysfs sysfs $1/sys                             && \
	mount -vt tmpfs tmpfs $1/run
}

teardown-root() {
	umount $1/dev/pts/            && \
	umount $1/dev                 && \
	umount $1/proc                && \
	umount $1/sys                 && \
	umount $1/run                 && \
	rm $1/dev/console             && \
	rm $1/dev/null                && \
	rm -r $1/{dev,proc,sys,run}
}


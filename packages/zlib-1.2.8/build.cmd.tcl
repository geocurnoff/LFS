
set PREFIX /usr

cd [glob $SRC/*/]

!* ./configure --prefix=$PREFIX

!* make >/dev/stdout

file delete -force $BUILD
file mkdir  $BUILD

!* make DESTDIR=$BUILD install

file mkdir $BUILD/lib
file rename {*}[glob $BUILD/usr/lib/libz.so.*] $BUILD/lib/
cd $BUILD/usr/lib/;
set OLD_NAME [file readlink $BUILD/usr/lib/libz.so]
file delete libz.so
file link -symbolic libz.so "../../lib/$OLD_NAME"
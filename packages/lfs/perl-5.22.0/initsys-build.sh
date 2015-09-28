. $SHARED/tools.cfg.sh

cd $SRC/*/

sh Configure -des -Dprefix=$TOOLS -Dlibs=-lm  || die "Configuring $NAME failed."

make -j2 || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD
mkdir -v -p $BUILD/$TOOLS_PREFIX

# Install to fake root
cp -v perl cpan/podlators/pod2man $BUILD/$TOOLS_PREFIX/bin
mkdir -pv $BUILD/$TOOLS_PREFIX/lib/perl5/5.22.0
cp -Rv lib/* $BUILD/$TOOLS_PREFIX/lib/perl5/5.22.0
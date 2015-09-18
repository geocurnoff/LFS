. $LFS_SRC/tools.cfg.sh

cd $SRC/*/gettext-tools

EMACS="no" \
./configure --prefix=$TOOLS    \
            --host=$LFS_TGT    \
            --disable-shared   \
            --enable-cfsharp=no \
            --disable-java || die "Configuring $NAME failed."

make -C gnulib-lib     && \
make -C intl pluralx.c && \
make -C src msgfmt     && \
make -C src msgmerge   && \
make -C src xgettext   || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD
mkdir -v -p $BUILD/$TOOLS_PREFIX/bin

# Install
cp -v src/{msgfmt,msgmerge,xgettext} $BUILD/$TOOLS_PREFIX/bin

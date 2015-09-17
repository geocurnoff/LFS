
mkdir -pv $CACHE

get-file "ftp://ftp.astron.com/pub/file/file-5.22.tar.gz \
          http://pkgs.fedoraproject.org/repo/pkgs/file/file-5.22.tar.gz/8fb13e5259fe447e02c4a37bc7225add/file-5.22.tar.gz" \
          "$CACHE/file-5.22.tar.gz" $USE_CACHED || die "Fetching sources for package $NAME failed."

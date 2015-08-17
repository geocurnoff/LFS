
rm *.tar.* &> /dev/null

wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.19.tar.xz || die "Fetching sources for package $NAME failed."

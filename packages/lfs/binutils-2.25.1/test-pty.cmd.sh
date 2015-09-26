
# Verify that the PTYs are working properly inside the chroot environment

OUT=$(expect -c "spawn ls")

if [ "$OUT" = "spawn ls" ]; then
    echo "Test failed: $OUT"
    exit 1
else
    echo "Test succeded: $OUT"
    exit 0
fi


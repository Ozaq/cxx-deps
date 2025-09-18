build() {
    set -ex
    echo "Building libaec"
    src_path="$SOURCE_ROOT/libaec"
    build_path="$BUILD_PATH/aec"
    mkdir -p "$build_path"
    cmake -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DBUILD_STATIC_LIBS=OFF \
        -DBUILD_TESTING=OFF \
        -S "$src_path" \
        -B "$build_path"
    cmake --build "$build_path" -j --target install
}


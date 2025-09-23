build() {
    set -ex
    echo "Building ecbuild"
    src_path="$SOURCE_ROOT/ecbuild"
    build_path="$BUILD_PATH/ecbuild"
    mkdir -p "$build_path"
    cmake -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DBUILD_TESTING=OFF \
        -S "$src_path" \
        -B "$build_path"
    cmake --build "$build_path" -j --target install
}

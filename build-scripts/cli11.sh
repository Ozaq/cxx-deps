build() {
    echo "Building CLI11"
    src_path="$SOURCE_ROOT/CLI11"
    build_path="$BUILD_PATH/CLI11"
    mkdir -p "$build_path"
    cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCLI11_PRECOMPILED=ON \
        -DCLI11_SINGLE_FILE_TESTS=OFF \
        -DCLI11_BUILD_DOCS=OFF \
        -DCLI11_BUILD_EXAMPLES=OFF \
        -DCLI11_BUILD_EXAMPLES_JSON=OFF \
        -DCLI11_INSTALL=ON \
        -DCLI11_BUILD_TESTS=OFF \
        -S "$src_path" \
        -B "$build_path"
    cmake --build "$build_path" -j --target install
}

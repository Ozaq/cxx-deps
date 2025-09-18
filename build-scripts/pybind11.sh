build() {
    set -ex
    echo "Building Pybind11"
    src_path="$SOURCE_ROOT/pybind11"
    build_path="$BUILD_PATH/pybind11"
    mkdir -p "$build_path"
    cmake -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DPYBIND11_TEST=OFF \
        -DPYBIND11_NOPYTHON=ON \
        -S "$src_path" \
        -B "$build_path"
    cmake --build "$build_path" -j --target install
}

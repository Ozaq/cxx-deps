build() {
    echo "Building ecbuild"
    src_path="$SOURCE_ROOT/ecbuild"
    build_path="$BUILD_PATH/ecbuild"
    mkdir -p "$build_path"
    cd "$build_path"
    "$src_path/bin/ecbuild" --prefix=${INSTALL_PREFIX} "$src_path"
    make -j install
}

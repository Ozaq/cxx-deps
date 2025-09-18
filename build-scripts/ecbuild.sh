build() {
    echo "Building ecbuild"
    ecbuild_path=$(pwd)/ecbuild
    build_loc=${BUILD_PATH}/ecbuild
    mkdir -p ${build_loc}
    cd ${build_loc}
    ${ecbuild_path}/bin/ecbuild --prefix=${INSTALL_PREFIX} ${ecbuild_path}
    make -j install
}

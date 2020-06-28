# build a bunch of ios libs(incremental rebuilding also supported)
cd ..
if [ -d "ios" ]; then
  echo "Used prebuilt libraries"
else
  echo "ios folder does not exist, starting building it first"
  ./build_ios_cmake.sh
fi

cd ./patchmatch-ios

# build framework
build_selected_platform () {
cmake . -Bbuild/$1 -G Xcode \
    -DCMAKE_TOOLCHAIN_FILE=../ios-cmake/ios.toolchain.cmake \
    -DPLATFORM=$1 \
    -DCMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM=$2 \
    -DARCHS="armv7 armv7s arm64"
cmake --build build/$1 --config Release --target install
}

build_all_platforms() {
    build_selected_platform "OS" $1
}

build_all_platforms $1

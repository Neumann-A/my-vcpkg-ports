vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytorch/audio
    REF "v${VERSION}"
    SHA512 6860e91b87d1ce5b08149dc0192ad5c895520f75c7220bed52b3de64b3e87e9ec39c6fd6596cdf7f5d989e7821e9c04f253112f980a07107eb7f7eaf608d325f
    HEAD_REF main
    PATCHES
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    openmp      USE_OPENMP
    cuda        USE_CUDA
    cuda        BUILD_CUDA_CTC_DECODER
    python      BUILD_TORCHAUDIO_PYTHON_EXTENSION
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DUSE_FFMPEG=ON
        -DBUILD_CPP_TEST=OFF
)
vcpkg_cmake_install()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

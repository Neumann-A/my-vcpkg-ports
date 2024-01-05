vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytorch/vision
    REF "v${VERSION}"
    SHA512 812faff3e570103a46be39dd22934532989e96681c41785488e36e67c25e71c5848be05e83e161c6c0b0ec2368d4a53dc562cae2cf5e2a3b6d46292a9eb86712
    HEAD_REF main
    PATCHES
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    cuda        WITH_CUDA
    python      USE_PYTHON
)

if(VCPKG_TARGET_IS_OSX)
    list(APPEND FEATURE_OPTIONS -DWITH_MPS=ON)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        #--trace-expand
        ${FEATURE_OPTIONS}
        -DWITH_PNG=ON
        -DWITH_JPEG=ON
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH share/cmake/TorchVision )
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/torchvision/TorchVisionConfig.cmake" "/../../../" "/../../")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

if("python" IN_LIST FEATURES)
  file(COPY "${SOURCE_PATH}/torchvision" DESTINATION "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}/")
  #vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")# OPTIONS -x)
endif()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

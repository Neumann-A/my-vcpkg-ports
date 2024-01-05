vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mesonbuild/meson-python
    REF ${VERSION}
    SHA512 f1fce89bb0a3d279b9900c4ecec78e5f24da92d72f64ebf6c27648b4201a75a65204c3fac08aaa3e8d70dbeef245c3235e39994c7c0b9cba27c0df528211c7f7
    HEAD_REF main
)

#vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

set(VCPKG_BUILD_TYPE release)

vcpkg_configure_meson(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_install_meson()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/python3/")
file(RENAME "${CURRENT_PACKAGES_DIR}/Lib" "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}")

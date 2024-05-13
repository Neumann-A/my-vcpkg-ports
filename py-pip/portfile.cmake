string(REGEX REPLACE "^py-" "" package "${PORT}")
vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    ${package}
    VERSION         ${VERSION}
    SHA512          b687d9e7e2b0348a1c3355610bcf4e194dd157dc6e79638f8a0a383cf1ba7c4253be4b145e9a5029e089807d1feec9e444976f34f77a732f3ef527d9bc6bcebf
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

string(REGEX REPLACE "-" "_" test_package "${package}")
vcpkg_python_test_import(MODULE "${test_package}")
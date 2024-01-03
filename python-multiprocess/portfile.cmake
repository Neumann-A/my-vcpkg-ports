vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO uqfoundation/multiprocess
    REF multiprocess-${VERSION}
    SHA512 b2413ad24c2c8af5b962b22e2343e77e7f33e271f763b3a5426f945d6869bc3684645e62dec80234c10506d12e2bed3edd725a796d75d87409372210032930b8
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

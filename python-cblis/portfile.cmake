vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/cython-blis
    REF v${VERSION}
    SHA512 4c3eb39f4bee14f0eefd2af19cac2c4a9184b4ed2da3c8321550778d2c63a4672ec9eb15277e2fb05806965953c8e913051dcea21cd632b67ccd6c0c88f94811
    HEAD_REF main
    PATCHES
        build.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_BLIS_PATH
    REPO explosion/blis
    REF e81f7291c52c04c4bdbee0aba3e39d703454eab5
    SHA512 a4ab674e47759d6acb4b91f270ec55543112007bdf13e2d9ad419975e87b3142753c5fe5c9ca91fa6d1da8671ebcdcc38cadd64d1d3b3792d2d6fef9a0480b7b
    HEAD_REF main
    PATCHES
        flame-cpuid.patch
)

file(COPY "${SOURCE_BLIS_PATH}/" DESTINATION "${SOURCE_PATH}/flame-blis" )

# Compiles something with clang?
#vcpkg_replace_string( "cython<3.0" "cython")
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

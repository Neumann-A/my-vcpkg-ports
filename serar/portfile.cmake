#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    #GITHUB_HOST  ssh://git@github.com:
    AUTHORIZATION_TOKEN ac08b9d9bf859498cbf0b66bd33512efa315a2fc
    REPO Neumann-A/SerAr
    REF 204d7a64722c879709cf04bfb5d0a7e0209201ee 
    SHA512  3e9e7b98c638d35b592f78621676ffbdc018dede886748fbf05f03607cf64120ed2a44217cb52c270d01cd919ebadac2b4f07f9d19e4a598957ddc9fc20e4640
    HEAD_REF dev
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        #--trace
        #--log-level=TRACE
        -DCMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT=OFF
        -DSerAr_WITH_HDF5=OFF
        #-DMATLAB_FIND_DEBUG=ON
        ${OPTIONS}
)
vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(NO_IMPORT_PREFIX_CORRECTION)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

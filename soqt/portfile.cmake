vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO coin3d/soqt
    REF v${VERSION}
    SHA512 153b5d94440ec16ccbadb7225eb4f819a4bdbd0c2ee171e092518ccc3c2c5e60c236baf543b268acbc00ec747269f796855810b2c5c34c21fc8c1378de582dc1
    HEAD_REF master
)

vcpkg_from_github(
    OUT_SOURCE_PATH src_data
    REPO coin3d/soanydata
    REF 7ee364a6ec2b496b28e5a13a88800ad11fcbe84e
    SHA512 3ad76b7652004bc7f0dd76b9a5ee45d4c442d18ac44b82df4f49bbf375e181594a03037b3bd5d177c66af7379870af831117d57e93f0fcf6d58c72ecb1c98c42
    HEAD_REF master
)

vcpkg_from_github(
    OUT_SOURCE_PATH src_sogui
    REPO coin3d/sogui
    REF 64e18cd4b250d941a7a283ba4a789b1dbb9c99b5
    SHA512 a842c9e1d987842c45aaf8b7d6e1c178cc9ebae3ec456bdec4d7d3587f057c6ebb5cb7574460c8acadea2a605ced1ef9f3da00673c81bfcec23a35547cf254ef
    HEAD_REF master
)

file(COPY "${src_data}/" DESTINATION "${SOURCE_PATH}/data")
file(COPY "${src_sogui}/" DESTINATION "${SOURCE_PATH}/src/Inventor/Qt/common")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
)

vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/SoQt-1.6.1")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")


vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-pillow/Pillow
    REF ${VERSION}
    SHA512 01c97b68d4167d10539a2d29fb82676fb417ee5003f0acd9f602ed13d41b200579497cc0ef0949b2c1549b684f76f2d43895a52abdb1367345d2affd544c5b5a
    HEAD_REF master
)

set(ENV{PKG_CONFIG} "${CURRENT_HOST_INSTALLED_DIR}/tools/pkgconf/pkgconf")
set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig")
set(ENV{INCLUDE} "${CURRENT_INSTALLED_DIR}/include;$ENV{INCLUDE}")
set(ENV{INCLIB} "${CURRENT_INSTALLED_DIR}/lib;$ENV{INCLIB}")
set(ENV{LIB} "${CURRENT_INSTALLED_DIR}/lib;$ENV{LIB}")

#TODO: Setup CFLAGS and everything.

vcpkg_python_build_and_install_wheel(
  SOURCE_PATH "${SOURCE_PATH}" 
  OPTIONS 
    -C raqm=disable # linkage issues. Without pc file missing linakge to harfbuzz fribidi
)



vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

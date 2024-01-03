vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ifduyue/python-xxhash
    REF v${VERSION}
    SHA512 23b3950e289306363558e525563b520a69a44f509324d372e1f6b00e19d461b0a3e67c1cea3c75aae14ef68130d46d6d477db2638eae0ad25c161457237cb1ab
    HEAD_REF master
)

set(ENV{XXHASH_LINK_SO} 1)

set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib")
set(ENV{CL} "$ENV{CL} /I${CURRENT_INSTALLED_DIR}/include")

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

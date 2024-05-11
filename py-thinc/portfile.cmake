vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/thinc
    REF v${VERSION}
    SHA512 4f80c19833e7b6d118bd3e2c7c1dc740cd7ce41059a7a41d4af99300f98c205f1af8e0e7e1422d7eb6fc5c4fc154b1640632816b1fd5a48df7b1e3387bee0a36
    HEAD_REF master
    PATCHES
      cython3.patch
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

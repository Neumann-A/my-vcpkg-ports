vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  yaml/pyyaml
    REF ${VERSION}
    SHA512 1c74a92a4ad7d47854dc7bcb2e89b3c8e0b14fa815c7dbfbc22b24480dbba6c81e971c77ee384c494a960914b95f06edf943d7431925a5ed674a0ba830d258e0
    HEAD_REF main
    PATCHES
      pyyaml-6.0.1-cython3.patch
      remove_ver_constrain.patch
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

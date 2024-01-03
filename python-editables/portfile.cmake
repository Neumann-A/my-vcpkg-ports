vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pfmoore/editables
    REF 87cec30b6bff6aa9d871d74d44e47dbf48e2a6ad
    SHA512 e139bbe51772535e7d1bd9a1daeeb2b0df3651997961d0af434c51f0e0c9c846499cf28b1c7ba5c9224e162e25cb4311322a0655ac789888830b28588edd20b2
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

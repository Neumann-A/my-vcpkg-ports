vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/weasel
    REF v${VERSION}
    SHA512 f921fbad12be37d033c500b08b18095be22d7c8c2f5afe2f5c70ddae7df543bf9b8e7fb2cf86774feb14f5b015f63303bd1e92b29a81c1aaceca8dbf2f957ed0
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

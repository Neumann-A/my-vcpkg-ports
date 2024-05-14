vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO TimDettmers/bitsandbytes
    REF ${VERSION}
    SHA512 b39d19017eb744e3dbb36cc1c63e4af483e48ec5b2389216a8b0bf0c295ed84d656b3bda466df75ab9be88a54a397a851e0c0eb6f423a184285ffd4ed8bbe0ab
    HEAD_REF main
)
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/tests")

vcpkg_python_test_import(MODULE "bitsandbytes")
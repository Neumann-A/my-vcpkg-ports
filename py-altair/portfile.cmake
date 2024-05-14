vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO altair-viz/altair
    REF v${VERSION}
    SHA512 c60f16d82dcc6784fcec7425f6c3f874a8f71f0e200d6e095b73fed3c3a720bfde13d7227fee9b8cfa06d1b93a207fbda8ca5d4a0df5f6b2532fb9954d828229
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "altair")

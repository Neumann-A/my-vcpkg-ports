vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/weasel
    REF v${VERSION}
    SHA512 35e96ab15d6f41da6fb6c7df6748742c147d453e10373459474d747e2fcb4b73bfc306e174a8d825c22833be45e37dfb17e9c2818693fa3ef4e763888b6d5ab3
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "weasel")

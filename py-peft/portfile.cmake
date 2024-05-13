vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/peft
    REF v${VERSION}
    SHA512 72035d011acccc7e71495806804961cfbf1663772feaa8c3fe92cabd076c6f5a195f91ac56d3c7586f4e7bb3a53cddd436f3e001014272ae2568d5aaf5437859
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "peft")

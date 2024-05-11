vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/peft
    REF v${VERSION}
    SHA512 0316e2018730c7efa39e961ebd1819d6f19afaeb50016aea20853f3c04f474961070cbbc7079074eb6ec27799c4a87e2931b1ab0acbdb29084335949f53fd8b0
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

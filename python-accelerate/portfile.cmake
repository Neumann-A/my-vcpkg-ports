vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/accelerate
    REF v${VERSION}
    SHA512 101982f7a924f45375ab5da07e1093b93bee55a5552d884b8d40d163910ef8cfac06c8d126c9eea5f0979760ed4fe99ec4cc3fa4f0d739ef288c68070ab11360
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

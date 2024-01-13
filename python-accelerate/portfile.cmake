vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/accelerate
    REF v${VERSION}
    SHA512 ae3032a4f644dc09cb8a8f6ded9f010b5f77da0e47b0a656985fa4c2ba67a9581820aa668d43bed5f502494b5996a95f64831d25a6a3155553065062936601b8
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

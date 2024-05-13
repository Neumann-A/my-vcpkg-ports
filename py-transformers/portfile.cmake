vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/transformers
    REF v${VERSION}
    SHA512 f1c471c471e31672b4923e6a3cecf31cd1ea2ad7b3b3c520fd93d200d4d21f1dddd993eb29ef58ba137a9e4fbcfd48a00b61243c1c7566b68385f32ede8ee42c
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "transformers")

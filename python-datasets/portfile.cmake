vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/datasets
    REF ${VERSION}
    SHA512 2ca76ff526a46dac123450cbc339269f96b2e543027043d6706733b18a6b219ca6333bd32b8ec66636a11421dce3493cb1a7dd53296cab3eeafc86fbe9dbe418
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

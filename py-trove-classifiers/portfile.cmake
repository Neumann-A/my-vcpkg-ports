
string(REPLACE "-" "." new_version "${VERSION}")
string(REGEX REPLACE "\\.0([0-9])" ".\\1" new_version "${new_version}")
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/trove-classifiers
    REF ${new_version}
    SHA512 25accd469412437a22ae94938833160ba914232c05f3ad63bceced9eba6d5d0c20561da689588e11a6e75f3050e378292725044c49f1335566ddc7e2b2825409
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "trove_classifiers")

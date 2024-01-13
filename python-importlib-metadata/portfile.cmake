vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python/importlib_metadata
    REF f604d3e462cd11ee071bfcb78b827fb67cc2e537
    SHA512 ea6c3c630deb8aea4fc487f3c2540bd58d2d0b66d828565a8e3e977ec41143c24ef4bc5c39c06c46c9e6efd9f837b090f0d33722471b557d398170ec2ac4cb4d
    HEAD_REF main
)

# -x to avoid setuptools_scm cycle. 
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

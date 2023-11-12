vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tiangolo/typer
    REF ${VERSION}
    SHA512 76a455b17278c1fcf97a1fef7b3186cb0edda1501f537b1c689fa8fc1cdae233fbf2b0bbbcf8b886e7d35d2f480343427ad3410274218dee8689890321f93b58
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

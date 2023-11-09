vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/pip
    REF ${VERSION}
    SHA512 eddca29e8c3727d1d8d793ab0b05f069781cac06df805fcf7a363da738d39498135ccbbb6d2d442604a7bf78ba6c3d101ec2043431ac1832a3f2710db7cc5e56
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO certifi/python-certifi
    REF 2023.07.22
    SHA512 72ebe32f284eee5998c08961206564206b2162a38d84484fad9894770394c9a9a20979bd374e687d2978eee681197971dae580ec78f4922e7482b083482bd657
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

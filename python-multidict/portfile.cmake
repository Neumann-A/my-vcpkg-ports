vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/multidict
    REF v${VERSION}
    SHA512 6f9e6ff16a104d40b0cb59860af9cb1a98e8d3a256626f77600c4895e6ef692b31880273f204e7ecdeb574407dd7c2e4326ad7cd9c08b1095011d6ba3793b86e
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

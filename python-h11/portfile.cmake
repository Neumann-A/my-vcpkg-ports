vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-hyper/h11
    REF v${VERSION}
    SHA512 f49d35876cd5e8ca190a6b5187f8580780f0517cb7de78bf32dd1de8a814c9fd000e6ee4db2d72108c8f1b6628157eed8c11ad7940adffde28e410a01c0a318e
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

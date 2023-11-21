vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/yarl
    REF v${VERSION}
    SHA512 c6159ed26f946533543f4238feb90986422dda3bd6c2c68e274d2745efb4eccad76dfbc129370d8c5e24584fc459dbc0002fd66fbdad9291a30041c929dee6d8
    HEAD_REF master
)
set(ENV{YARL_NO_EXTENSIONS} 0)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytest-dev/pluggy
    REF 9060a4e466a8ef08bd737dd75acf1e976b76dc07
    SHA512 db78a8e144da87c7145f51537014b2fc09004c8c6e5f86c75d962f4118c36d79a8cfa16921b328a4fea693af5b91347d73809033f09beba14029a4728adc79a9
    HEAD_REF master
)


pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")


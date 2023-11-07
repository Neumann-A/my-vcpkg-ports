#vcpkg_from_github(
#    OUT_SOURCE_PATH SOURCE_PATH
#    REPO pytest-dev/pluggy
#    REF 9060a4e466a8ef08bd737dd75acf1e976b76dc07
#    SHA512 db78a8e144da87c7145f51537014b2fc09004c8c6e5f86c75d962f4118c36d79a8cfa16921b328a4fea693af5b91347d73809033f09beba14029a4728adc79a9
#    HEAD_REF master
#)


vcpkg_download_distfile(
    ARCHIVE
    URLS https://files.pythonhosted.org/packages/36/51/04defc761583568cae5fd533abda3d40164cbdcf22dee5b7126ffef68a40/pluggy-1.3.0.tar.gz
    FILENAME pluggy-1.3.0.tar.gz
    SHA512 d4dbb449f533649da161d7e49f82da5800dabdace4f7aa239c412290470612a45a3ba3c50cafd7bd9ed26cb3aa14648bfa3ed3f41fc0db9ae9399fd7f5933d5f
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

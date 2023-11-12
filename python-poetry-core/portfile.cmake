vcpkg_download_distfile(
    wheel
    URLS https://github.com/python-poetry/poetry-core/releases/download/1.8.1/poetry_core-1.8.1-py3-none-any.whl
    FILENAME poetry_core-1.8.1-py3-none-any.whl
    SHA512 b29420c0b49659eab15c07656c8834122755b74818370bf362cda563a1e0e5588ea495921b1d96412ad7a8ec996e3c9bc5c7840b1fa9247dfb67d485859f7ec5
)

pypa_install_wheel(WHEEL "${wheel}")

vcpkg_install_copyright(FILE_LIST "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/poetry_core-1.8.1.dist-info/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)





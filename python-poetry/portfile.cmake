vcpkg_download_distfile(
    wheel
    URLS https://github.com/python-poetry/poetry/releases/download/1.7.0/poetry-1.7.0-py3-none-any.whl
    FILENAME poetry-1.7.0-py3-none-any.whl
    SHA512 1a6e16082756dc448654757093bf2f29be9a19d4371fd842f73a616c896328987c6a358a101c52a2aa59523d503a0e33706bf3d56fe6e1d920ca224dbd6a94eb
)

vcpkg_python_install_wheel(WHEEL "${wheel}")

vcpkg_install_copyright(FILE_LIST "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/poetry-1.7.0.dist-info/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)





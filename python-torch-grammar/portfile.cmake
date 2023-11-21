set(name torch_grammar-${VERSION})
set(wheelname ${name}-py3-none-any.whl)

vcpkg_download_distfile(
    wheel
    URLS https://files.pythonhosted.org/packages/2b/33/bca15f46a86414730e6f86ff8d6ef773f7d48ad7d2ae749cb4e40dc0b6fe/${wheelname}
    FILENAME ${wheelname}
    SHA512 781d7f664992d649a2ed944a6364200c8a669982e668d589bcecbf45998b6dd5c52d2c96350ea76886648330d48d1273ec35f085ac806669478bcbe1c77dad56
)

pypa_install_wheel(WHEEL "${wheel}")

#vcpkg_install_copyright(FILE_LIST "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/${name}.dist-info/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

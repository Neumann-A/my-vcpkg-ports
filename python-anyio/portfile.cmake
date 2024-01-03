set(name anyio-${VERSION})
set(wheelname ${name}-py3-none-any.whl)

vcpkg_download_distfile(
    wheel
    URLS https://files.pythonhosted.org/packages/36/55/ad4de788d84a630656ece71059665e01ca793c04294c463fd84132f40fe6/${wheelname}
    FILENAME ${wheelname}
    SHA512 f30761c1e8725b49c498273b90dba4b05c0fd157811994c806183062cb6647e773364ce45f0e1ff0b10e32fe6d0232ea5ad39476ccf37109d6b49603a09c11c2
)

vcpkg_python_install_wheel(WHEEL "${wheel}")

vcpkg_install_copyright(FILE_LIST "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/${name}.dist-info/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

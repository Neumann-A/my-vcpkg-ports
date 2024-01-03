set(name python_dateutil-${VERSION})
set(wheelname ${name}-py2.py3-none-any.whl)

vcpkg_download_distfile(
    wheel
    URLS https://files.pythonhosted.org/packages/36/7a/87837f39d0296e723bb9b62bbb257d0355c7f6128853c78955f57342a56d/${wheelname}
    FILENAME ${wheelname}
    SHA512 aa5cbf32cc20465a94a48b6156ec87ebf3a0b543c16b68fa346fde6b481bcbc07c3429b4171bdfcc45f2eeef9933e1bb03bdfdf453f4aed237cc88cc452317c3
)

vcpkg_python_install_wheel(WHEEL "${wheel}")

vcpkg_install_copyright(FILE_LIST "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/${name}.dist-info/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

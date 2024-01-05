set(name pytz-${VERSION})
set(wheelname ${name}-py2.py3-none-any.whl)

vcpkg_download_distfile(
    wheel
    URLS https://files.pythonhosted.org/packages/32/4d/aaf7eff5deb402fd9a24a1449a8119f00d74ae9c2efa79f8ef9994261fc2/${wheelname}
    FILENAME ${wheelname}
    SHA512 a1c24246b1c0cb825944bce0c27a5eee27dd7a0acf3c07e6eca1e3c7b55473093ad560c0dab6c76c8adb2ad1630a092d9971533cd905b2d1cacbab37ffab5f96
)

vcpkg_python_install_wheel(WHEEL "${wheel}")

vcpkg_install_copyright(FILE_LIST "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}/${name}.dist-info/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

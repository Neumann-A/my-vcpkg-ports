vcpkg_download_distfile(
    wheel
    URLS https://files.pythonhosted.org/packages/81/54/84d42a0bee35edba99dee7b59a8d4970eccdd44b99fe728ed912106fc781/filelock-3.13.1-py3-none-any.whl
    FILENAME filelock-3.13.1-py3-none-any.whl
    SHA512 8db4338ee7e7135dd2d41baeefbc8283f11919e669695ba4f37c16c6e64d5716aea91077367de9a97487529588924b7ecdf3b5077df30f0375e0f53fb1510ce8
)

pypa_install_wheel(WHEEL "${wheel}")

vcpkg_install_copyright(FILE_LIST "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/filelock-3.13.1.dist-info/licenses/LICENSE")


set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

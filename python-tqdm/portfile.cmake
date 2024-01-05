vcpkg_download_distfile(
    wheel
    URLS https://github.com/tqdm/tqdm/releases/download/v4.66.1/tqdm-4.66.1-py3-none-any.whl
    FILENAME tqdm-4.66.1-py3-none-any.whl
    SHA512 c236be01f0122aaa42db662e56bb1e766aa4983eebb9e626d71d29f021ebd9371209d753efb6ed3e0ada90a772a96b0b053f0ebc4c37b4f80affa90bfdc38514
)

vcpkg_python_install_wheel(WHEEL "${wheel}")

vcpkg_install_copyright(FILE_LIST "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}/tqdm-4.66.1.dist-info/LICENCE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

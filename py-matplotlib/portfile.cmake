vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO matplotlib/matplotlib
    REF v${VERSION}
    SHA512 9309a12573019181bd3e150e954dae23bdbfb138ee4b2ffbc025691158568b8743ca8f9e337b7adb4c3c5b50fa8e085138a5022faab2d927cea39451347cfbc7
    HEAD_REF main
)

set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig;${CURRENT_INSTALLED_DIR}/share/pkgconfig")
set(ENV{INCLUDE} "${CURRENT_INSTALLED_DIR}/include;$ENV{INCLUDE}")

set(ENV{SETUPTOOLS_SCM_PRETEND_VERSION} "${VERSION}")
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -Csetup-args=-Dsystem-freetype=true -Csetup-args=-Dsystem-qhull=true -x)

file(GLOB licenses "${SOURCE_PATH}/LICENSE/*")

vcpkg_install_copyright(FILE_LIST ${licenses})
string(REPLACE "." ";" version_list "${VERSION}")
list(GET version_list 0 version_major)
list(GET version_list 1 version_minor)
list(GET version_list 2 version_patch)
file(WRITE "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}/matplotlib/_version.py"
"\n\
TYPE_CHECKING = False\n\
if TYPE_CHECKING:\n\
    from typing import Tuple, Union\n\
    VERSION_TUPLE = Tuple[Union[int, str], ...]\n\
else:\n\
    VERSION_TUPLE = object\n\
\n\
version: str\n\
__version__: str\n\
__version_tuple__: VERSION_TUPLE\n\
version_tuple: VERSION_TUPLE\n\
\n\
__version__ = version = '${VERSION}'\n\
__version_tuple__ = version_tuple = (${version_major}, ${version_minor}, ${version_patch})\n\
\n\
")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

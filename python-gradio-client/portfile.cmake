string(REPLACE "python-" "" package "${PORT}")
string(REPLACE "-" "_" package "${package}")
set(name ${package}-${VERSION})

vcpkg_download_distfile(
    wheel_json
    URLS https://pypi.python.org/pypi/${package}/json
    FILENAME ${name}.json
    ALWAYS_REDOWNLOAD
    SKIP_SHA512
)

file(READ "${wheel_json}" wheel_index)

string(JSON wheel_releases GET "${wheel_index}" "releases")
string(JSON wheel_releases GET "${wheel_releases}" "${VERSION}")
string(JSON wheel_release GET "${wheel_releases}" "0") # 0 is the bdist wheel
string(JSON download_url GET "${wheel_release}" "url")

string(JSON packagetype GET "${wheel_release}" "packagetype")
string(JSON filename  GET "${wheel_release}" "filename")

if(NOT "${packagetype}" STREQUAL "bdist_wheel")
  message(FATAL_ERROR "Download is not a binary wheel")
endif()
if(NOT "${filename}" MATCHES "none-any")
  message(FATAL_ERROR "Download is not an architecture independent wheel -> Building from source required")
endif()

vcpkg_download_distfile(
    wheel
    URLS ${download_url}
    FILENAME ${filename}
    SHA512 c1b1f66a53558cf7debdc21ac17bec32cf64249bcde7a8505ebeef47c27061814d0e249761abc1b78b12f0e0a49e014fa0f588e548e75962a7af4e83a2e78f6f
)

pypa_install_wheel(WHEEL "${wheel}")

file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(TOUCH "${CURRENT_PACKAGES_DIR}\\share\\${PORT}\\copyright")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

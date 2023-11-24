string(REPLACE "python-" "" package "${PORT}")
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
    SHA512 adcdc5655688e966b1fd1641e8db9c9f5ee3173379e782f2c0a57f538d43bfbb908398e51b59e543e10d6d18d3fffc059bbbec43aaa573eca04b6408f5010869
)

pypa_install_wheel(WHEEL "${wheel}")

vcpkg_install_copyright(FILE_LIST "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/${name}.dist-info/licenses/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

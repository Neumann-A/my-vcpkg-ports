vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO scikit-build/scikit-build-core
    REF v${VERSION}
    SHA512 e40aab2523af1f36f3570fcde6302a4660bdd12aacb776cbe42d7ec3a3800d4a9ea3634f87c45ca5fd3522eb107ff0f0f3c607bad121388c06b4abe6f53c4c9d
    HEAD_REF main
)

set(ENV{SETUPTOOLS_SCM_PRETEND_VERSION} "${VERSION}")

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

#file(COPY "${SOURCE_PATH}/llama_cpp" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

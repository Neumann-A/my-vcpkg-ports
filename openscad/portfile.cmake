#    "libspnav", "lib3mf"

vcpkg_download_distfile(
    QT6_PATCH
    URLS https://patch-diff.githubusercontent.com/raw/openscad/openscad/pull/4929.patch
    FILENAME qt6.patch
    SHA512 90509bd7e82f192d19db136a50c230e63882bc380ea74ce9cb7195a49eb7c215f056ff29da62eaf9d8e3fbddef05ab85f74d0c38bb25d6d6d8176ffcfae480d5
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO openscad/openscad
    REF 358af340cc7ad87be454e78a53d6424e1364214b
    SHA512 145afa7b98e8487a9200e50e6572e53f6f51b7cfe8a8682c10a876060488da8659c08ee4e3a17735cd36773ea5984e15c2ac671907061ddb7d08d40612d1c942
    PATCHES
      ${QT6_PATCH}
      bld-fix.patch
)

vcpkg_find_acquire_program(FLEX)
cmake_path(GET FLEX PARENT_PATH FLEX_DIR)
vcpkg_add_to_path("${FLEX_DIR}")

vcpkg_find_acquire_program(BISON)
cmake_path(GET BISON PARENT_PATH BISON_DIR)
vcpkg_add_to_path("${BISON_DIR}")

vcpkg_find_acquire_program(PYTHON3)
cmake_path(GET PYTHON3 PARENT_PATH PYTHON3_DIR)
vcpkg_add_to_path("${PYTHON3_DIR}")

vcpkg_acquire_msys(MSYS_ROOT PACKAGES gettext)
vcpkg_add_to_path("${MSYS_ROOT}/usr/bin")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -DUSE_QT6=ON
      -DUSE_GLAD=ON
      -DUSE_GLEW=OFF
      -DENABLE_TBB=OFF
      -DENABLE_PYTHON=ON # Experimental
      -DENABLE_QTDBUS=ON
      -DENABLE_TESTS=OFF
    MAYBE_UNUSED_VARIABLES

)

vcpkg_cmake_install()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
file(RENAME "${CURRENT_PACKAGES_DIR}" "${CURRENT_PACKAGES_DIR}_tmp")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/")
file(RENAME "${CURRENT_PACKAGES_DIR}_tmp" "${CURRENT_PACKAGES_DIR}/tools/${PORT}")
file(RENAME "${CURRENT_PACKAGES_DIR}/tools/${PORT}/share" "${CURRENT_PACKAGES_DIR}/share" )
vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/${PORT}")

file(TOUCH "${CURRENT_PACKAGES_DIR}/tools/${PORT}/libraries/MCAD/NotEmpty")

file(COPY "${CURRENT_INSTALLED_DIR}/tools/Qt6/bin/qt.conf" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/tools/${PORT}/qt.conf" "Prefix=./../../../" "Prefix=./../../")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
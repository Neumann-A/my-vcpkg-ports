vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://code.qt.io/qt-solutions/qt-solutions.git"
    REF "11730d44910a51953a0a64237667617c5c623361"
    PATCHES 
        qt6.patch
        small_fix.patch
        compare.patch
)
vcpkg_qmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/qtpropertybrowser"
    QMAKE_OPTIONS
        "CONFIG+=qtpropertybrowser-uselib"
        "CONFIG+=create_prl"
        #"CONFIG+=create_pc"
)
vcpkg_qmake_install()
vcpkg_copy_pdbs()

file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(TOUCH "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright") # BSD but no lcense file?
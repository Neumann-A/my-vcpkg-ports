#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO narunlifescience/AlphaPlot
    REF 8682095ca5aa923249aa4d183d55d4770573131a
    SHA512 1a9dd647cd47e88155d7d056b4722d6fcba5ce017cadafc4a416ceacecf7492cd1b62557a4474976e4ebe5c202d036be529eae2e7cb8a1246e8f425893dd3f9c
    HEAD_REF master
    PATCHES qt6.patch
            ext_dep.patch
            #muparser_wchar_t.patch
)

vcpkg_qmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    QMAKE_OPTIONS
        "QT_CONFIG-=no-pkg-config"
        "CONFIG+=link_pkgconfig"
        "DEFINES+=QCUSTOMPLOT_USE_OPENGL"
)
vcpkg_qmake_install()
vcpkg_copy_pdbs()


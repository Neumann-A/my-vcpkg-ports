
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://code.qt.io/qt/qtscript.git"
    REF "2c1ffc66bf5d5db05018d7b06253b5ca51e557ab"
    PATCHES qt6.patch
)

vcpkg_find_acquire_program(PERL) # Perl is probably required by all qt ports for syncqt
get_filename_component(PERL_PATH ${PERL} DIRECTORY)
vcpkg_add_to_path(${PERL_PATH})

execute_process(COMMAND "${PERL}" 
                        -w "${CURRENT_HOST_INSTALLED_DIR}/tools/Qt6/bin/syncqt.pl" 
                        -quiet
                        -check-includes 
                        -module QtScript
                        -version 6.2.2
                        -outdir "${SOURCE_PATH}"
                        -builddir "${SOURCE_PATH}"
                        "${SOURCE_PATH}"
                WORKING_DIRECTORY "${SOURCE_PATH}")
execute_process(COMMAND "${PERL}" 
                        -w "${CURRENT_HOST_INSTALLED_DIR}/tools/Qt6/bin/syncqt.pl" 
                        -quiet
                        -check-includes 
                        -module QtScriptTools
                        -version 6.2.2
                        -outdir "${SOURCE_PATH}"
                        -builddir "${SOURCE_PATH}"
                        "${SOURCE_PATH}"
                WORKING_DIRECTORY "${SOURCE_PATH}")

vcpkg_qmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    QMAKE_OPTIONS "DEFINES+=QT_NO_REGEXP"
)
vcpkg_qmake_install()
vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/LICENSE.GPL3" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
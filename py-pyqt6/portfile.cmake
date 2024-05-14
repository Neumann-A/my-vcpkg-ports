set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
set(VCPKG_BUILD_TYPE release)

vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    PyQt6
    VERSION         ${VERSION}
    SHA512          c2ff8c47c9b0e43c009d0c90f565a54344e6f384c67dd30c2d422465d0702c07713acc0095c8b67827d1146675611c07d548ba282a26e41bb60a0a21977a7a64
)

# https://www.riverbankcomputing.com/static/Docs/PyQt6/installation.html
set(SIPBUILD_ARGS
  "--confirm-license"
  "--qmake" "${CURRENT_INSTALLED_DIR}/tools/Qt6/bin/qmake${VCPKG_HOST_EXECUTABLE_SUFFIX}"
  "--api-dir" "${CURRENT_PACKAGES_DIR}/share/Qt6/qsci/api/python"
  "--verbose"
  "--qt-shared"
  "--no-make"
  "--disable" "QtDesigner"
  "--pep484-pyi"
  "--build-dir" "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
  "--target-dir" "${PYTHON3_SITEPACKAGES}"
)

if(VCPKG_TARGET_IS_OSX)
    if(DEFINED VCPKG_OSX_DEPLOYMENT_TARGET)
        vcpkg_list(APPEND SIPBUILD_ARGS "--qmake-setting" "QMAKE_MACOSX_DEPLOYMENT_TARGET=${VCPKG_OSX_DEPLOYMENT_TARGET}")
    else()
        # https://doc.qt.io/qt-6/macos.html
        vcpkg_list(APPEND SIPBUILD_ARGS "--qmake-setting" "QMAKE_MACOSX_DEPLOYMENT_TARGET=10.15")
    endif()
    vcpkg_list(APPEND SIPBUILD_ARGS "--no-dbus-python")
endif()


vcpkg_backup_env_variables(VARS PATH)

vcpkg_add_to_path(PREPEND "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Scripts/" "${CURRENT_HOST_INSTALLED_DIR}/tools/Qt6/bin/" "${CURRENT_HOST_INSTALLED_DIR}/bin")

message(STATUS "Running sipbuild...")
vcpkg_execute_required_process(
    COMMAND "${PYTHON3}" "-m" "sipbuild.tools.build" ${SIPBUILD_ARGS}
    WORKING_DIRECTORY "${SOURCE_PATH}"
    LOGNAME "sipbuild-${TARGET_TRIPLET}"
)
message(STATUS "Running sipbuild...finished.")

# inventory.txt is consumed by the distinfo tool which is run during make and should be run against the package directory
file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}" NATIVE_INSTALLED_DIR)
vcpkg_replace_string("${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/inventory.txt"
            "${CURRENT_INSTALLED_DIR}"
            "${CURRENT_PACKAGES_DIR}")
            vcpkg_replace_string("${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/inventory.txt"
            "${NATIVE_INSTALLED_DIR}"
            "${CURRENT_PACKAGES_DIR}")

vcpkg_qmake_build(BUILD_LOGNAME "install" TARGETS "install")

vcpkg_restore_env_variables(VARS PATH)

vcpkg_python_test_import(MODULE "PyQt6.QtCore")

vcpkg_python_test_import(MODULE "PyQt-builder")

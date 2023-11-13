vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO matplotlib/matplotlib
    REF v${VERSION}
    SHA512 9309a12573019181bd3e150e954dae23bdbfb138ee4b2ffbc025691158568b8743ca8f9e337b7adb4c3c5b50fa8e085138a5022faab2d927cea39451347cfbc7
    HEAD_REF main
)

set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig;${CURRENT_INSTALLED_DIR}/share/pkgconfig")
set(ENV{INCLUDE} "${CURRENT_INSTALLED_DIR}/include;$ENV{INCLUDE}")

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -Csetup-args=-Dsystem-freetype=true -Csetup-args=-Dsystem-qhull=true -x)

file(GLOB licenses "${SOURCE_PATH}/LICENSE/*")

vcpkg_install_copyright(FILE_LIST ${licenses})

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

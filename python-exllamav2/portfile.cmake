vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO turboderp/exllamav2
    REF v${VERSION}
    SHA512 db71001ded08898428d9366cbca8e7fca7634f01aa1a199f835f84d9e1b4673cecc3d8e9e12915167f6e2a360990251438392fdcfa80dbcccbe3d0cdc3569476
    HEAD_REF master
)

set(ENV{DISTUTILS_USE_SDK} 1)

set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib glog.lib")
set(ENV{CL} "$ENV{CL} /I${CURRENT_INSTALLED_DIR}/include/torch/csrc/api/include /I${CURRENT_INSTALLED_DIR}/include /DGLOG_NO_ABBREVIATED_SEVERITIES -DNOMINMAX")

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

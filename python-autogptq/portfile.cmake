vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PanQiWei/AutoGPTQ
    REF v${VERSION}
    SHA512 60365bea69d3ccf7f2c9c927557161bd7ba7c299f6bdd8a8a486b7ae531d492db3ac5e2a2b88f53df1025c9044148f95e781514167858b5eddf089edecaee398
    HEAD_REF main
)

set(ENV{DISTUTILS_USE_SDK} 1)

#vcpkg_rust_install()
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3/Scripts") # for maturin
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3")
set(ENV{PYTHON} "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")
set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib glog.lib")
set(ENV{CL} "$ENV{CL} /I${CURRENT_INSTALLED_DIR}/include/torch/csrc/api/include /I${CURRENT_INSTALLED_DIR}/include /DGLOG_NO_ABBREVIATED_SEVERITIES -DNOMINMAX")

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

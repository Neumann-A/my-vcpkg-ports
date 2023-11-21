vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PanQiWei/AutoGPTQ
    REF v${VERSION}
    SHA512 6c1fcc1b22339c5f9c7a852c241fb6e5bbcc914505f505302f7b9494b91b0d58c33d758afbc2198e6cf03bf44bfb451455eeb2074dc1b996c3b06688874862d9
    HEAD_REF main
)

set(ENV{DISTUTILS_USE_SDK} 1)

#vcpkg_rust_install()
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3/Scripts") # for maturin
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3")
set(ENV{PYTHON} "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")
set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib glog.lib")
set(ENV{CL} "$ENV{CL} /I${CURRENT_INSTALLED_DIR}/include/torch/csrc/api/include /I${CURRENT_INSTALLED_DIR}/include /DGLOG_NO_ABBREVIATED_SEVERITIES -DNOMINMAX")

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

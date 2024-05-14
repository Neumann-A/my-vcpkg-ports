vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PanQiWei/AutoGPTQ
    REF v${VERSION}
    SHA512 b46dc1f7ae772a27e142fa5879181207a3769a7f8a96470917ae68cb21d19207afec184f5fb71ca855b4f4f1b7ddfcb15b40cb4109874e747c3f625e30c08a7a
    HEAD_REF main
)

set(ENV{DISTUTILS_USE_SDK} 1)
set(ENV{TORCH_DONT_CHECK_COMPILER_ABI} 1)

#vcpkg_rust_install()
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3/Scripts") # for maturin
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3")
set(ENV{PYTHON} "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")
set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib glog.lib")
set(ENV{CL} "$ENV{CL} /I${CURRENT_INSTALLED_DIR}/include/torch/csrc/api/include /I${CURRENT_INSTALLED_DIR}/include /DGLOG_NO_ABBREVIATED_SEVERITIES -DNOMINMAX -DGLOG_USE_GLOG_EXPORT")

vcpkg_python_build_and_install_wheel(USE_BUILD SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "auto_gptq")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/tokenizers
    REF v${VERSION}
    SHA512 b584a93aa7b07eeea6e871eb7f90f0a1965175ef2eb3dd5ba422c82dc57f5c551f5fee882e3387a8df32baf1bfa17bab7516cefb105821c3e53de867dcd7ff84
    HEAD_REF main
)

#set(ENV{DISTUTILS_USE_SDK} 1)

#set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib glog.lib")
#set(ENV{CL} "$ENV{CL} /I${CURRENT_INSTALLED_DIR}/include/torch/csrc/api/include /I${CURRENT_INSTALLED_DIR}/include /DGLOG_NO_ABBREVIATED_SEVERITIES -DNOMINMAX")

vcpkg_rust_install()
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3/Scripts") # for maturin
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3")
set(ENV{PYTHON} "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")

set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib")

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/bindings/python")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/tokenizers
    REF v${VERSION}
    SHA512 7d0eec43ed97ff12075d93a81345439cdd39ac41f2c4606d26aa01249fade8549c778f44e411556b1ebd142fe761fce63eb15cd159cc49cae9fc15a2233b10bd
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

vcpkg_python_test_import(MODULE "tokenizers")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mideind/Tokenizer
    REF ${VERSION}
    SHA512 43c216dee5064bc1ed50d18476cffe7459a8585c793d12698da188935ebe993dbb189b179b9ad3b6bfb567c9a14aef3b18600f269d94100201ffbf313ce28f39
    HEAD_REF master
)

#set(ENV{DISTUTILS_USE_SDK} 1)

#set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib glog.lib")
#set(ENV{CL} "$ENV{CL} /I${CURRENT_INSTALLED_DIR}/include/torch/csrc/api/include /I${CURRENT_INSTALLED_DIR}/include /DGLOG_NO_ABBREVIATED_SEVERITIES -DNOMINMAX")

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

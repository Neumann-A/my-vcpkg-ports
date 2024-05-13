vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO turboderp/exllamav2
    REF v${VERSION}
    SHA512 90d107c85a07ccacc98d4179878ea7e50da6f0b643beb80bfaa3e5333a8b19f5b2aaa28c95203d5ebd562546336f24e2e90773c9641e83f1e5c6b907a79adeca
    HEAD_REF master
)

set(ENV{DISTUTILS_USE_SDK} 1)
set(ENV{TORCH_DONT_CHECK_COMPILER_ABI} 1)

set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib glog.lib")
set(ENV{CL} "$ENV{CL} /I${CURRENT_INSTALLED_DIR}/include/torch/csrc/api/include /I${CURRENT_INSTALLED_DIR}/include /DGLOG_NO_ABBREVIATED_SEVERITIES -DNOMINMAX -DGLOG_USE_GLOG_EXPORT")

vcpkg_python_build_and_install_wheel(USE_BUILD SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "exllamav2")

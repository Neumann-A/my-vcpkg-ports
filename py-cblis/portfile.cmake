vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/cython-blis
    REF v${VERSION}
    SHA512 49ab87d80e082ce6ae1be24f1acd08e3bf75666eb978f0fb37e655e84e9d111d6ac0d6b1faaefec49cdbbc3c29c0d8d0d9acd96ba836319fef842950a5eca63c
    HEAD_REF main
    PATCHES
      build.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_BLIS_PATH
    REPO explosion/blis
    REF 8137f660d8351c3a3c3b38f4606121578e128b70
    SHA512 62d99f06544c658692cb1d95825fb6148781a9051c7a38e695e934f8baa566ffc52b5f479dc7e2f7e834951f5b4130f278508d2551011c41b50bbd8d4efd8091
    HEAD_REF main
)

file(COPY "${SOURCE_BLIS_PATH}/" DESTINATION "${SOURCE_PATH}/flame-blis" )

# Compiles something with clang?
#vcpkg_replace_string( "cython<3.0" "cython")
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "blis")

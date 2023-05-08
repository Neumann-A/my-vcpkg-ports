vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO JuliaLang/julia
    REF 8e630552924eac54c809aa7bc30871c7df1582d3
    SHA512 6b7513322f3a10d58cbce81a526138bbe23ffa07274c74e7846f68fddd78aeec5ec375624957d688887c02e787258a71f648f465ef4933f4aa7b514924ba8cb1
    HEAD_REF master
)

vcpkg_find_acquire_program(PYTHON3)
#x_vcpkg_get_python_packages(PYTHON_EXECUTABLE "${PYTHON3}" PACKAGES html5lib)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
vcpkg_add_to_path("${PYTHON3_DIR}")

file(TOUCH "${SOURCE_PATH}/configure")
vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    SKIP_CONFIGURE
    COPY_SOURCE
    USE_WRAPPERS
    )

vcpkg_build_make(
    BUILD_TARGET default
)
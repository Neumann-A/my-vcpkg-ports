vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO onnx/onnx
    REF "v${VERSION}"
    SHA512 b46a4ab70af88053318eba45251c1f71528f15e45a33042877570e8d857febd3ec66e2e811fcda2105a4f17b84c9a1c6a0aaa22756c3287321b3ea29e83127fd
    PATCHES
        fix-cmakelists.patch
        fix-dependency-protobuf.patch
        fix-build.patch
        fix-python.patch
)

string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "static" USE_STATIC_RUNTIME)

# ONNX_USE_PROTOBUF_SHARED_LIBS: find the library and check its file extension
find_library(PROTOBUF_LIBPATH NAMES protobuf PATHS "${CURRENT_INSTALLED_DIR}/bin" "${CURRENT_INSTALLED_DIR}/lib" REQUIRED)
get_filename_component(PROTOBUF_LIBNAME "${PROTOBUF_LIBPATH}" NAME)
if(PROTOBUF_LIBNAME MATCHES "${CMAKE_SHARED_LIBRARY_SUFFIX}")
    set(USE_PROTOBUF_SHARED ON)
else()
    set(USE_PROTOBUF_SHARED OFF)
endif()

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        python BUILD_ONNX_PYTHON
)

# Like protoc, python is required for codegen.
#vcpkg_find_acquire_program(PYTHON3)

# PATH for .bat scripts so it can find 'python'
#get_filename_component(PYTHON_DIR "${PYTHON3}" PATH)
vcpkg_add_to_path(PREPEND "${CURRENT_HOST_INSTALLED_DIR}/tools/python3")



if("python" IN_LIST FEATURES)
    # When BUILD_ONNX_PYTHON, we need Development component. Give a hint for FindPython3
    list(APPEND FEATURE_OPTIONS
        "-DPython3_ROOT_DIR=${CURRENT_INSTALLED_DIR}"
    )
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        #-DPython3_EXECUTABLE=${PYTHON3}
        -DONNX_ML=ON
        -DONNX_GEN_PB_TYPE_STUBS=ON
        -DONNX_USE_PROTOBUF_SHARED_LIBS=${USE_PROTOBUF_SHARED}
        -DONNX_USE_LITE_PROTO=OFF
        -DONNX_USE_MSVC_STATIC_RUNTIME=${USE_STATIC_RUNTIME}
        -DONNX_BUILD_TESTS=OFF
        -DONNX_BUILD_BENCHMARKS=OFF
        -DProtobuf_FOUND=ON
    MAYBE_UNUSED_VARIABLES
        ONNX_USE_MSVC_STATIC_RUNTIME
)

if("python" IN_LIST FEATURES)
    # This target is not in install/export
    vcpkg_cmake_build(TARGET onnx_cpp2py_export)
endif()
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/ONNX)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
  vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/onnx/onnx_pb.h" "defined(ONNX_BUILD_SHARED_LIBS)" "1")
endif()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
    # the others are empty
    "${CURRENT_PACKAGES_DIR}/include/onnx/backend"
    "${CURRENT_PACKAGES_DIR}/include/onnx/bin"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/controlflow"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/generator"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/logical"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/math"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/nn"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/object_detection"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/optional"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/quantization"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/reduction"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/rnn"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/sequence"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/traditionalml"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/training"
    "${CURRENT_PACKAGES_DIR}/include/onnx/examples"
    "${CURRENT_PACKAGES_DIR}/include/onnx/frontend"
    "${CURRENT_PACKAGES_DIR}/include/onnx/onnx_cpp2py_export"
    "${CURRENT_PACKAGES_DIR}/include/onnx/test"
    "${CURRENT_PACKAGES_DIR}/include/onnx/tools"
    "${CURRENT_PACKAGES_DIR}/include/onnx/onnx_ml"
    "${CURRENT_PACKAGES_DIR}/include/onnx/onnx_data"
    "${CURRENT_PACKAGES_DIR}/include/onnx/onnx_operators_ml"
    "${CURRENT_PACKAGES_DIR}/include/onnx/reference/ops"
    "${CURRENT_PACKAGES_DIR}/include/onnx/reference"
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/image" 
    "${CURRENT_PACKAGES_DIR}/include/onnx/defs/text"
)

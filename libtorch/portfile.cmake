vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytorch/pytorch
    REF "v${VERSION}"
    SHA512 67f7e9a096c3ffb952206ebf9105bedebb68c24ad82456083adf1d1d210437fcaa9dd52b68484cfc97d408c9eebc9541c76868c34a7c9982494dc3f424cfb07c
    HEAD_REF master
    PATCHES
        cmake-fixes.patch
        more-fixes.patch
        fix-build.patch
        clang-cl.patch
        fix-api.patch
        fix-compile.patch
        #disable-cuda-check.patch
)
file(REMOVE_RECURSE "${SOURCE_PATH}/caffe2/core/macros.h") # We must use generated header files

vcpkg_from_github(
    OUT_SOURCE_PATH src_kineto
    REPO pytorch/kineto
    REF 3f30237e868ca92b46b309da17d84b37be373a6e
    SHA512 33afc04463ac5f254eb723c9ed0988c6d6789b3d8cb9bb6f31a7ba2ade8cef98fd3bdff37915e0148d70676741b4f5084ed15e58252af2c6ef4c6eb7bdf5eaed
    HEAD_REF main
    PATCHES 
      kineto.patch
)
file(COPY "${src_kineto}/" DESTINATION "${SOURCE_PATH}/third_party/kineto")

vcpkg_from_github(
    OUT_SOURCE_PATH src_cudnn
    REPO NVIDIA/cudnn-frontend # new port ?
    REF 150798fe976556078f443fdb059a1ff0361f58a2
    SHA512 f7f5f4f6d0011ffe3691aa442aab53a48d87f5a4dbeeeb156b188de634267382b7bc5c9f2ca665eaf2408d7a29bd05850df2905135c8bf51fa66ff94b19c8135
    HEAD_REF main
)
file(COPY "${src_cudnn}/" DESTINATION "${SOURCE_PATH}/third_party/cudnn_frontend")


vcpkg_from_github(
    OUT_SOURCE_PATH src_cutlass
    REPO NVIDIA/cutlass # new port ?
    REF bbe579a9e3beb6ea6626d9227ec32d0dae119a49
    SHA512 b7d3cc102d28acee55821a0731d1741572635e677f037c5f78f4a526be4ec4faf8bba7f31226ccb6ac006d40d87c963a72fd9ff495b9fa18131520d1601d2e7a
    HEAD_REF main
)
file(COPY "${src_cutlass}/" DESTINATION "${SOURCE_PATH}/third_party/cutlass")

file(REMOVE 
  "${SOURCE_PATH}/cmake/Modules/FindBLAS.cmake"
  "${SOURCE_PATH}/cmake/Modules/FindLAPACK.cmake"
  "${SOURCE_PATH}/cmake/Modules/FindCUDA.cmake"
  "${SOURCE_PATH}/cmake/Modules/FindCUDAToolkit.cmake"
  "${SOURCE_PATH}/cmake/Modules/Findpybind11.cmake"
)

find_program(FLATC NAMES flatc PATHS "${CURRENT_HOST_INSTALLED_DIR}/tools/flatbuffers" REQUIRED NO_DEFAULT_PATH NO_CMAKE_PATH)
message(STATUS "Using flatc: ${FLATC}")

vcpkg_execute_required_process(
    COMMAND ${FLATC} --cpp --no-prefix --scoped-enums --gen-mutable mobile_bytecode.fbs #--gen-object-api 
    LOGNAME codegen-flatc-mobile_bytecode
    WORKING_DIRECTORY "${SOURCE_PATH}/torch/csrc/jit/serialization"
)

find_program(PROTOC NAMES protoc PATHS "${CURRENT_HOST_INSTALLED_DIR}/tools/protobuf" REQUIRED NO_DEFAULT_PATH NO_CMAKE_PATH)
message(STATUS "Using protoc: ${PROTOC}")

#x_vcpkg_get_python_packages(
#    PYTHON_VERSION 3
#    PACKAGES typing-extensions pyyaml numpy
#    OUT_PYTHON_VAR PYTHON3
#)
set(PYTHON3 "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}")
message(STATUS "Using Python3: ${PYTHON3}")

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    dist    USE_DISTRIBUTED # MPI, Gloo, TensorPipe
    zstd    USE_ZSTD
    fbgemm  USE_FBGEMM
    opencv  USE_OPENCV
    # These are alternatives !
    # tbb     USE_TBB
    # tbb     AT_PARALLEL_NATIVE_TBB # AT_PARALLEL_ are alternatives
    # openmp  USE_OPENMP
    # openmp  AT_PARALLEL_OPENMP # AT_PARALLEL_ are alternatives
    leveldb USE_LEVELDB
    opencl  USE_OPENCL
    cuda    USE_CUDA
    cuda    USE_CUDNN
    cuda    USE_NCCL
    cuda    USE_SYSTEM_NCCL
    cuda    USE_NVRTC
    cuda    AT_CUDA_ENABLED
    cuda    AT_CUDNN_ENABLED
    #tensorrt USE_TENSORRT
    vulkan  USE_VULKAN
    #vulkan  USE_VULKAN_SHADERC_RUNTIME
    vulkan  USE_VULKAN_RELAXED_PRECISION
    rocm    USE_ROCM  # This is an alternative not a feature! (Not in vcpkg.json!)
    llvm    USE_LLVM
    nnpack  USE_NNPACK  # todo: check use of `DISABLE_NNPACK_AND_FAMILY`
    nnpack  AT_NNPACK_ENABLED
    xnnpack USE_XNNPACK
    qnnpack USE_QNNPACK # todo: check use of `USE_PYTORCH_QNNPACK`
    python  BUILD_PYTHON
    python  USE_NUMPY
)

#if(CMAKE_CXX_COMPILER_ID MATCHES GNU) # this does nothing
#    list(APPEND FEATURE_OPTIONS -DUSE_NATIVE_ARCH=ON)
#endif()

if("dist" IN_LIST FEATURES)
    if(VCPKG_TARGET_IS_LINUX OR VCPKG_TARGET_IS_OSX)
        list(APPEND FEATURE_OPTIONS -DUSE_TENSORPIPE=ON)
    endif()
    if(VCPKG_TARGET_IS_WINDOWS OR VCPKG_TARGET_IS_OSX)
        list(APPEND FEATURE_OPTIONS -DUSE_LIBUV=ON)
    endif()
    list(APPEND FEATURE_OPTIONS -DUSE_GLOO=${VCPKG_TARGET_IS_LINUX})
endif()

if(VCPKG_TARGET_IS_ANDROID OR VCPKG_TARGET_IS_IOS)
    list(APPEND FEATURE_OPTIONS -DINTERN_BUILD_MOBILE=ON)
else()
    list(APPEND FEATURE_OPTIONS -DINTERN_BUILD_MOBILE=OFF)
endif()

string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "static" USE_STATIC_RUNTIME)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        --trace-expand
        ${FEATURE_OPTIONS}
        -DProtobuf_PROTOC_EXECUTABLE:FILEPATH=${PROTOC}
        -DCAFFE2_CUSTOM_PROTOC_EXECUTABLE:FILEPATH=${PROTOC}
        -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON3}
        #-DPython3_EXECUTABLE:FILEPATH=${PYTHON3}
        -DCAFFE2_STATIC_LINK_CUDA=ON
        -DCAFFE2_USE_MSVC_STATIC_RUNTIME=${USE_STATIC_RUNTIME}
        -DBUILD_CUSTOM_PROTOBUF=OFF
        -DUSE_LITE_PROTO=OFF
        -DBUILD_TEST=OFF
        -DATEN_NO_TEST=ON
        -DUSE_SYSTEM_LIBS=ON
        -DUSE_METAL=OFF
        -DUSE_PYTORCH_METAL=OFF
        -DUSE_PYTORCH_METAL_EXPORT=OFF
        -DUSE_GFLAGS=ON
        -DUSE_GLOG=ON
        -DUSE_LMDB=ON
        -DUSE_ITT=OFF
        -DUSE_ROCKSDB=ON
        -DUSE_OBSERVERS=OFF
        -DUSE_PYTORCH_QNNPACK=OFF
        -DUSE_KINETO=OFF
        -DUSE_ROCM=OFF
        -DUSE_NUMA=OFF
        -DUSE_SYSTEM_ONNX=ON
        -DUSE_SYSTEM_FP16=ON
        -DUSE_SYSTEM_EIGEN_INSTALL=ON
        -DUSE_SYSTEM_CPUINFO=ON
        -DUSE_SYSTEM_PTHREADPOOL=ON
        -DUSE_SYSTEM_PYBIND11=ON
        -DUSE_SYSTEM_ZSTD=ON
        -DUSE_SYSTEM_XNNPACK=ON
        -DUSE_SYSTEM_GLOO=ON
        -DUSE_SYSTEM_NCCL=ON
        -DUSE_SYSTEM_LIBS=ON
        #-DUSE_MPI=${VCPKG_TARGET_IS_LINUX}
        -DBUILD_JNI=${VCPKG_TARGET_IS_ANDROID}
        -DUSE_NNAPI=${VCPKG_TARGET_IS_ANDROID}
        ${BLAS_OPTIONS}
        # BLAS=MKL not supported in this port
        -DUSE_MKLDNN=OFF
        -DUSE_MKLDNN_CBLAS=OFF
        -DCAFFE2_USE_MKL=ON
        -DAT_MKL_ENABLED=ON
        -DAT_MKLDNN_ENABLED=OFF
        -DUSE_OPENCL=ON
        -DUSE_NUMPY=ON
        -DUSE_MAGMA=ON
        -DUSE_KINETO=OFF #
    OPTIONS_RELEASE
      -DPYTHON_LIBRARY=${CURRENT_INSTALLED_DIR}/lib/python311.lib
    OPTIONS_DEBUG
      -DPYTHON_LIBRARY=${CURRENT_INSTALLED_DIR}/debug/lib/python311_d.lib
    MAYBE_UNUSED_VARIABLES
        USE_NUMA
        USE_SYSTEM_BIND11
        MKLDNN_CPU_RUNTIME
)
#vcpkg_cmake_build(TARGET __aten_op_header_gen LOGFILE_BASE build-header_gen) # explicit codegen is required
#vcpkg_cmake_build(TARGET torch_cpu  LOGFILE_BASE build-torch_cpu)
vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(PACKAGE_NAME caffe2 CONFIG_PATH "share/cmake/Caffe2" DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME torch CONFIG_PATH "share/cmake/Torch")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/torch/TorchConfig.cmake" "/../../../" "/../../")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/caffe2/Caffe2Config.cmake" "/../../../" "/../../")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/caffe2/Caffe2Config.cmake" 
  "set(Caffe2_MAIN_LIBS torch_library)" 
  "set(Caffe2_MAIN_LIBS torch_library)\nfind_dependency(Eigen3)")



# Traverse the folder and remove "some" empty folders
function(cleanup_once folder)
    if(NOT IS_DIRECTORY "${folder}")
        return()
    endif()
    file(GLOB paths LIST_DIRECTORIES true "${folder}/*")
    list(LENGTH paths count)
    # 1. remove if the given folder is empty
    if(count EQUAL 0)
        file(REMOVE_RECURSE "${folder}")
        message(STATUS "Removed ${folder}")
        return()
    endif()
    # 2. repeat the operation for hop 1 sub-directories 
    foreach(path ${paths})
        cleanup_once(${path})
    endforeach()
endfunction()

# Some folders may contain empty folders. They will become empty after `cleanup_once`.
# Repeat given times to delete new empty folders.
function(cleanup_repeat folder repeat)
    if(NOT IS_DIRECTORY "${folder}")
        return()
    endif()
    while(repeat GREATER_EQUAL 1)
        math(EXPR repeat "${repeat} - 1" OUTPUT_FORMAT DECIMAL)
        cleanup_once("${folder}")
    endwhile()
endfunction()

cleanup_repeat("${CURRENT_PACKAGES_DIR}/include" 5)
cleanup_repeat("${CURRENT_PACKAGES_DIR}/lib/site-packages" 13)

#file(COPY "${CURRENT_PACKAGES_DIR}/lib/site-packages/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/" FILES_MATCHING PATTERN "*.py*")
#file(COPY "${SOURCE_PATH}/torch/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/torch" FILES_MATCHING PATTERN "*.py*")
#file(COPY "${SOURCE_PATH}/torchgen/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/torchgen" FILES_MATCHING PATTERN "*.py*")
#file(COPY "${SOURCE_PATH}/functorch/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/torch" FILES_MATCHING PATTERN "*.py*")

file(REMOVE_RECURSE
   #"${CURRENT_PACKAGES_DIR}/lib/site-packages"
   #"${CURRENT_PACKAGES_DIR}/debug/lib/site-packages"
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
    #"${CURRENT_PACKAGES_DIR}/share/cmake/ATen"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/torch/_C"
#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/torch/_C_flatbuffer"

if("python" IN_LIST FEATURES)
  set(ENV{USE_SYSTEM_LIBS} 1)
  vcpkg_replace_string("${SOURCE_PATH}/setup.py" "@TARGET_TRIPLET@" "${TARGET_TRIPLET}-rel")
  vcpkg_replace_string("${SOURCE_PATH}/tools/setup_helpers/env.py" "@TARGET_TRIPLET@" "${TARGET_TRIPLET}-rel")
  vcpkg_replace_string("${SOURCE_PATH}/torch/utils/cpp_extension.py" "@TARGET_TRIPLET@" "${TARGET_TRIPLET}-rel")
  vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")
endif()

set(VCPKG_POLICY_DLLS_WITHOUT_EXPORTS enabled) # torch_global_deps.dll is empty.c and just for linking deps

set(config "${CURRENT_PACKAGES_DIR}/share/torch/TorchConfig.cmake")
file(READ "${config}" contents)
string(REGEX REPLACE "set\\\(NVTOOLEXT_HOME[^)]+" "set(NVTOOLEXT_HOME \"\${CMAKE_CURRENT_LIST_DIR}/../../tools/cuda/\"" contents "${contents}")
string(REGEX REPLACE "\\\${NVTOOLEXT_HOME}/lib/x64/nvToolsExt64_1.lib" "" contents "${contents}")
file(WRITE "${config}" "${contents}")

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/torch/csrc/autograd/custom_function.h" "struct TORCH_API Function" "struct Function")

#  in py-exllamav2
# E:\all\vcpkg\installed\x64-windows-release\tools\python3\Lib\site-packages\torch\utils\cpp_extension.py:383: UserWarning: Error checking compiler version for cl: Command 'cl' returned non-zero exit status 2.
#  warnings.warn(f'Error checking compiler version for {compiler}: {error}')
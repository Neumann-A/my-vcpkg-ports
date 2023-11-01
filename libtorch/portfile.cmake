vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytorch/pytorch
    REF "v${VERSION}" # 7bcf7da3a268b435777fe87c7794c382f444e86d
    SHA512 e2fec0fa5e7c6f7445ba16f795578629646ca78c94c74ef89bf1748e98db21fba23aa98f7cce23bcda5420eae89400e02fc3dd047129916cecbc36e579a03908
    HEAD_REF master
    PATCHES
        #pytorch-pr-85958.patch # https://github.com/pytorch/pytorch/pull/85958
        #fix-cmake.patch
        #fix-fbgemm-include.patch
        #fix-c10-glog.patch
        #use-flatbuffers2.patch # check with codegen-flatc-mobile_bytecode
        #fix-windows.patch # https://github.com/pytorch/pytorch/issues/87957
        #fix_werror.patch
        cmake-fixes.patch
)
file(REMOVE_RECURSE "${SOURCE_PATH}/caffe2/core/macros.h") # We must use generated header files


vcpkg_from_github(
    OUT_SOURCE_PATH src_kineto
    REPO pytorch/kineto
    REF 49e854d805d916b2031e337763928d2f8d2e1fbf
    SHA512 ae63d48dc5b8ac30c38c2ace60f16834c7e9275fa342dc9f109d4fbc87b7bd674664f6413c36d0c1ab5a7da786030a4108d83daa4502b2f30239283ea3acdb16
    HEAD_REF main
)
file(COPY "${src_kineto}/" DESTINATION "${SOURCE_PATH}/third_party/kineto")

vcpkg_from_github(
    OUT_SOURCE_PATH src_cudnn
    REPO NVIDIA/cudnn-frontend # new port ?
    REF 12f35fa2be5994c1106367cac2fba21457b064f4
    SHA512 a7e4bf58f82ca0b767df35da1b3588e2639ea2ef22ed0c47e989fb4cde5a28b0605b228b42fcaefbdf721bfbb91f2a9e7d41352ff522bd80b63db6d27e44ec20
    HEAD_REF main
)
file(COPY "${src_cudnn}/" DESTINATION "${SOURCE_PATH}/third_party/cudnn_frontend")


file(REMOVE 
  "${SOURCE_PATH}/cmake/Modules/FindBLAS.cmake"
  "${SOURCE_PATH}/cmake/Modules/FindLAPACK.cmake"
  "${SOURCE_PATH}/cmake/Modules/FindCUDA.cmake"
  "${SOURCE_PATH}/cmake/Modules/FindCUDAToolkit.cmake"
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
    zstd    USE_SYSTEM_ZSTD
    fftw3   USE_FFTW
    fftw3   AT_FFTW_ENABLED
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
    vulkan  USE_VULKAN
    vulkan  USE_VULKAN_WRAPPER
    vulkan  USE_VULKAN_SHADERC_RUNTIME
    vulkan  USE_VULKAN_RELAXED_PRECISION
    rocm    USE_ROCM  # This is an alternative not a feature! (Not in vcpkg.json!)
    llvm    USE_LLVM
    nnpack  USE_NNPACK  # todo: check use of `DISABLE_NNPACK_AND_FAMILY`
    nnpack  AT_NNPACK_ENABLED
    xnnpack USE_XNNPACK
    xnnpack USE_SYSTEM_XNNPACK
    qnnpack USE_QNNPACK # todo: check use of `USE_PYTORCH_QNNPACK`
    python  BUILD_PYTHON
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

# BLAS: MKL, OpenBLAS, or Accelerate
#   The feature will be disabled if "generic" BLAS is not found
#if(VCPKG_TARGET_IS_OSX OR VCPKG_TARGET_IS_IOS)
#    list(APPEND BLAS_OPTIONS -DBLAS=Accelerate -DUSE_BLAS=ON)
#elseif(VCPKG_TARGET_IS_WINDOWS)
#    list(APPEND BLAS_OPTIONS -DBLAS=OpenBLAS -DUSE_BLAS=ON)
#elseif(VCPKG_TARGET_IS_LINUX)
#    list(APPEND BLAS_OPTIONS -DBLAS=generic -DUSE_BLAS=ON)
#endif()

if("tbb" IN_LIST FEATURES)
    list(APPEND FEATURE_OPTIONS -DMKLDNN_CPU_RUNTIME=TBB)
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
        ${FEATURE_OPTIONS}
        -DProtobuf_PROTOC_EXECUTABLE:FILEPATH=${PROTOC}
        -DCAFFE2_CUSTOM_PROTOC_EXECUTABLE:FILEPATH=${PROTOC}
        -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON3}
        -DPython3_EXECUTABLE:FILEPATH=${PYTHON3}
        -DCAFFE2_USE_MSVC_STATIC_RUNTIME=${USE_STATIC_RUNTIME}
        -DBUILD_CUSTOM_PROTOBUF=OFF
        -DUSE_LITE_PROTO=OFF
        -DBUILD_TEST=OFF
        -DATEN_NO_TEST=ON
        -DUSE_SYSTEM_LIBS=ON
        -DBUILD_PYTHON=OFF
        -DUSE_NUMPY=OFF
        -DUSE_METAL=OFF
        -DUSE_PYTORCH_METAL=OFF
        -DUSE_PYTORCH_METAL_EXPORT=OFF
        -DUSE_GFLAGS=ON
        -DUSE_GLOG=ON
        -DUSE_LMDB=ON
        -DUSE_ITT=OFF
        -DUSE_ROCKSDB=OFF
        -DUSE_OBSERVERS=OFF 
        -DUSE_PYTORCH_QNNPACK=OFF
        -DUSE_KINETO=OFF
        -DUSE_ROCM=OFF
        -DUSE_DEPLOY=OFF
        -DUSE_NUMA=OFF
        -DUSE_SYSTEM_ONNX=ON
        -DUSE_SYSTEM_FP16=ON
        -DUSE_SYSTEM_EIGEN_INSTALL=ON
        -DUSE_SYSTEM_CPUINFO=ON
        -DUSE_SYSTEM_PTHREADPOOL=ON
        -DUSE_MPI=${VCPKG_TARGET_IS_LINUX}
        -DBUILD_JNI=${VCPKG_TARGET_IS_ANDROID}
        -DUSE_NNAPI=${VCPKG_TARGET_IS_ANDROID}
        ${BLAS_OPTIONS}
        -DUSE_SYSTEM_PYBIND11=ON
        # BLAS=MKL not supported in this port
        -DUSE_MKLDNN=OFF
        -DUSE_MKLDNN_CBLAS=OFF
        -DCAFFE2_USE_MKL=OFF
        -DCAFFE2_USE_MKLDNN=OFF
        -DAT_MKL_ENABLED=OFF
        -DAT_MKLDNN_ENABLED=OFF
        -DUSE_OPENCL=ON
        -DUSE_NUMPY=ON
        -DUSE_MAGMA=OFF
        -DUSE_KINETO=OFF #
    OPTIONS_RELEASE
      -DPYTHON_LIBRARY=${CURRENT_INSTALLED_DIR}/lib/python3.lib
    OPTIONS_DEBUG
      -DPYTHON_LIBRARY=${CURRENT_INSTALLED_DIR}/debug/lib/python3_d.lib
    MAYBE_UNUSED_VARIABLES
        USE_NUMA
        USE_SYSTEM_BIND11
        USE_VULKAN_WRAPPER
        MKLDNN_CPU_RUNTIME
)
vcpkg_cmake_build(TARGET __aten_op_header_gen LOGFILE_BASE build-header_gen) # explicit codegen is required
vcpkg_cmake_build(TARGET torch_cpu  LOGFILE_BASE build-torch_cpu)
vcpkg_cmake_install()
vcpkg_copy_pdbs()

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

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
    "${CURRENT_PACKAGES_DIR}/share/cmake/ATen"
)
cleanup_repeat("${CURRENT_PACKAGES_DIR}/include" 5)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

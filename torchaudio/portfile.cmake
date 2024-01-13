vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytorch/audio
    REF "v${VERSION}"
    SHA512 b7b6d849246f5fb9be78c5fc5aa41dbd9f240bafe827db0f547dfb9f43b52a87ce9813bdb7ef886e0880b0f30d4f212a066da1dbe10075e2786b681fdf746307
    HEAD_REF main
    PATCHES 
      fix-build.patch
      fix_cuda.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    openmp      USE_OPENMP
    cuda        USE_CUDA
    cuda        BUILD_CUDA_CTC_DECODER
    extension   BUILD_TORCHAUDIO_PYTHON_EXTENSION
)

if(VCPKG_TARGET_IS_WINDOWS)
  list(APPEND FEATURE_OPTIONS -DBUILD_SOX=OFF)
endif()

set(VCPKG_CONCURRENCY 2)
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DUSE_FFMPEG=ON
)
vcpkg_cmake_install()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(COPY "${SOURCE_PATH}/torchaudio" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/torchaudio/lib")
file(RENAME "${CURRENT_PACKAGES_DIR}/lib/" "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/torchaudio/lib")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

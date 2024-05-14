vcpkg_download_distfile(
    ARCHIVE_PATH
    URLS "https://archive.apache.org/dist/arrow/arrow-${VERSION}/apache-arrow-${VERSION}.tar.gz"
    FILENAME apache-arrow-${VERSION}.tar.gz
    SHA512 773f4f3eef603032c8ba0cfdc023bfd2a24bb5e41c82da354a22d7854ab153294ede1f4782cc32b27451cf1b58303f105bac61ceeb3568faea747b93e21d79e4
)
vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE ${ARCHIVE_PATH}
    PATCHES 
      fix-build.patch
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}/python"
  OPTIONS 
    -DPYARROW_BUILD_ACERO=ON
    -DPYARROW_BUILD_PARQUET=ON
    -DPYARROW_BUILD_DATASET=ON
    -DPYARROW_BUILD_ORC=ON
    -DPYARROW_BUNDLE_ARROW_CPP=OFF
)

vcpkg_cmake_install()

file(GLOB_RECURSE includes "${CURRENT_PACKAGES_DIR}/include/*")
list(FILTER includes EXCLUDE REGEX "/python/")

file(REMOVE_RECURSE ${includes}
  ${CURRENT_PACKAGES_DIR}/lib.h
  ${CURRENT_PACKAGES_DIR}/lib_api.h
)

vcpkg_replace_string("${SOURCE_PATH}/python/setup.py" "self._run_cmake()" "")

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/python" 
OPTIONS 
  #-Cbdist_dir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel 
  #-C--build-dir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel
)

#file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/")
#file(INSTALL "${SOURCE_PATH}/python/pyarrow/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/pyarrow")

file(GLOB_RECURSE pyds "${CURRENT_PACKAGES_DIR}/lib/*.pyd")
file(COPY ${pyds} DESTINATION "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}/pyarrow")

file(REMOVE ${pyds})

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")


file(REMOVE_RECURSE 
"${CURRENT_PACKAGES_DIR}/include/arrow/acero" 
"${CURRENT_PACKAGES_DIR}/include/arrow/adapters" 
"${CURRENT_PACKAGES_DIR}/include/arrow/array" 
"${CURRENT_PACKAGES_DIR}/include/arrow/c" 
"${CURRENT_PACKAGES_DIR}/include/arrow/compute" 
"${CURRENT_PACKAGES_DIR}/include/arrow/csv"
"${CURRENT_PACKAGES_DIR}/include/arrow/dataset"
"${CURRENT_PACKAGES_DIR}/include/arrow/extension"
"${CURRENT_PACKAGES_DIR}/include/arrow/filesystem"
"${CURRENT_PACKAGES_DIR}/include/arrow/io"
"${CURRENT_PACKAGES_DIR}/include/arrow/ipc"
"${CURRENT_PACKAGES_DIR}/include/arrow/json"
"${CURRENT_PACKAGES_DIR}/include/arrow/tensor"
"${CURRENT_PACKAGES_DIR}/include/arrow/testing"
"${CURRENT_PACKAGES_DIR}/include/arrow/util"
"${CURRENT_PACKAGES_DIR}/include/arrow/vendored"
)

file(WRITE "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}/pyarrow-${VERSION}.dist-info/METADATA"
"Metadata-Version: 2.1\n\
Name: pyarrow\n\
Version: ${VERSION}"
)

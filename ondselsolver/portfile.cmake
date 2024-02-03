vcpkg_from_github(
    OUT_SOURCE_PATH src_path
    REPO Ondsel-Development/OndselSolver
    REF fe99ad259391b8fd9390f919926aa3c8b6cde787
    SHA512 e494dffd0bfa5ec2da68d8ed84d21038dee16d056dfa17cae3522c8966c75bc83f2293644511e26cdcaa119d7677320abb96a311e7451031e5fdc45830a1e246
    HEAD_REF main
    PATCHES
      lib-type.patch
      fix-math.patch
)

vcpkg_cmake_configure(
  SOURCE_PATH "${src_path}"
  OPTIONS 
    -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS:BOOL=ON
    -DCMAKE_INSTALL_DATAROOTDIR=lib # to move pc files without patching
)

vcpkg_cmake_install()

vcpkg_fixup_pkgconfig()

vcpkg_install_copyright(FILE_LIST "${src_path}/LICENSE")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# ASMTAtPointJoint.h ASMTInLineJoint.h
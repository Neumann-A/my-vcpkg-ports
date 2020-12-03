
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/pcg-cpp
    REF 9f3944e83e85ca1cb29c7962681143876cd75dd7
    SHA512 11f176a5cddad17959541fe52a19d129a3fe160d010b4405ac3de0617d7dbf7773604a51a0f9d7aeb1bae5259fb27f7a320c3960daf040d6ef35fc3830d8dc94
    HEAD_REF vs_2017fix_and_cmake
)

VCPKG_CONFIGURE_CMAKE(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
)

vcpkg_install_cmake()

if("${VCPKG_CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake" TARGET_PATH "share")
else()
vcpkg_fixup_cmake_targets(CONFIG_PATH "cmake")
endif()

# Put the licence file where vcpkg expects it
file(COPY ${SOURCE_PATH}/LICENSE-MIT.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/pcg-cpp)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/pcg-cpp/LICENSE-MIT.txt ${CURRENT_PACKAGES_DIR}/share/pcg-cpp/copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib)
# Copy the pcg-cpp header files
file(INSTALL ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR} FILES_MATCHING PATTERN "*.hpp")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/pyproject-hooks
    REF 4c9325f4e594bfc7178452d0d01eb8da6c3dbbdb
    SHA512 953744e215798c2d7e88e0a0d1c7d64d06a21031659ba3e5f056786c5c0b6c57d3b0c6d26593ca77fedc947e5ccd50019a5797bfd052dea4461afca28371fc3a
    HEAD_REF main
)

file(COPY "${SOURCE_PATH}/src/pyproject_hooks" DESTINATION "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

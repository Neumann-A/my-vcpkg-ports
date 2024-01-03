set(ref a5acb6845bf25ec9163020ea02d95e473051569b)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/setuptools_scm
    REF "${ref}"
    SHA512 cfbafa8a675f2c00a36583bee2ff38e4b603a79da545c8427bbb4d9c8d1d543fec8fffcd5e9a14c2d92a1965d115f4e77b4242169de5b9b92f6c9ada37fd1f89
    HEAD_REF master
)
 
vcpkg_find_acquire_program(GIT)
cmake_path(GET GIT PARENT_PATH GIT_DIR)
vcpkg_add_to_path("${GIT_DIR}")

vcpkg_get_mecurial(HG)
cmake_path(GET HG PARENT_PATH HG_DIR)
vcpkg_add_to_path("${HG_DIR}")

set(git_working_directory "${SOURCE_PATH}")
set(giturl "https://github.com/pypa/setuptools_scm.git")

#unset(PYTHON3)
#x_vcpkg_get_python_packages(PYTHON_VERSION "3" OUT_PYTHON_VAR "PYTHON3" PACKAGES setuptools_scm[toml])

vcpkg_execute_required_process(
    ALLOW_IN_DOWNLOAD_MODE
    COMMAND "${GIT}" init "${git_working_directory}"
    WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}"
    LOGNAME "git-init-${TARGET_TRIPLET}"
)
vcpkg_execute_required_process(
    ALLOW_IN_DOWNLOAD_MODE
    COMMAND "${GIT}" fetch "${giturl}" "${ref}" --depth 1 -n
    WORKING_DIRECTORY "${git_working_directory}"
    LOGNAME "git-fetch-${TARGET_TRIPLET}"
)

#SETUPTOOLS_SCM_PRETEND_VERSION
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}") #OPTIONS -Cconfig=toml -Cextras=toml)#-C--build-option=[toml])

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)


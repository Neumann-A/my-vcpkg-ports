vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/huggingface_hub
    REF v${VERSION}
    SHA512 c92e150845c1773b1240bd70eabfcd476492cb8e907499277490715eb58641698a069edaf09164d5d72a6c4e427eec7e90da7a0c6550a553965e8245c8aaf433
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "huggingface_hub")

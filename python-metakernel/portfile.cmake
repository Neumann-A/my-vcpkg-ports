vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Calysto/metakernel
    REF 67b6c68ea49753d5c0b7afc591e9204de64fbace
    SHA512 4bf93afc1b1a51987e2fd042eec8d49ac60b9e7b1fa46531d4c1334e8845e95e3d6a19b6d32925e0c52466d36abc65f5c91d65b1254f0d36d7854709fbb495c9
    HEAD_REF main
)


file(COPY "${SOURCE_PATH}/metakernel" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
set(VCPKG_POLICY_ALLOW_EMPTY_FOLDERS enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nirvanaos/nidl2cpp
    REF 4440ad26e494af9be36294bf9dce7a21a0c3b5fd
    SHA512 ab17598b8d04e7951223a8d867f1b9beed606632cc3da4cd1203d17ae181486c5f9c4eb2f41284506ff0e393116ff0e718762aee791a70e4780ea4d9da7073ef
    HEAD_REF 1.0.1
)

#vcpkg_from_git(
#    OUT_SOURCE_PATH SOURCE_PATH
#    URL "https://github.com/nirvanaos/nidl2cpp"
#    REF "8aaaabb36108f0e60ff63817da8ff1fedbf1cae7"
#)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME ${PORT})
vcpkg_copy_tools(TOOL_NAMES ${PORT} AUTO_CLEAN)

file(INSTALL "${SOURCE_PATH}/license-lgpl.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)


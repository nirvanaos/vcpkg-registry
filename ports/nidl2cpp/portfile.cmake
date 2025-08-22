set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
set(VCPKG_POLICY_ALLOW_EMPTY_FOLDERS enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nirvanaos/nidl2cpp
    REF a4014b5cd56efd6421bda7b18adeb1277751ddad
    SHA512 26f097e310c935d6531c9f1fb47deb9e118da97704eef19dad9a9e0aadc891239293406ecf31139786ce36eb61bb0568adead3cfed7bb1f3a3abaa81d181a106
    HEAD_REF develop
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


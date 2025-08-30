set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
set(VCPKG_POLICY_ALLOW_EMPTY_FOLDERS enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nirvanaos/nidl2cpp
    REF 4a1abf9897d1444810c759fc706f8dd80a2999db
    SHA512 f7a27aaab1c15b34c2ca1ae83da3dbd493552dce9cb13b8ee0c4836857cb75a6161a35b6ff62c9428b815c8d08405d46a978dd780537cf87c19c4466a31dc3f6
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


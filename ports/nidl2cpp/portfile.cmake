set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
set(VCPKG_POLICY_ALLOW_EMPTY_FOLDERS enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nirvanaos/nidl2cpp
    REF d1380965800628154234eeddf06ca0802414fbc6
    SHA512 b3baa59de3ffccd39d5296b532e8020408f1906c98d1c6731a14ed15c911ce1c8f4f01f1f4242f1dc821fa52210ce4cc9d1f45584656822c96a97781f675e93a
    HEAD_REF master
)

#vcpkg_from_git(
#    OUT_SOURCE_PATH SOURCE_PATH
#    URL "https://github.com/nirvanaos/nidl2cpp"
#    REF "d1380965800628154234eeddf06ca0802414fbc6"
#)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME ${PORT})
vcpkg_copy_tools(TOOL_NAMES ${PORT} AUTO_CLEAN)

file(INSTALL "${SOURCE_PATH}/license-lgpl.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)


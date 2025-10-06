set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
set(VCPKG_POLICY_ALLOW_EMPTY_FOLDERS enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nirvanaos/nidl2cpp
    REF 6e1968a3b6b9e2c82a1af619976de528db07e2bf
    SHA512 f700571594ebd5278bda696b9f53312a1737ecdbfdaccc72f2fd364b78b4be1f06d7f6a5e14f0965a4a2eff823033a6811d9f18d79a02973a8df0641c716cb14
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


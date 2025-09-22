vcpkg_check_linkage (ONLY_DYNAMIC_LIBRARY)

find_program (GIT git)

set (GIT_URL "https://github.com/nirvanaos/mock-host.git")
set (BRANCH "develop")
set (COMMIT "31b2dd368a2d4c929fd4ac0a12a7aea11fdb77d5")

set (SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
set (VCPKG_POLICY_SKIP_COPYRIGHT_CHECK enabled)

if (NOT EXISTS "${SOURCE_PATH}/.git")
	message(STATUS "Cloning and fetching submodules")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
	  WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}
	  LOGNAME clone
	)
endif ()

message (STATUS "Pull")
vcpkg_execute_required_process (
  COMMAND ${GIT} pull origin ${BRANCH}
  WORKING_DIRECTORY ${SOURCE_PATH}
  LOGNAME pull
)

message (STATUS "Checkout")
vcpkg_execute_required_process (
  COMMAND ${GIT} checkout ${COMMIT}
  WORKING_DIRECTORY ${SOURCE_PATH}
  LOGNAME checkout
)

#vcpkg_from_github(
#    OUT_SOURCE_PATH SOURCE_PATH
#    REPO nirvanaos/idlfe
#    HEAD_REF master
#)

vcpkg_cmake_configure (
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install ()

vcpkg_cmake_config_fixup (PACKAGE_NAME "mockhost")

file (REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

#file(INSTALL "${SOURCE_PATH}/license-lgpl.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file ("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)

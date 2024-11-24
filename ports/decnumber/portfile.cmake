vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

find_program(GIT git)

set(GIT_URL "https://github.com/nirvanaos/decNumber.cmake.git")
set(BRANCH "master")
set(COMMIT "f243aa964e91d3300d7fe996692b6a57a42b25a6")

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})

if(NOT EXISTS "${SOURCE_PATH}/.git")
	message(STATUS "Cloning and fetching submodules")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
	  WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}
	  LOGNAME clone
	)
endif()

message(STATUS "Pull")
vcpkg_execute_required_process(
  COMMAND ${GIT} pull origin ${BRANCH}
  WORKING_DIRECTORY ${SOURCE_PATH}
  LOGNAME pull
)

message(STATUS "Checkout ${COMMIT}")
vcpkg_execute_required_process(
  COMMAND ${GIT} checkout ${COMMIT}
  WORKING_DIRECTORY ${SOURCE_PATH}
  LOGNAME checkout
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME ${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/decNumber/ICU-license.html" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright.html)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)

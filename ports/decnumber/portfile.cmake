vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

find_program(GIT git)

set(GIT_URL "https://github.com/nirvanaos/decNumber.cmake.git")
set(BRANCH "master")
set(COMMIT "35bbab59d8d581203029ae5f542537ad6921146f")

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

vcpkg_cmake_config_fixup(PACKAGE_NAME decNumber)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/decNumber/ICU-license.html")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)

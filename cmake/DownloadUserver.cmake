# Copied from get_cpm.cmake
set(CPM_DOWNLOAD_VERSION 0.39.0)
set(CPM_HASH_SUM "66639bcac9dd2907b2918de466783554c1334446b9874e90d38e3778d404c2ef")
set(CPM_DOWNLOAD_LOCATION "${CMAKE_BINARY_DIR}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
file(DOWNLOAD
    https://github.com/cpm-cmake/CPM.cmake/releases/download/v${CPM_DOWNLOAD_VERSION}/CPM.cmake
    ${CPM_DOWNLOAD_LOCATION} EXPECTED_HASH SHA256=${CPM_HASH_SUM}
)
include(${CPM_DOWNLOAD_LOCATION})


function(download_userver)
  set(OPTIONS)
  set(ONE_VALUE_ARGS VERSION TRY_DIR)
  set(MULTI_VALUE_ARGS FEATURES FEATURES_OFF)
  cmake_parse_arguments(
      ARG "${OPTIONS}" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}" ${ARGN}
  )
  if(NOT ARG_VERSION)
    set(ARG_VERSION develop)
  endif()

  if(ARG_TRY_DIR AND EXISTS ${ARG_TRY_DIR})
    add_subdirectory(${ARG_TRY_DIR})
    return()
  endif()

  set(CMAKE_OPTIONS)
  foreach(FEATURE ${ARG_FEATURES})
    list(APPEND CMAKE_OPTIONS "USERVER_FEATURE_${FEATURE} ON")
  endforeach()
  foreach(FEATURE ${ARG_FEATURES_OFF})
    list(APPEND CMAKE_OPTIONS "USERVER_FEATURE_${FEATURE} OFF")
  endforeach()

  CPMAddPackage(
      NAME userver
      GITHUB_REPOSITORY userver-framework/userver
      GIT_TAG ${ARG_VERSION}
      OPTIONS ${CMAKE_OPTIONS}
  )
endfunction()

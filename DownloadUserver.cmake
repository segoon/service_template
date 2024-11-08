include(FetchContent)

function(download_userver)
  set(OPTIONS)
  set(ONE_VALUE_ARGS VERSION)
  set(MULTI_VALUE_ARGS FEATURES FEATURES_OFF)
  cmake_parse_arguments(
      ARG "${OPTIONS}" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}" ${ARGN}
  )
  if(NOT ARG_VERSION)
    set(ARG_VERSION develop)
  endif()

  set(FETCHCONTENT_QUIET OFF CACHE BOOL "" FORCE)
  FetchContent_Declare(
    userver
    GIT_REPOSITORY https://github.com/userver-framework/userver.git
    GIT_TAG ${ARG_VERSION}
  )
  FetchContent_MakeAvailable(userver)

  foreach(FEATURE ${ARG_FEATURES})
    set(USERVER_FEATURE_${FEATURE} ON CACHE BOOL "" FORCE)
  endforeach()
  foreach(FEATURE ${ARG_FEATURES_OFF})
    set(USERVER_FEATURE_${FEATURE} OFF CACHE BOOL "" FORCE)
  endforeach()
endfunction()

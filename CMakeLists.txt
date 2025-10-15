
cmake_minimum_required(VERSION 3.18 FATAL_ERROR)
project(cxx-dependencies VERSION 0.0.1)

if(CMAKE_VERSION VERSION_LESS 3.21) 
    set(PROJECT_IS_TOP_LEVEL ${CMAKE_PROJECT_NAME} STREQUAL ${PROJECT_NAME})
endif()

if(NOT ENABLE_BUNDLED_DEPENDENCIES AND NOT PROJECT_IS_TOP_LEVEL)
    return()
endif()

if(PROJECT_IS_TOP_LEVEL)
    message(STATUS "Building dependencies standalone")
    if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
        set_property(CACHE CMAKE_INSTALL_PREFIX PROPERTY VALUE "${CMAKE_CURRENT_BINARY_DIR}/deps-install")
    endif()
    set(_cxx_dependencies_install_path ${CMAKE_INSTALL_PREFIX})
    set(_cxx_dependencies_build_path "${CMAKE_CURRENT_BINARY_DIR}/deps-build")
else()
    message(STATUS "Building dependencies as sub-project")
    set(_cxx_dependencies_install_path "${CMAKE_CURRENT_BINARY_DIR}/deps-install")
    set(_cxx_dependencies_build_path "${CMAKE_CURRENT_BINARY_DIR}/deps-build")
    # list(APPEND CMAKE_BUILD_RPATH "${_cxx_dependencies_install_path}")
    # set(CMAKE_BUILD_RPATH "${CMAKE_BUILD_RPATH}" PARENT_SCOPE)
    list(APPEND CMAKE_PREFIX_PATH "${_cxx_dependencies_install_path}")
    set(CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH}" PARENT_SCOPE)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH OFF PARENT_SCOPE)
    message(STATUS "Added ${_cxx_dependencies_install_path} to CMAKE_PREFIX_PATH")
    message(STATUS "New CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}")
endif()

if(EXISTS "${_cxx_dependencies_install_path}/._built")
    message(STATUS "Dependencies already built, skipping...")
    return()
endif()

message(STATUS "Building dependencies...")

file(MAKE_DIRECTORY "${_cxx_dependencies_install_path}")

message(STATUS "Running build.sh...")
execute_process(
    COMMAND ${CMAKE_COMMAND} -E env 
        INSTALL_PREFIX=${_cxx_dependencies_install_path}
        BUILD_PATH=${_cxx_dependencies_build_path}
        ./build.sh
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    RESULT_VARIABLE _cxx_dependencies_build_result
)

if(NOT _cxx_dependencies_build_result EQUAL 0)
    message(FATAL_ERROR "Failed to build dependencies:\nSTDOUT:\n${BUILD_OUTPUT}\nSTDERR:\n${BUILD_ERROR}")
else()
    message(STATUS "Successfully built dependencies")
    file(TOUCH "${_cxx_dependencies_install_path}/._built")
endif()


# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

cmake_minimum_required(VERSION 4.0)

project(
    CppTemplate
    DESCRIPTION "A generic C++ project template"
    LANGUAGES CXX
    VERSION 0.1.0
)

option(
    CPPTEMPLATE_BUILD_TESTS
    "Enable building tests and test infrastructure. Default: ${PROJECT_IS_TOP_LEVEL}. Values: { ON, OFF }."
    ${PROJECT_IS_TOP_LEVEL}
)
option(
    CPPTEMPLATE_BUILD_EXAMPLES
    "Enable building examples. Default: ${PROJECT_IS_TOP_LEVEL}. Values: { ON, OFF }."
    ${PROJECT_IS_TOP_LEVEL}
)

include(cmake/InstallLibrary.cmake)
include(cmake/BuildTelemetryConfig.cmake)
include(cmake/ExportCompileCommands.cmake)

add_library(CppTemplate INTERFACE)
add_library(CppTemplate::CppTemplate ALIAS CppTemplate)

target_compile_features(CppTemplate INTERFACE cxx_std_20)
target_sources(
    CppTemplate
    PUBLIC
        FILE_SET HEADERS
            BASE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/include"
            FILES "${CMAKE_CURRENT_SOURCE_DIR}/include/cpptemplate/cpptemplate.hpp"
)
set_target_properties(
    CppTemplate
    PROPERTIES VERIFY_INTERFACE_HEADER_SETS ${PROJECT_IS_TOP_LEVEL}
)

cpp_install_library(
    CppTemplate
    TARGETS CppTemplate
    NAMESPACE CppTemplate::
)
configure_build_telemetry()
cpptemplate_export_shared_compile_commands("${CMAKE_SOURCE_DIR}/build")

if(CPPTEMPLATE_BUILD_TESTS)
  enable_testing()
  add_subdirectory(tests)
endif()

if(CPPTEMPLATE_BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()

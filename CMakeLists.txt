# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

cmake_minimum_required(VERSION 3.20)

project(
    CppTemplate
    DESCRIPTION "A generic C++ project template"
    LANGUAGES CXX
    VERSION 0.1.0
)

option(
    CPPTEMPLATE_BUILD_TESTS
    "Build unit tests"
    ${PROJECT_IS_TOP_LEVEL}
)
option(
    CPPTEMPLATE_BUILD_EXAMPLES
    "Build example programs"
    ${PROJECT_IS_TOP_LEVEL}
)

add_library(CppTemplate INTERFACE)
add_library(CppTemplate::CppTemplate ALIAS CppTemplate)

target_include_directories(
    CppTemplate
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_compile_features(CppTemplate INTERFACE cxx_std_20)

include(GNUInstallDirs)

install(
    TARGETS CppTemplate
    EXPORT CppTemplateTargets
)

install(
    DIRECTORY include/cpptemplate
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
    EXPORT CppTemplateTargets
    FILE CppTemplateTargets.cmake
    NAMESPACE CppTemplate::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/CppTemplate
)

include(CMakePackageConfigHelpers)

configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/CppTemplateConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/CppTemplateConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/CppTemplate
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/CppTemplateConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/CppTemplateConfig.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/CppTemplateConfigVersion.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/CppTemplate
)

if(CPPTEMPLATE_BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

if(CPPTEMPLATE_BUILD_EXAMPLES)
    add_subdirectory(examples)
endif()

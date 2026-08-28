# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

find_package(GTest CONFIG REQUIRED)

add_executable(cpptemplate_tests)
target_sources(cpptemplate_tests PRIVATE version_test.cpp)
target_link_libraries(
    cpptemplate_tests
    PRIVATE
        CppTemplate::CppTemplate
        GTest::gtest_main
)

include(GoogleTest)
gtest_discover_tests(cpptemplate_tests DISCOVERY_TIMEOUT 60)

# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

find_package(GTest REQUIRED)

add_executable(beman.CppTemplate.tests.todo)
target_sources(beman.CppTemplate.tests.todo PRIVATE todo.test.cpp)
target_link_libraries(
    beman.CppTemplate.tests.todo
    PRIVATE beman::CppTemplate GTest::gtest_main
)
if(BEMAN_EXEMPLAR_USE_MODULES)
    set_target_properties(
        beman.CppTemplate.tests.todo
        PROPERTIES CXX_MODULE_STD ON
    )
endif()

include(GoogleTest)
gtest_discover_tests(beman.CppTemplate.tests.todo DISCOVERY_TIMEOUT 60)

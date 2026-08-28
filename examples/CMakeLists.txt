# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

add_executable(cpptemplate_basic_example basic.cpp)
target_link_libraries(
    cpptemplate_basic_example
    PRIVATE CppTemplate::CppTemplate
)

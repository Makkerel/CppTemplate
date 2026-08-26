# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

if(BEMAN_CPPTEMPLATE_USE_MODULES)
    target_sources(
        beman.CppTemplate
        PUBLIC
            FILE_SET CXX_MODULES FILES CppTemplate.cppm
            FILE_SET HEADERS
                FILES
                    config.hpp
                    CppTemplate.hpp
                    todo.hpp
                    "${PROJECT_BINARY_DIR}/include/beman/CppTemplate/config_generated.hpp"
    )
else()
    target_sources(
        beman.CppTemplate
        PUBLIC
            FILE_SET HEADERS
                FILES
                    config.hpp
                    CppTemplate.hpp
                    todo.hpp
                    "${PROJECT_BINARY_DIR}/include/beman/CppTemplate/config_generated.hpp"
    )
endif()

# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

set(ALL_EXAMPLES todo)
message("Examples to be built: ${ALL_EXAMPLES}")

foreach(example ${ALL_EXAMPLES})
    add_executable(beman.CppTemplate.examples.${example})
    target_sources(beman.CppTemplate.examples.${example} PRIVATE ${example}.cpp)
    target_link_libraries(
        beman.CppTemplate.examples.${example}
        PRIVATE beman::CppTemplate
    )
    if(BEMAN_CPPTEMPLATE_USE_MODULES)
        set_target_properties(
            beman.CppTemplate.examples.${example}
            PROPERTIES CXX_MODULE_STD ON
        )
    endif()
endforeach()

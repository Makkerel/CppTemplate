# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

include_guard(GLOBAL)

# Link the active preset's compile_commands.json to a stable path for clangd.
function(cpptemplate_export_shared_compile_commands destination_dir)
    if(NOT CMAKE_EXPORT_COMPILE_COMMANDS OR NOT PROJECT_IS_TOP_LEVEL)
        return()
    endif()

    set(shared_db "${destination_dir}/compile_commands.json")
    set(preset_db "${CMAKE_BINARY_DIR}/compile_commands.json")

    file(MAKE_DIRECTORY "${destination_dir}")
    file(REMOVE "${shared_db}")

    if(WIN32)
        # compile_commands.json is written after configure, so copy it on build.
        add_custom_target(
            cpptemplate_update_compile_commands ALL
            COMMAND ${CMAKE_COMMAND} -E copy_if_different "${preset_db}" "${shared_db}"
            COMMENT "Updating ${shared_db} for clangd"
            VERBATIM
        )
    else()
        file(RELATIVE_PATH rel_db "${destination_dir}" "${preset_db}")
        file(CREATE_LINK "${rel_db}" "${shared_db}" SYMBOLIC)
    endif()
endfunction()

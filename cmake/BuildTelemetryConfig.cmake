# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

include_guard(GLOBAL)

set(BUILD_TELEMETRY_DIR "${CMAKE_CURRENT_LIST_DIR}")

function(configure_build_telemetry)
    if(BUILD_TELEMETRY_CONFIGURATION)
        return()
    endif()

    if(CMAKE_VERSION VERSION_LESS "4.3")
        message(
            STATUS
            "CMake version is less than 4.3; cmake_instrumentation build telemetry is unavailable."
        )
        return()
    endif()

    find_program(BUILD_TELEMETRY_BASH bash)
    find_program(BUILD_TELEMETRY_JQ jq)
    if(NOT BUILD_TELEMETRY_BASH OR NOT BUILD_TELEMETRY_JQ)
        message(
            STATUS
            "bash or jq not found; build telemetry disabled on this platform."
        )
        return()
    endif()

    message(STATUS "Configuring build telemetry")

    cmake_instrumentation(
        API_VERSION 1
        DATA_VERSION 1
        OPTIONS staticSystemInformation dynamicSystemInformation trace
        HOOKS
            postGenerate
            preBuild
            postBuild
            preCMakeBuild
            postCMakeBuild
            postCMakeInstall
            postCTest
        CALLBACK "${BUILD_TELEMETRY_BASH}"
        "${BUILD_TELEMETRY_DIR}/telemetry.sh"
    )

    set(
        BUILD_TELEMETRY_CONFIGURATION
        TRUE
        CACHE INTERNAL
        "Flag to ensure build telemetry is configured only once"
    )
endfunction()

# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

include_guard(GLOBAL)

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# cpp_install_library
# ===================
#
# Installs a library target with its public header file sets and optional CMake
# package configuration files.
#
# Usage:
# ------
#   cpp_install_library(<package-name>
#     TARGETS <target1> [<target2> ...]
#     [DEPENDENCIES <dependency1> [<dependency2> ...]]
#     [NAMESPACE <namespace>]
#     [EXPORT_NAME <export-name>]
#     [COMPONENT <component-name>]
#   )
#
# Arguments:
# ----------
#
# package-name
#   Logical package name (e.g. "CppTemplate").
#   Used to derive config file names and cache variable prefixes.
#
# TARGETS (required)
#   List of CMake targets to install.
#
# DEPENDENCIES (optional)
#   Semicolon-separated list, one dependency per entry.
#   Each entry is a valid find_dependency() argument list.
#
# NAMESPACE (optional)
#   Namespace for exported targets.
#   Defaults to "<package-name>::".
#
# EXPORT_NAME (optional)
#   Name of the CMake export set file (without .cmake).
#   Defaults to "<package-name>Targets".
#
# COMPONENT (optional)
#   Base install component name.
#   Defaults to <package-name>.
#
# Cache variables:
# ----------------
#
# CPP_INSTALL_CONFIG_FILE_PACKAGES
#   Allow-list of package names for which config files should be installed.
#
# <PREFIX>_INSTALL_CONFIG_FILE_PACKAGE
#   Per-package override to enable/disable config file installation.
#   <PREFIX> is the uppercased package name with non-alphanumeric characters
#   replaced by underscores.

function(cpp_install_library name)
    set(oneValueArgs NAMESPACE EXPORT_NAME COMPONENT)
    set(multiValueArgs TARGETS DEPENDENCIES)

    cmake_parse_arguments(
        CPP_INSTALL
        ""
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    if(NOT CPP_INSTALL_TARGETS)
        message(FATAL_ERROR "cpp_install_library(${name}): TARGETS must be specified")
    endif()

    if(CMAKE_SKIP_INSTALL_RULES)
        message(
            WARNING
            "cpp_install_library(${name}): not installing targets '${CPP_INSTALL_TARGETS}' due to CMAKE_SKIP_INSTALL_RULES"
        )
        return()
    endif()

    set(_config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${name}")

    if(NOT CPP_INSTALL_NAMESPACE)
        set(CPP_INSTALL_NAMESPACE "${name}::")
    endif()

    if(NOT CPP_INSTALL_EXPORT_NAME)
        set(CPP_INSTALL_EXPORT_NAME "${name}Targets")
    endif()

    if(NOT CPP_INSTALL_COMPONENT)
        set(CPP_INSTALL_COMPONENT "${name}")
    endif()

    set(_development_component "${CPP_INSTALL_COMPONENT}_Development")
    set(_runtime_component "${CPP_INSTALL_COMPONENT}_Runtime")

    foreach(_tgt IN LISTS CPP_INSTALL_TARGETS)
        if(NOT TARGET "${_tgt}")
            message(WARNING "cpp_install_library(${name}): '${_tgt}' is not a target")
            continue()
        endif()

        set_target_properties("${_tgt}" PROPERTIES EXPORT_NAME "${_tgt}")

        set(_install_header_set_args)
        get_target_property(_available_header_sets "${_tgt}" INTERFACE_HEADER_SETS)
        if(_available_header_sets)
            foreach(_install_header_set IN LISTS _available_header_sets)
                list(
                    APPEND _install_header_set_args
                    FILE_SET "${_install_header_set}"
                    COMPONENT "${_development_component}"
                )
            endforeach()
        else()
            set(_install_header_set_args FILE_SET HEADERS)
        endif()

        install(
            TARGETS "${_tgt}"
            EXPORT ${CPP_INSTALL_EXPORT_NAME}
            ARCHIVE COMPONENT "${_development_component}"
            LIBRARY
                COMPONENT "${_runtime_component}"
                NAMELINK_COMPONENT "${_development_component}"
            RUNTIME COMPONENT "${_runtime_component}"
            ${_install_header_set_args}
        )
    endforeach()

    install(
        EXPORT ${CPP_INSTALL_EXPORT_NAME}
        NAMESPACE ${CPP_INSTALL_NAMESPACE}
        DESTINATION "${_config_install_dir}"
        COMPONENT "${_development_component}"
    )

    string(TOUPPER "${name}" _pkg_upper)
    string(REGEX REPLACE "[^A-Z0-9]" "_" _pkg_prefix "${_pkg_upper}")

    option(
        ${_pkg_prefix}_INSTALL_CONFIG_FILE_PACKAGE
        "Enable creating and installing a CMake config-file package. Default: ON. Values: { ON, OFF }."
        ON
    )

    set(_pkg_var "${_pkg_prefix}_INSTALL_CONFIG_FILE_PACKAGE")
    set(_install_config ON)

    if(DEFINED CPP_INSTALL_CONFIG_FILE_PACKAGES)
        if(NOT "${name}" IN_LIST CPP_INSTALL_CONFIG_FILE_PACKAGES)
            set(_install_config OFF)
        endif()
    endif()

    if(DEFINED ${_pkg_var})
        set(_install_config "${${_pkg_var}}")
    endif()

    set(_cpp_find_deps "")
    foreach(dep IN LISTS CPP_INSTALL_DEPENDENCIES)
        string(APPEND _cpp_find_deps "find_dependency(${dep})\n")
    endforeach()
    set(CPP_INSTALL_FIND_DEPENDENCIES "${_cpp_find_deps}")

    if(_install_config)
        set(CPP_INSTALL_BASE_PKG_NAME "${name}")
        set(CPP_INSTALL_EXPORT_NAME "${CPP_INSTALL_EXPORT_NAME}")

        configure_package_config_file(
            "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/PackageConfig.cmake.in"
            "${CMAKE_CURRENT_BINARY_DIR}/${name}Config.cmake"
            INSTALL_DESTINATION "${_config_install_dir}"
        )

        write_basic_package_version_file(
            "${CMAKE_CURRENT_BINARY_DIR}/${name}ConfigVersion.cmake"
            VERSION ${PROJECT_VERSION}
            COMPATIBILITY SameMajorVersion
        )

        install(
            FILES
                "${CMAKE_CURRENT_BINARY_DIR}/${name}Config.cmake"
                "${CMAKE_CURRENT_BINARY_DIR}/${name}ConfigVersion.cmake"
            DESTINATION "${_config_install_dir}"
            COMPONENT "${_development_component}"
        )
    else()
        message(
            WARNING
            "cpp_install_library(${name}): not installing a config package for '${name}'"
        )
    endif()
endfunction()

set(CPACK_GENERATOR TGZ)
include(CPack)

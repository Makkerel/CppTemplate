# CppTemplate

<!--
SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
-->

[![Continuous Integration](https://github.com/kevinzhao/CppTemplate/actions/workflows/ci.yml/badge.svg)](https://github.com/kevinzhao/CppTemplate/actions/workflows/ci.yml)
[![Lint Check (pre-commit)](https://github.com/kevinzhao/CppTemplate/actions/workflows/pre-commit-check.yml/badge.svg)](https://github.com/kevinzhao/CppTemplate/actions/workflows/pre-commit-check.yml)

A generic C++ project template with CMake presets, GoogleTest, examples, and GitHub Actions CI.

## Features

- Header-only library layout under `include/cpptemplate/`
- CMake presets for GCC, Clang, Apple Clang, and MSVC
- Optional examples and unit tests
- vcpkg manifest for GoogleTest (required for tests)
- pre-commit hooks for formatting and linting

## Quick Start

### Prerequisites

- C++20 compiler
- CMake 3.20 or later
- Ninja (recommended)
- vcpkg (required for tests)

Set `VCPKG_ROOT` to your vcpkg installation before configuring.

### Build and Test

```bash
cmake --workflow --preset gcc-release
```

List available workflow presets:

```bash
cmake --list-presets=workflow
```

### Manual Configure

```bash
cmake -B build -S . \
  -DCMAKE_CXX_STANDARD=20 \
  -DCMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake" \
  -DVCPKG_MANIFEST_MODE=ON
cmake --build build
ctest --test-dir build
```

Disable tests or examples when configuring:

```bash
cmake -B build -S . -DCPPTEMPLATE_BUILD_TESTS=OFF -DCPPTEMPLATE_BUILD_EXAMPLES=OFF
```

## Project Layout

```text
.
├── cmake/              # Toolchain files and package config
├── examples/           # Example programs
├── include/cpptemplate # Public headers
├── tests/              # Unit tests
├── CMakeLists.txt
├── CMakePresets.json
└── vcpkg.json
```

## Usage

Include the umbrella header in your project:

```cpp
#include <cpptemplate/cpptemplate.hpp>

int main() {
    return cpptemplate::version_major;
}
```

Link against the CMake target when using this as a dependency:

```cmake
find_package(CppTemplate REQUIRED)
target_link_libraries(your_target PRIVATE CppTemplate::CppTemplate)
```

## Customizing the Template

1. Rename the `cpptemplate` namespace and `include/cpptemplate/` directory to your project name.
2. Update `project(CppTemplate ...)` and target names in `CMakeLists.txt`.
3. Replace the example utilities in `include/cpptemplate/` with your own code.
4. Update badge URLs in this README to point at your repository.

## License

Licensed under the Apache License v2.0 with LLVM Exceptions. See [LICENSE](LICENSE).

<!--
SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
-->

# Contributing

## Build with CMake Presets

The easiest way to configure, build, and test the project is with workflow presets:

```bash
cmake --workflow --preset gcc-debug
```

Use `cmake --list-presets=workflow` to see all available presets.

Debug presets enable sanitizers where supported. Release presets use optimized builds.

## Manual Build

```bash
cmake -B build -S . \
  -DCMAKE_CXX_STANDARD=20 \
  -DCMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
cmake --build build
ctest --test-dir build
```

## Dependencies

GoogleTest is provided exclusively through vcpkg (`vcpkg.json`) when `CPPTEMPLATE_BUILD_TESTS` is enabled. Set `VCPKG_ROOT` and use the vcpkg toolchain file when configuring.

## Project Options

| Option | Default | Description |
|--------|---------|-------------|
| `CPPTEMPLATE_BUILD_TESTS` | `ON` when top-level | Build unit tests |
| `CPPTEMPLATE_BUILD_EXAMPLES` | `ON` when top-level | Build example programs |

## Code Style

Install and run pre-commit hooks before submitting changes:

```bash
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

The repository uses clang-format for C++ and gersemi for CMake files.

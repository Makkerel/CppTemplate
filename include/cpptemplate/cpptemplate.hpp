// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef CPPTEMPLATE_CPPTEMPLATE_HPP
#define CPPTEMPLATE_CPPTEMPLATE_HPP

#include <string>
#include <string_view>

namespace cpptemplate {

inline constexpr int  version_major    = 0;
inline constexpr int  version_minor    = 1;
inline constexpr int  version_patch    = 0;
inline constexpr char version_string[] = "0.1.0";

/// Remove leading and trailing whitespace from a string view.
inline std::string trim(std::string_view text) {
    const auto begin = text.find_first_not_of(" \t\n\r\f\v");
    if (begin == std::string_view::npos) {
        return {};
    }

    const auto end = text.find_last_not_of(" \t\n\r\f\v");
    return std::string{text.substr(begin, end - begin + 1)};
}

} // namespace cpptemplate

#endif // CPPTEMPLATE_CPPTEMPLATE_HPP

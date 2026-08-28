// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef CPPTEMPLATE_STRING_UTILS_HPP
#define CPPTEMPLATE_STRING_UTILS_HPP

#include <string>
#include <string_view>

namespace cpptemplate {

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

#endif // CPPTEMPLATE_STRING_UTILS_HPP

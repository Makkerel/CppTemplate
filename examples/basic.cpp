// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include <cpptemplate/cpptemplate.hpp>

#include <iostream>

int main() {
    std::cout << "cpptemplate version: " << cpptemplate::version_string << '\n';
    std::cout << "trimmed: \"" << cpptemplate::trim("  hello, template!  ") << "\"\n";
    return 0;
}

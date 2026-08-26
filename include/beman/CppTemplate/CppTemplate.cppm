export module beman.CppTemplate;

import std;

#define BEMAN_CPPTEMPLATE_INCLUDED_FROM_INTERFACE_UNIT
export {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winclude-angled-in-module-purview"
#include <beman/CppTemplate/CppTemplate.hpp>
#pragma clang diagnostic pop
}

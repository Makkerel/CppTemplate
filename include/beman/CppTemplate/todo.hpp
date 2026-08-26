// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef BEMAN_CPPTEMPLATE_TODO_HPP
#define BEMAN_CPPTEMPLATE_TODO_HPP

#include <beman/CppTemplate/config.hpp>

#if BEMAN_CPPTEMPLATE_USE_MODULES() && !defined(BEMAN_CPPTEMPLATE_INCLUDED_FROM_INTERFACE_UNIT)

import beman.CppTemplate;

#else

namespace beman::CppTemplate {

// TODO

} // namespace beman::CppTemplate

#endif // BEMAN_CPPTEMPLATE_USE_MODULES() &&
       // !defined(BEMAN_CPPTEMPLATE_INCLUDED_FROM_INTERFACE_UNIT)

#endif // BEMAN_CPPTEMPLATE_TODO_HPP

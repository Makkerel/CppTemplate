// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include <beman/CppTemplate/config.hpp>
#include <gtest/gtest.h>
#include <beman/CppTemplate/todo.hpp>

TEST(TodoTest, todo) {
    const bool todo = true;
    EXPECT_TRUE(todo);
}

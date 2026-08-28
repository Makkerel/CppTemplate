// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include <cpptemplate/cpptemplate.hpp>

#include <gtest/gtest.h>

TEST(VersionTest, reports_expected_values) {
    EXPECT_EQ(cpptemplate::version_major, 0);
    EXPECT_EQ(cpptemplate::version_minor, 1);
    EXPECT_EQ(cpptemplate::version_patch, 0);
    EXPECT_STREQ(cpptemplate::version_string, "0.1.0");
}

TEST(StringUtilsTest, trims_whitespace) {
    EXPECT_EQ(cpptemplate::trim("  hello  "), "hello");
    EXPECT_EQ(cpptemplate::trim(""), "");
    EXPECT_EQ(cpptemplate::trim("   "), "");
}

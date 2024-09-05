require(testthat)

context("Testing regreplace functions")

# Test the groups function
test_that("groups function works correctly", {
  pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
  s <- "Jane is 25"
  expect_equal(groups(pattern, s)$name, "Jane")
  expect_equal(groups(pattern, s)$age, "25")
})

# Test the match_group function
test_that("match_group function works correctly", {
  pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
  s <- "Jane is 25"
  expect_equal(match_group(pattern, s, "name"), "Jane")
})

# Test the replace_group function
test_that("replace_group function works correctly", {
  pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
  s <- "Jane is 25"
  expect_equal(replace_group(pattern, s, "name", "John"), "John is 25")
})

context("Testing Replacer R6 class and methods")

# Test Replacer class initialization
test_that("Replacer class initialization", {
  r <- Replacer$new(pattern="(?P<name>\\w+) is (?P<age>\\d+)")
  expect_equal(r$re, "(?P<name>\\w+) is (?P<age>\\d+)")
})

# Test match method of Replacer class
test_that("Replacer class match method works correctly", {
  r <- Replacer$new(pattern="(?P<name>\\w+) is (?P<age>\\d+)")
  expect_equal(r$match("Jane is 25", "name"), "Jane")
  expect_equal(r$match("Jane is 25", "age"), "25")
})

# Test replace method of Replacer class
test_that("Replacer class replace method works correctly", {
  r <- Replacer$new(pattern="(?P<name>\\w+) is (?P<age>\\d+)")
  expect_equal(r$replace("Jane is 25", "name", "John"), "John is 25")
})

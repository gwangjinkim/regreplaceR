# regregplaceR

This R package provides 4 tiny regex tools to extract, match, and replace named regex groups in strings. 
It contains in addition to 3 functions `groups()`, `match_group()` and `replace_group()` a `R6` class `Replacer` 
which is thought as the main interface of this package.

## Installation

You can install this package by installing it from CRAN or from this github repository.

```r
# install directly from CRAN
install.packages("regreplaceR")

# or install directly from this github repository

# install the devtools package if not already installed
install.packages("devtools")

# install the package from the local directory
devtools::install_github("gwangjinkim/regreplaceR")
```

## Overview

The package offers three core functions to interact with strings using regular expressions with named groups:

- groups(): Extract all named groups from a string.
- match_group(): Extract a specific named group.
- replace_group(): Replace the value of a specific named group.

Additionally, it includes an R6 class called Replacer that encapsulates these functionalities for a more 
object-oriented approach to regex-based operations.

I couldn't use `match()` and `replace()` as generic functions, because there are already generic functions
which require a specific set of arguments.
By using an R6 class, I was free to choose the arguments for `match()` and `replace()`.

## 1. groups()

This function extracts all named groups from a string based on a provided regex pattern.

```r
pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
s <- "Jane is 25"
result <- groups(pattern, s)

# Output:
# $name
# [1] "Jane"
#
# $age
# [1] "25"
```

## 2. match_group()

Extract the value of a specific named group from the string.

```r
pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
s <- "Jane is 25"
name <- match_group(pattern, s, "name")

# Output:
# [1] "Jane"
```

## 3. replace_group()

Replace the value of a specific named group with a new string.

```r
pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
s <- "Jane is 25"
modified <- replace_group(pattern, s, "name", "John")

# Output:
# [1] "John is 25"
```

## 4. The Replacer Class

The Replacer class provides an object-oriented approach to 
regex-based operations. It allows you to create an instance 
with a specific regex pattern and then use it to match or replace 
named groups in strings.

### Example Usage

```r
# Create a new Replacer object
r <- Replacer$new(pattern = ".*?_(?P<date>\\d{8}-\\d{6})(?P<ext>\\..+$)")

# Match a group within a string
date <- r$match("file_20230905-123456.txt", "date")

# Replace the value of a matched group
modified_string <- r$replace("file_20230905-123456.txt", "date", "20240905-123456")
```

## Class Methods

- match(): Extracts the value of a named group from the string.
- replace(): Replaces the value of a named group with a specified string.

## License

This package is licensed under the MIT License. See LICENSE for details.

Happy regexing! If you have any questions or find any bugs, please feel 
free to open an issue on the GitHub repository.

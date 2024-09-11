## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
#  # install directly from CRAN
#  install.packages("regreplaceR")
#  
#  # or install directly from this github repository
#  
#  # install the devtools package if not already installed
#  install.packages("devtools")
#  
#  # install the package directly from this repository
#  devtools::install_github("gwangjinkim/regreplaceR")
#  

## -----------------------------------------------------------------------------
library(regreplaceR)

pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
s <- "Jane is 25"
result <- groups(pattern, s)

# Output:
# $name
# [1] "Jane"
#
# $age
# [1] "25"

## -----------------------------------------------------------------------------
library(regreplaceR)

pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
s <- "Jane is 25"
name <- match_group(pattern, s, "name")

# Output:
# [1] "Jane"

## -----------------------------------------------------------------------------
library(regreplaceR)

pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
s <- "Jane is 25"
modified <- replace_group(pattern, s, "name", "John")

# Output:
# [1] "John is 25"

## -----------------------------------------------------------------------------
library(regreplaceR)

# Create a new Replacer object
r <- Replacer$new(pattern = ".*?_(?P<date>\\d{8}-\\d{6})(?P<ext>\\..+$)")

# Match a group within a string
date <- r$match("file_20230905-123456.txt", "date")

# Replace the value of a matched group
modified_string <- r$replace("file_20230905-123456.txt", "date", "20240905-123456")

## simpler example:

# Create a Replacer object with a regex pattern
r <- Replacer$new(pattern="(?P<name>\\w+) is (?P<age>\\d+)")
   
# Match the "name" group in the string
name_match <- r$match("Jane is 25", "name")
print(name_match)  # Should print "Jane"

# Match the "age" group in the string
age_match <- r$match("Jane is 25", "age")
print(age_match)  # Should print "25"

# Replace the "name" group in the string
replaced_string <- r$replace("Jane is 25", "name", "John")
print(replaced_string)  # Should print "John is 25"



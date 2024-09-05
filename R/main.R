library(R6)

#' Extract Named Groups from a String Using a Regex Pattern
#'
#' This function extracts named groups from a given string using the specified regex pattern.
#' Named groups in the pattern are denoted using `(?P<group_name>...)` syntax.
#'
#' @param pattern A character string containing the regex pattern with named groups.
#' @param s A character string where the pattern will be searched.
#' @param ignore.case Logical. If TRUE, the pattern matching is case-insensitive. Default is FALSE.
#'
#' @return A named list where names are the named groups and values are the extracted strings.
#' If no matches are found, an empty list is returned.
#'
#' @examples
#' pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
#' s <- "Jane is 25"
#' groups(pattern, s)
#' # $name
#' # [1] "Jane"
#' # $age
#' # [1] "25"
#'
#' @export
groups <- function(pattern, s, ignore.case=F) {
    result <- regexpr(pattern, s, perl=T, ignore.case=ignore.case)
    names_ <- attr(result, "capture.names")
    starts_ <- attr(result, "capture.start")
    lengths_ <- attr(result, "capture.length")
    ends_ <- starts_ + lengths_ - 1
    res <- Map(function(start, end) substr(s, start, end), starts_, ends_)
    names(res) <- names_
    res
}


#' Extract a Specific Named Group from a String
#'
#' This function extracts the value of a specific named group from a string using the provided regex pattern.
#'
#' @param pattern A character string containing the regex pattern with named groups.
#' @param s A character string where the pattern will be searched.
#' @param group_name The name of the group to extract from the match.
#' @param ignore.case Logical. If TRUE, the pattern matching is case-insensitive. Default is FALSE.
#'
#' @return The extracted value of the specified named group, or NULL if the group is not found.
#'
#' @examples
#' pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
#' s <- "Jane is 25"
#' match_group(pattern, s, "name")
#' # [1] "Jane"
#'
#' @export
match_group <- function(pattern, s, group_name, ignore.case=F) groups(pattern, s, ignore.case)[[group_name]]


#' Replace a Specific Named Group in a String
#'
#' This function replaces the value of a specific named group in a string using the provided regex pattern.
#'
#' @param pattern A character string containing the regex pattern with named groups.
#' @param s A character string where the pattern will be searched.
#' @param group_name The name of the group to be replaced.
#' @param replacer A string that will replace the matched value of the specified group.
#' @param ignore.case Logical. If TRUE, the pattern matching is case-insensitive. Default is FALSE.
#'
#' @return A modified string where the matched value of the specified group has been replaced by the `replacer`.
#'
#' @examples
#' pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
#' s <- "Jane is 25"
#' replace_group(pattern, s, "name", "John")
#' # [1] "John is 25"
#'
#' @export
replace_group <- function(pattern, s, group_name, replacer, ignore.case=F) {
    result <- regexpr(pattern, s, perl=T, ignore.case=ignore.case)
    names_ <- attr(result, "capture.names")
    starts_ <- attr(result, "capture.start")
    lengths_ <- attr(result, "capture.length")
    ends_ <- starts_ + lengths_ - 1
    paste0(substr(s, 1, starts_[1, group_name]-1),
           replacer,
           substr(s, ends_[1, group_name] + 1, nchar(s)))
}


#' Replacer Class for Regex Operations
#'
#' @description
#' The `Replacer` class encapsulates regex operations using named groups.
#' It allows matching and replacing based on named groups in a regex pattern.
#'
#' @details
#' This class provides methods to match and replace parts of a string based on
#' named groups in regular expressions.
#'
#' @field re A compiled regular expression pattern.
#'
#' @examples
#' # Create a new Replacer object
#' r <- Replacer$new(pattern = ".*?_(?P<date>\\d{8}-\\d{6})(?P<ext>\\..+$)")
#' 
#' # Match a group within a string
#' r$match("file_20230905-123456.txt", "date")
#' 
#' # Replace the value of a matched group
#' r$replace("file_20230905-123456.txt", "date", "20240905-123456")
#' @export
Replacer <- R6::R6Class("Replacer",
  public = list(
    re = NULL,

    #' @description
    #' Create a new Replacer object with a regex pattern.
    #'
    #' @param pattern A character string with a regex pattern that includes named groups.
    #' @return A new `Replacer` object.
    #' @examples
    #' r <- Replacer$new(pattern=".*?_(?P<date>\\d{8}-\\d{6}( \\(1\\))*)(?P<ext>\\..+$)")
    initialize = function(pattern = ".*?_(?P<date>\\d{8}-\\d{6}( \\(1\\))*)(?P<ext>\\..+$)") {
      self$re <- pattern
    },
    
    #' @description
    #' Match a string and extract a group by its name.
    #'
    #' This method matches the string using the regex pattern and extracts the value
    #' of the group specified by `group_name`.
    #'
    #' @param s A character string to match against the regex pattern.
    #' @param group_name The name of the group to extract from the match.
    #' @return The matched value of the group or `NULL` if not found.
    #' @examples
    #' r <- Replacer$new(pattern=".*?_(?P<date>\\d{8}-\\d{6})(?P<ext>\\..+$)")
    #' r$match("file_20230905-123456.txt", "date")
    match = function(s, group_name) {
      m <- groups(self$re, s)
      if (!is.null(m) && group_name %in% names(m)) {
        return(m[[group_name]])
      } else {
        return(NULL)
      }
    },
    
    #' @description
    #' Replace the value of a matched group with a replacement string.
    #'
    #' This method replaces the value of the matched group specified by `group_name`
    #' with the `replacement` string in the input string `s`.
    #'
    #' @param s A character string to perform the replacement on.
    #' @param group_name The name of the group to be replaced.
    #' @param replacement The replacement string.
    #' @return A modified string with the group replaced by the replacement.
    #' @examples
    #' r <- Replacer$new(pattern=".*?_(?P<date>\\d{8}-\\d{6})(?P<ext>\\..+$)")
    #' r$replace("file_20230905-123456.txt", "date", "20240905-123456")
    replace = function(s, group_name, replacement) {
      return(replace_group(self$re, s, group_name, replacement))
    }
  )
)

pkgname <- "regreplaceR"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "regreplaceR-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('regreplaceR')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("Replacer")
### * Replacer

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Replacer
### Title: Replacer Class for Regex Operations
### Aliases: Replacer

### ** Examples

# Create a new Replacer object
r <- Replacer$new(pattern = ".*?_(?P<date>\\d{8}-\\d{6})(?P<ext>\\..+$)")

# Match a group within a string
r$match("file_20230905-123456.txt", "date")

# Replace the value of a matched group
r$replace("file_20230905-123456.txt", "date", "20240905-123456")

## ------------------------------------------------
## Method `Replacer$new`
## ------------------------------------------------

r <- Replacer$new(pattern=".*?_(?P<date>\\d{8}-\\d{6}( \\(1\\))*)(?P<ext>\\..+$)")

## ------------------------------------------------
## Method `Replacer$match`
## ------------------------------------------------

r <- Replacer$new(pattern=".*?_(?P<date>\\d{8}-\\d{6})(?P<ext>\\..+$)")
r$match("file_20230905-123456.txt", "date")

## ------------------------------------------------
## Method `Replacer$replace`
## ------------------------------------------------

r <- Replacer$new(pattern=".*?_(?P<date>\\d{8}-\\d{6})(?P<ext>\\..+$)")
r$replace("file_20230905-123456.txt", "date", "20240905-123456")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Replacer", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("groups")
### * groups

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: groups
### Title: Extract Named Groups from a String Using a Regex Pattern
### Aliases: groups

### ** Examples

pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
s <- "Jane is 25"
groups(pattern, s)
# $name
# [1] "Jane"
# $age
# [1] "25"




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("groups", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("match_group")
### * match_group

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: match_group
### Title: Extract a Specific Named Group from a String
### Aliases: match_group

### ** Examples

pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
s <- "Jane is 25"
match_group(pattern, s, "name")
# [1] "Jane"




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("match_group", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("replace_group")
### * replace_group

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: replace_group
### Title: Replace a Specific Named Group in a String
### Aliases: replace_group

### ** Examples

pattern <- "(?P<name>\\w+) is (?P<age>\\d+)"
s <- "Jane is 25"
replace_group(pattern, s, "name", "John")
# [1] "John is 25"




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("replace_group", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')

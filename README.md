# regexr

[![Build Status](https://travis-ci.org/trinker/regexr.png?branch=master)](https://travis-ci.org/trinker/regexr)
[![Coverage Status](https://coveralls.io/repos/trinker/regexr/badge.png)](https://coveralls.io/r/trinker/regexr)
[![DOI](https://zenodo.org/badge/5398/trinker/regexr.svg)](http://dx.doi.org/10.5281/zenodo.13332)

<img src="inst/regexr_logo/r_regexr.png" alt="">   

> One of the most powerful tools in writing maintainable code is break large methods into well-named smaller methods - a technique Kent Beck refers to as the Composed Method pattern.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[-Martin Fowler-](http://martinfowler.com/bliki/ComposedRegex.html)

[regexr](http://trinker.github.com/regexr_dev) is an R framework for constructing and managing human readable regular expressions.  It aims to provide tools that enable the user to write regular expressions in a way that is similar to the ways R code is written.  The tools allow the user to: 

1. Write in smaller, modular, named, *sub-expressions*    
2. Write top to bottom, rather than a single string    
3. Comment individual chunks    
4. Indent expressions to represent regular expression groups
5. Add vertical line spaces and R comments (i.e., `#`)
6. Test the validity of the *concatenated expression* and the modular *sub-expressions*      

This framework harnesses the power and flexibility of regular expressions but provides a structural frame that is more consistent with both code writing and natural language conventions.  The user decides how to break, indent, name, and comment the sub-expressions in a way that is human readable, meaningful, and modular.


## Installation

To download the development version of regexr:

Download the [zip ball](https://github.com/trinker/regexr/zipball/master) or [tar ball](https://github.com/trinker/regexr/tarball/master), decompress and run `R CMD INSTALL` on it, or use the **devtools** package to install the development version:

```r
# install.packages("devtools")

devtools::install_github("trinker/regexr")
```

## Help

- [Web Page](http://trinker.github.com/regexr/)     
- [Package PDF Help Manual](https://dl.dropboxusercontent.com/u/61803503/regexr.pdf)   

## Contact

You are welcome to:
* submit suggestions and bug-reports at: <https://github.com/trinker/regexr/issues>
* send a pull request on: <https://github.com/trinker/regexr/>
* compose a friendly e-mail to: <tyler.rinker@gmail.com>

## Functions

| Function             |  Description         |
|----------------------|----------------------|
| `construct`  | Write Human Readable *Concatenated Regex* | 
| `%:)%`  | Add Comments to a Sub-expressions Within `construct` | 
| `unglue`  | Break *Concatenated Regex* Into *Sub-expressions* | 
| `test`   |  Test Validity of *Concatenated Regex* & *Sub-expressions* |
| `subs`   |  Get/Set Sub-expressions in a `regexr` object |
| `comments`   |  Get/Set Comments of Sub-expressions in a `regexr` object |
| `names`   |  Get/Set Names of Sub-expressions in a `regexr` object |
| `as.regexr`| Coerce Existing Regular Expressions to `regexr` object |

## Examples

```{echo=FALSE}
library(regexr)
```

### Construction a Regular Expression

The `construct` function creates an object of the class `regexr`.  This is a character string with meta expression information (i.e., sub-expressions with coresponding names and comments) contained in the object's attributes.


The `%:)%` binary operator allows the user to optionally add comments to the sub-expressions.  The `%:)%`, containing a smiley face emoticon, is used here because commented code/sub-expressions is happy code&#9786;.



```r
m <- construct(
    space =   "\\s+"              %:)%  "I see",
    simp =    "(?<=(foo))",
    or =      "(;|:)\\s*"         %:)%  "comment on what this does",
    is_then = "[ia]s th[ae]n"
)
m
```

```
## [1] "\\s+(?<=(foo))(;|:)\\s*[ia]s th[ae]n"
```

To see a larger script of a regular expession managed by **regexr** for the **qdapRegex** package [CLICK HERE](https://raw.githubusercontent.com/trinker/qdapRegex/master/inst/regex_scripts/rm_citation2.R).

### Viewing the `regexr` Object

Th generic `summary` function provides an integrated view the comments, regexes, and names that make up the *concatenated expression*.


```r
summary(m)
```

```
## 
##  \s+(?<=(foo))(;|:)\s*[ia]s th[ae]n 
##  ==================================
```

```
## SUB-EXPR 1: \s+
## NAME      : space
## COMMENT   : "I see"
## 
## SUB-EXPR 2: (?<=(foo))
## NAME      : simp
## COMMENT   : 
## 
## SUB-EXPR 3: (;|:)\s*
## NAME      : or
## COMMENT   : "comment on what this does"
## 
## SUB-EXPR 4: [ia]s th[ae]n
## NAME      : is_then
## COMMENT   :
```

### Split `regexr` Object 

The `unglue` function splits the concatenated `regexr` expression into component expression chunks.


```r
unglue(m)
```

```
## $space
## [1] "\\s+"
## 
## $simp
## [1] "(?<=(foo))"
## 
## $or
## [1] "(;|:)\\s*"
## 
## $is_then
## [1] "[ia]s th[ae]n"
```

### Get/Set Comments, Regexes, and Names of a `regexr` Object.

The `comments`, `regex`, and `names` functions allow the user to view and alter the comments, regexes, and names of a `regexr` object.



```r
subs(m)
```

```
## $space
## [1] "\\s+"
## 
## $simp
## [1] "(?<=(foo))"
## 
## $or
## [1] "(;|:)\\s*"
## 
## $is_then
## [1] "[ia]s th[ae]n"
```

```r
comments(m)
```

```
## $space
## [1] "I see"
## 
## $simp
## NULL
## 
## $or
## [1] "comment on what this does"
## 
## $is_then
## NULL
```

```r
names(m)
```

```
## [1] "space"   "simp"    "or"      "is_then"
```

```r
subs(m)[4] <- "(FO{2})|(BAR)"
comments(m)[4] <- "Look for FOO or BAR"
names(m)[4] <- "foo_bar"
summary(m)
```

```
## 
##  \s+(?<=(foo))(;|:)\s*(FO{2})|(BAR) 
##  ==================================
```

```
## SUB-EXPR 1: \s+
## NAME      : space
## COMMENT   : "I see"
## 
## SUB-EXPR 2: (?<=(foo))
## NAME      : simp
## COMMENT   : 
## 
## SUB-EXPR 3: (;|:)\s*
## NAME      : or
## COMMENT   : "comment on what this does"
## 
## SUB-EXPR 4: (FO{2})|(BAR)
## NAME      : foo_bar
## COMMENT   : "Look for FOO or BAR"
```

### Testing Regular Expressions

The `test` function allows the user to check if the concatenated `regexr` expression and sub-expressions are valid regular expressions.


```r
test(m)
```

```
## $regex
## [1] TRUE
## 
## $subexpressions
##   space    simp      or foo_bar 
##    TRUE    TRUE    TRUE    TRUE
```

```r
subs(m)[5:7] <- c("(", "([A-Z]|(\\d{5})", ")")
test(m)
```

```
## Warning in test.regexr(m): The concatenated regex is not valid
## 
## \s+(?<=(foo))(;|:)\s*(FO{2})|(BAR)(([A-Z]|(\d{5}))
```

```
## Warning in test.regexr(m): The following regex sub-expressions are not valid in isolation:
## 
## (1) (
## (2) ([A-Z]|(\d{5})
## (3) )
```

```
## $regex
## [1] FALSE
## 
## $subexpressions
##   space    simp      or foo_bar                         
##    TRUE    TRUE    TRUE    TRUE   FALSE   FALSE   FALSE
```

### Existing Regular Expression to `regexr`: Reverse Construction

`as.regexr` allows the user to construct `regexr` objects from a regular expression and in the process generate an auto-commented & named `construct` script. 


```r
library("qdapRegex")
(myregex <- grab("@rm_time"))
```

```
## [1] "\\d{0,2}:\\d{2}(?:[:.]\\d+)?"
```

```r
out <- as.regexr(myregex)
summary(out)
```

```
## 
##  \d{0,2}:\d{2}(?:[:.]\d+)? 
##  =========================
```

```
## SUB-EXPR 1: \d{0,2}
## NAME      : 1
## COMMENT   : "digits (0-9) (between 0 and 2 times (matching the most amount possible))"
## 
## SUB-EXPR 2: :
## NAME      : 2
## COMMENT   : "':'"
## 
## SUB-EXPR 3: \d{2}
## NAME      : 3
## COMMENT   : "digits (0-9) (2 times)"
## 
## SUB-EXPR 4: (?:
## NAME      : 4
## COMMENT   : "group, but do not capture (optional (matching the most amount possible)):"
## 
## SUB-EXPR 5: [:.]
## NAME      : 5
## COMMENT   : "any character of: ':', '.'"
## 
## SUB-EXPR 6: \d+
## NAME      : 6
## COMMENT   : "digits (0-9) (1 or more times (matching the most amount possible))"
## 
## SUB-EXPR 7: )?
## NAME      : 7
## COMMENT   : "end of grouping"
```


We can use `get_construct` to extract an auto-commented & named `construct` script that can be optionally altered and used to `construct` a `regexr` object.


```r
get_construct(out)
```

```
construct(
    `1` = "\\d{0,2}"               %:)%  "digits (0-9) (between 0 and 2 times (matching the most amount possible))",
    `2` = ":"                      %:)%  "':'",
    `3` = "\\d{2}"                 %:)%  "digits (0-9) (2 times)",
    `4` = "(?:"                    %:)%  "group, but do not capture (optional (matching the most amount possible)):",
        `5` = "[:.]"                       %:)%  "any character of: ':', '.'",
        `6` = "\\d+"                       %:)%  "digits (0-9) (1 or more times (matching the most amount possible))",
    `7` = ")?"                     %:)%  "end of grouping"
)
```

Some may prefer that the `construct` script contains no names and/or comments.  The user may also wish to place comments indented below the *sub-expressions* or names outdented and above the *sub-expressions*.


```r
myregex2 <- "(\\s*[a-z]+)([^)]+\\))"
get_construct(as.regexr(myregex2, comments.below=TRUE, names.above = TRUE))
```

```
construct(
    `1` = 
        "("
            %:)%"group and capture to \\1:",
        `2` = 
            "\\s*"
                %:)%"whitespace (\n, \r, \t, \f, and \" \") (0 or more times (matching the most amount possible))",
        `3` = 
            "[a-z]+"
                %:)%"any character of: 'a' to 'z' (1 or more times (matching the most amount possible))",
    `4` = 
        ")"
            %:)%"end of \\1",
    `5` = 
        "("
            %:)%"group and capture to \\2:",
        `6` = 
            "[^)]+"
                %:)%"any character except: ')' (1 or more times (matching the most amount possible))",
        `7` = 
            "\\)"
                %:)%"')'",
    `8` = 
        ")"
            %:)%"end of \\2"
)
```

```r
get_construct(as.regexr(myregex2, names = FALSE))
```

```
construct(
    "("                  %:)%  "group and capture to \\1:",
        "\\s*"               %:)%  "whitespace (\n, \r, \t, \f, and \" \") (0 or more times (matching the most amount possible))",
        "[a-z]+"             %:)%  "any character of: 'a' to 'z' (1 or more times (matching the most amount possible))",
    ")"                  %:)%  "end of \\1",
    "("                  %:)%  "group and capture to \\2:",
        "[^)]+"              %:)%  "any character except: ')' (1 or more times (matching the most amount possible))",
        "\\)"                %:)%  "')'",
    ")"                  %:)%  "end of \\2"
)
```

## Using regexr With the regex Package

Richard Cotton maintains the [`regex`](https://github.com/richierocks/regex) package to provide natural language based functions and constants that can be used to generate regular expressions.  His work can be utilized within the **regexr** framework to maintain manageable commented and named *sub-expressions*.

```r
devtools::install_github("richierocks/regex")
library(regex)

out <- construct(
    year = YEAR                    %:)%  "a year",
    or =   "|"                     %:)%  "or",
    min =  ":" %c% MINUTE          %:)%  "colon followed by valid minutes"
)
```


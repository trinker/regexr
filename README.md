# regexr

[![Build Status](https://travis-ci.org/trinker/regexr.png?branch=master)](https://travis-ci.org/trinker/regexr)
[![DOI](https://zenodo.org/badge/5398/trinker/regexr.svg)](http://dx.doi.org/10.5281/zenodo.13332)

<img src="inst/regexr_logo/r_regexr.png" alt="">   

[regexr](http://trinker.github.com/regexr_dev) is an R framework for constructing human readable regular expressions.  It aims to provide tools that enable the user to write regular expressions in a way that is similar to the ways R code is written.  The tools allow the user to (1) write in smaller, modular, named, *regular expression chunks*, (2) write top to bottom, rather than a single string (3) comment individual chunks, (4) indent expressions to represent regular expression groups, and (5) test the validity of the *concatenated expression* and the modular chunks. 

This framework harnesses the power and flexibility of regular expressions but provides a structural frame that is more consistent with both code writing and natural language conventions.  The user decides how to break, indent, name, and comment the regular expressions in a way that is human readable, meaningful, and modular.


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

## Functions

| Function             |  Description         |
|----------------------|----------------------|
| `construct`  | Write Human Readable *Concatenated Regex* | 
| `%:)%`  | Add Comments to a Regex Within `construct` | 
| `unglue`  | Break *Concatenated Regex* Into *Regex Chunks* | 
| `test`   |  Test Validity of *Concatenated Regex* & *Regex Chunks* |
| `regex`   |  Get/Set Regexes in a `regexr` object |
| `comments`   |  Get/Set Comments in a `regexr` object |
| `names`   |  Get/Set Names in a `regexr` object |
| `as.regexr`| Coerce regular expressions to `regexr` object |

## Examples

```{echo=FALSE}
library(regexr)
```

### Construction a Regular Expression

The `construct` function creates an object of the class `regexr`.  This is a character string with meta expression information contained in the object's attributes.

Notice that the *regular expression chunks* follow the following convention:

> name     
-> regular expression      
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  -> comment     

The `%:)%` binary operator allows the user to optionally add comments to the regular expressions.  The `%:)%`, containing a smiley face emoticon, is used here because commented code/expressions is happy code&#9786;.



```r
m <- construct(
    space =
        "\\s+"
            %:)%"I see",

    simp =
        "(?<=(foo))",

    or =
        "(;|:)\\s*"
            %:)%"comment on what this does",

    "[a]s th[atey]"
)
m
```

```
## [1] "\\s+(?<=(foo))(;|:)\\s*[a]s th[atey]"
```

### Viewing the `regexr` Object

Th generic `summary` function provides an integrated view the comments, regexes, and names that make up the *concatenated expression*.


```r
summary(m)
```

```
## 
##  \s+(?<=(foo))(;|:)\s*[a]s th[atey] 
##  ==================================
```

```
## REGEX 1: \s+
## NAME   : space
## COMMENT: "I see"
## 
## REGEX 2: (?<=(foo))
## NAME   : simp
## COMMENT: 
## 
## REGEX 3: (;|:)\s*
## NAME   : or
## COMMENT: "comment on what this does"
## 
## REGEX 4: [a]s th[atey]
## NAME   : 
## COMMENT:
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
## [[4]]
## [1] "[a]s th[atey]"
```

### Get/Set Comments, Regexes, and Names of a `regexr` Object.

The `comments`, `regex`, and `names` functions allow the user to view and alter the comments, regexes, and names of a `regexr` object.



```r
regex(m)
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
## [[4]]
## [1] "[a]s th[atey]"
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
## [[4]]
## NULL
```

```r
names(m)
```

```
## [1] "space" "simp"  "or"    ""
```

```r
regex(m)[4] <- "(F{O}2)|(BAR)"
comments(m)[4] <- "Look for FOO or BAR"
names(m)[4] <- "foob_bar"
summary(m)
```

```
## 
##  \s+(?<=(foo))(;|:)\s*(F{O}2)|(BAR) 
##  ==================================
```

```
## REGEX 1: \s+
## NAME   : space
## COMMENT: "I see"
## 
## REGEX 2: (?<=(foo))
## NAME   : simp
## COMMENT: 
## 
## REGEX 3: (;|:)\s*
## NAME   : or
## COMMENT: "comment on what this does"
## 
## REGEX 4: (F{O}2)|(BAR)
## NAME   : foob_bar
## COMMENT: "Look for FOO or BAR"
```

### Testing Regular Expressions

The `test` function allows the user to check if the concatenated `regexr` expression and component expression chunks are valid regular expressions.


```r
test(m)
```

```
## $regex
## [1] TRUE
## 
## $chunks
##    space     simp       or foob_bar 
##     TRUE     TRUE     TRUE     TRUE
```

```r
regex(m)[5:7] <- c("(", "([A-Z]|(\\d{5})", ")")
test(m)
```

```
## Warning in test.regexr(m): The concatenated regex is not valid
## 
## \s+(?<=(foo))(;|:)\s*(F{O}2)|(BAR)(([A-Z]|(\d{5}))
```

```
## Warning in test.regexr(m): The following regex chunks are not valid in isolation:
## 
## (1) (
## (2) ([A-Z]|(\d{5})
## (3) )
```

```
## $regex
## [1] FALSE
## 
## $chunks
##    space     simp       or foob_bar                            
##     TRUE     TRUE     TRUE     TRUE    FALSE    FALSE    FALSE
```

### Regex to `regexr`: Reverse Construction

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
## REGEX 1: \d{0,2}
## NAME   : 1
## COMMENT: "digits (0-9) (between 0 and 2 times (matching the most amount possible))"
## 
## REGEX 2: :
## NAME   : 2
## COMMENT: "':'"
## 
## REGEX 3: \d{2}
## NAME   : 3
## COMMENT: "digits (0-9) (2 times)"
## 
## REGEX 4: (?:
## NAME   : 4
## COMMENT: "group, but do not capture (optional (matching the most amount possible)):"
## 
## REGEX 5: [:.]
## NAME   : 5
## COMMENT: "any character of: ':', '.'"
## 
## REGEX 6: \d+
## NAME   : 6
## COMMENT: "digits (0-9) (1 or more times (matching the most amount possible))"
## 
## REGEX 7: )?
## NAME   : 7
## COMMENT: "end of grouping"
```


We can use `get_construct` to extract an auto-commented & named `construct` script that can be optionally altered and used to `construct` a `regexr` object.


```r
get_construct(out)
```

```
construct(
    `1` = 
        "\\d{0,2}"
            %:)%"digits (0-9) (between 0 and 2 times (matching the most amount possible))",
    `2` = 
        ":"
            %:)%"':'",
    `3` = 
        "\\d{2}"
            %:)%"digits (0-9) (2 times)",
    `4` = 
        "(?:"
            %:)%"group, but do not capture (optional (matching the most amount possible)):",
        `5` = 
            "[:.]"
                %:)%"any character of: ':', '.'",
        `6` = 
            "\\d+"
                %:)%"digits (0-9) (1 or more times (matching the most amount possible))",
    `7` = 
        ")?"
            %:)%"end of grouping"
)
```

## Contact

You are welcome to:
* submit suggestions and bug-reports at: <https://github.com/trinker/regexr/issues>
* send a pull request on: <https://github.com/trinker/regexr/>
* compose a friendly e-mail to: <tyler.rinker@gmail.com>

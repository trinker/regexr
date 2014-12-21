# regexr

[![Build Status](https://travis-ci.org/trinker/regexr.png?branch=master)](https://travis-ci.org/trinker/regexr)
[![DOI](https://zenodo.org/badge/5398/trinker/regexr.svg)](http://dx.doi.org/10.5281/zenodo.13332)

<img src="inst/regexr_logo/r_regexr.png" alt="">   

[regexr](http://trinker.github.com/regexr_dev) is an R framework for constructing human readable regular expressions.  It aims to provide tools that enable the user to write regular expressions in a way that is similar to the ways R code is written.  The tools allow the user to (1) write in smaller, modular, named, *regular expression chunks*, (2) write top to bottom, rather than a single string (3) comment individual chunks, (4) indent expressions to represent regular expression groups, and (5) test the validity of the *concatenated expression* and the modular chunks. 

This framework harnesses the power and flexibility of regular expressions but provides a structural frame that is more consistent with both coding writing and natural language conventions.  The user decides how to break, indent, name, and comment the regular expressions in a way that is human readable, meaningful, and modular.


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
```

```
## Error in eval(expr, envir, enclos): could not find function "construct"
```

```r
m
```

```
## Error in eval(expr, envir, enclos): object 'm' not found
```

### Viewing the `regexr` Object

Th generic `summary` function provides an integrated view the comments, regexes, and names that make up the *concatenated expression*.


```r
summary(m)
```

```
## Error in summary(m): object 'm' not found
```

### Split `regexr` Object 

The `unglue` function splits the concatenated `regexr` expression into component expression chunks.


```r
unglue(m)
```

```
## Error in eval(expr, envir, enclos): could not find function "unglue"
```

### Get/Set Comments, Regexes, and Names of a `regexr` Object.

The `comments`, `regex`, and `names` functions allow the user to view and alter the comments, regexes, and names of a `regexr` object.



```r
regex(m)
```

```
## Error in eval(expr, envir, enclos): could not find function "regex"
```

```r
comments(m)
```

```
## Error in eval(expr, envir, enclos): could not find function "comments"
```

```r
names(m)
```

```
## Error in eval(expr, envir, enclos): object 'm' not found
```

```r
regex(m)[4] <- "(F{O}2)|(BAR)"
```

```
## Error in regex(m)[4] <- "(F{O}2)|(BAR)": object 'm' not found
```

```r
comments(m)[4] <- "Look for FOO or BAR"
```

```
## Error in comments(m)[4] <- "Look for FOO or BAR": object 'm' not found
```

```r
names(m)[4] <- "foob_bar"
```

```
## Error in names(m)[4] <- "foob_bar": object 'm' not found
```

```r
summary(m)
```

```
## Error in summary(m): object 'm' not found
```

### Testing Regular Expressions

The `test` function allows the user to check if the concatenated `regexr` expression and component expression chunks are valid regular expressions.


```r
test(m)
```

```
## Error in eval(expr, envir, enclos): could not find function "test"
```

```r
regex(m)[5:7] <- c("(", "([A-Z]|(\\d{5})", ")")
```

```
## Error in regex(m)[5:7] <- c("(", "([A-Z]|(\\d{5})", ")"): object 'm' not found
```

```r
test(m)
```

```
## Error in eval(expr, envir, enclos): could not find function "test"
```

## Contact

You are welcome to:
* submit suggestions and bug-reports at: <https://github.com/trinker/regexr/issues>
* send a pull request on: <https://github.com/trinker/regexr/>
* compose a friendly e-mail to: <tyler.rinker@gmail.com>

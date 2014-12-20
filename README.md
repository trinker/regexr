# regexr

[![Build Status](https://travis-ci.org/trinker/regexr.png?branch=master)](https://travis-ci.org/trinker/regexr)
[![DOI](https://zenodo.org/badge/5398/trinker/regexr.png)](http://dx.doi.org/10.5281/zenodo.11284)

<img src="inst/regexr_logo/r_regexr.png" alt="">   

[regexr](http://trinker.github.com/regexr_dev) is an R framework for constructing human readable regular expressions.  It aims to provide tools that enable the user to write regular expressions in a way that is similar to the ways R code is written.  The tools allow the user to (1) write in smaller, modular, named, regular expression chunks, (2) write top to bottom, rather than a single string (3) comment idividual chunks, (4) indent expressions to represent regular expression groups, and (5) test the validity of the concatenated expression and the modular chunks. 

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


## Examples

```{echo=FALSE}
library(regexr)
```


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

```r
summary(m)
```

```
## 
## \s+(?<=(foo))(;|:)\s*[a]s th[atey]
## ==================================
## 
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
regex(m)[4] <- "(F{O}2)|(BAR)"
summary(m)
```

```
## 
## \s+(?<=(foo))(;|:)\s*(F{O}2)|(BAR)
## ==================================
## 
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
## NAME   : 
## COMMENT:
```

```r
test(m)
```

```
## $regex
## [1] TRUE
## 
## $chunks
## space  simp    or       
##  TRUE  TRUE  TRUE  TRUE
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
## space  simp    or                         
##  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE
```

## Contact

You are welcome to:
* submit suggestions and bug-reports at: <https://github.com/trinker/regexr/issues>
* send a pull request on: <https://github.com/trinker/regexr/>
* compose a friendly e-mail to: <tyler.rinker@gmail.com>


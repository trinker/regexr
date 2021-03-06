% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/as.regexr.R
\name{as.regexr}
\alias{as.regexr}
\title{Generic Method to Coerce to regexr}
\usage{
as.regexr(x, names = TRUE, comments = TRUE, names.above = FALSE,
  comments.below = FALSE, ...)
}
\arguments{
\item{x}{An object to coerce to a \code{regexr} object.}

\item{names}{logical.  Should names be included in the \code{construct}
script?}

\item{comments}{logical.  Should comments be included in the \code{construct}
script?}

\item{names.above}{logical.  Should ames be included above the regex
in the \code{construct} script?  If \code{FALSE} names are placed in front of
the sub-expressions.}

\item{comments.below}{logical.  Should comments be included below the
sub-expressions in the \code{construct} script?  If \code{FALSE} comments
are placed behind the sub-expressions.}

\item{\ldots}{Other arguments passed to \code{as.regexr} methods.}
}
\value{
Returns a dual \code{regexr} and \code{reverse_construct} object.
}
\description{
Coerce an object to \code{regexr} class.
}
\note{
\code{as.regexr.character} utilizes \url{http://rick.measham.id.au/paste/explain}
to break the regular expression into sub-expressions.
}
\examples{
library("qdapRegex")
(myregex <- grab("@rm_time2"))
out <- as.regexr(myregex)

out
summary(out)
comments(out)
subs(out)
test(out)
get_construct(out)

\dontrun{
## On Windows copy to clipboard
get_construct(out, file="clipboard")
}

## No names & comments behind sub-expressions
myregex2 <- "(\\\\s*[a-z]+)([^)]+\\\\))"
get_construct(as.regexr(myregex2, names=FALSE))
get_construct(as.regexr(myregex2, names=FALSE, names.above = TRUE,
    comments.below = TRUE))
}


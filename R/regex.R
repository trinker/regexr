#' Get/Set Regex Chunks From a regexr Object
#' 
#' \code{regex} - Get the \code{regex} chunks from a \code{regexr} object.
#' 
#' @param x A regexr object.
#' @param value The comment(s) to assign.
#' @param \ldots Ignored..
#' @rdname regex
#' @export
#' @return \code{regex} - Returns a list of regexes.
#' @examples 
#' minimal <- construct("a", "b", "c")
#' minimal
#' regex(minimal)
#' regex(minimal)[2] <- "\\s+[A-Z]|[0-9]"
#' regex(minimal)
regex <- function (x, ...){
    UseMethod("regex")
}

#' Set Regex Chunks From a regexr Object
#' 
#' \code{regex<-} - Set the \code{regex} chunk(s) of a \code{regexr} object.
#' 
#' @rdname regex
#' @export
`regex<-` <- function(x, value){
    UseMethod("regex<-")
}




#' Get/Set Comments From a regexr Object
#' 
#' \code{comments} - Get the \code{comments} from a \code{regexr} object.
#' 
#' @param x A regexr object.
#' @param value The comment(s) to assign.
#' @param \ldots Ignored.
#' @rdname comments
#' @export
#' @return \code{comments} - Returns a list of comments.
#' @examples 
#' minimal <- construct("a", "b", "c" %:)% "Comment #3")
#' minimal
#' comments(minimal)
#' comments(minimal)[2] <- "A comment"
#' comments(minimal)
comments <- function (x, ...){
    UseMethod("comments")
}

#' Comments of a regexr Object
#' 
#' \code{comments<-} - Set the \code{comments} of a \code{regexr} object.
#' 
#' @rdname comments
#' @export
`comments<-` <- function(x, value){
    UseMethod("comments<-")
}



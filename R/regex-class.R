#' Prints a regex object
#' 
#' Prints a regex object.
#' 
#' @param x The regex object.
#' @param \ldots Ignored.
#' @export
#' @method print regex
print.regex <- function(x, ...){
    class(x) <- "character"
    print(x)
}
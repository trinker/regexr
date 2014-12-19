"*.character" <- function(x, y) { 
    class(x) <- c("regex", "character")
    attributes(x)[["comment"]] <- y
    x
}


`*` <- `*.character` 
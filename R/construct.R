

regex.regexr <- function(x, ...){
    attributes(x)[["regex"]]
}


`regex<-.regexr` <- function(x, value){
    attributes(x)[["regex"]] <- value
    x
}


`comments<-.regexr` <- function(x, value){
    attributes(x)[["comments"]] <- value
    x
}



names.regexr <- function(x, ...){

    names(attributes(x)[["regex"]])

}

`names<-.regexr` <- function(x, value){

    names(attributes(x)[["regex"]]) <- value
    names(attributes(x)[["comments"]]) <- value
    x

}

summary.regexr <- function(object, ...){

    if (length(attributes(object)[["comments"]]) != 
        length(attributes(object)[["regex"]])) {
        warning("Mismatch in number of regexes and comments; items recycled\n",
            "Consider using `comments` and/or `regex` to update the regexr object")
    }
    out <- suppressWarnings(Map(function(x, y) list(comment = x, regex=y),  
        attributes(object)[["comments"]],
        attributes(object)[["regex"]]
    ))
    class(out) <- "summary"
    attributes(out)[["regex"]] <- as.character(object)
    out
}



print.summary_regexr <- function(x, ...){
   
    class(x) <- "list"

    reg <- attributes(x)[["regex"]]
    message("\n", reg, "\n", 
        paste(rep("=", nchar(reg)), collapse=""), "\n"
    )

    x <- namer(x)

    for (i in seq_along(x)) {
        element <- sprintf("REGEX %s: ", i)
        len <- nchar(element)
        message(element,  x[[i]][["regex"]])
        message(sprintf("NAME%s: ", paste(rep(" ", len - 6), collapse="")),  names(x)[i])        
        message(sprintf("COMMENT%s: ", paste(rep(" ", len - 9), collapse="")), 
            sprintf("\"%s\"", x[[i]][["comment"]]), "\n")
    }
}

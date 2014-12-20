
#' Prints a regexr Object
#' 
#' Prints a \code{regexr} object
#' 
#' @param x The \code{regexr} object.
#' @param \ldots Ignored..
#' @export
#' @method print regexr
print.regexr <- function(x, ...){
    print(as.character(x))
}

#' Unglue regexr Object
#' 
#' \code{regexr} - unglue \code{regexr} object.
#' 
#' regexr Method for unglue
#' @param x The \code{regexr} object.
#' @param \ldots Ignored.
#' @export
#' @method unglue regexr
unglue.regexr <- function(x, ...){
    out <- attributes(x)[["regex"]]
    class(out) <- unique(c("unglued", class(out)))
    out
}

#' Prints an unglued object
#' 
#' Prints an unglued object.
#' 
#' @param x The unglued object.
#' @param \ldots Ignored.
#' @export
#' @method print unglued
print.unglued <- function(x, ...){
    class(x) <- "list"
    out <- invisible(lapply(x, function(x) {class(x) <- "character";x}))
    print(out)
}



#' Extract Comments From regexr Object
#' 
#' \code{regexr} - Extract comments from \code{regexr} object.
#' 
#' regexr Method for comments
#' @param x The \code{regexr} object.
#' @param \ldots Ignored.
#' @export
#' @method comments regexr
comments.regexr <- function(x, ...){
    attributes(x)[["comments"]]
}

#' Set Comments For regexr
#' 
#' \code{regexr} - Set comments for \code{regexr} object.
#' 
#' regexr Method for comments<-
#' @param x The \code{regexr} object.
#' @param value The comment(s) to assign.
#' @param \ldots Ignored.
#' @export
#' @method comments<- regexr
`comments<-.regexr` <- function(x, value){
    attributes(x)[["comments"]] <- value
    len <- length(attributes(x)[["comments"]])
    dif <- diff(c(length(attributes(x)[["regex"]]), len))
    if (dif > 0){  
        null <- structure(list(NULL), .Names = "")
        attributes(x)[["regex"]] <- unlist(list(attributes(x)[["regex"]], 
            rep(null, dif)), recursive=FALSE)
    }    
    x
}

#' Get Regex Chunks From a regexr Object
#' 
#' \code{regex} - Get the \code{regex} chunks from a \code{regexr} object.
#' 
#' regexr Method for regex
#' @param x The \code{regexr} object.
#' @param \ldots Ignored.
#' @export
#' @method regex regexr
regex.regexr <- function(x, ...){
    attributes(x)[["regex"]]
}

#' Set Regex Chunks From a regexr Object
#' 
#' \code{regex<-} - Set the \code{regex} chunk(s) of a \code{regexr} object.
#' 
#' regexr Method for regex<-
#' @param x The \code{regexr} object.
#' @param value The comment(s) to assign.
#' @param \ldots Ignored.
#' @export
#' @method regex<- regexr
`regex<-.regexr` <- function(x, value){
    attributes(x)[["regex"]] <- value
    len <- length(attributes(x)[["regex"]])
    dif <- diff(c(length(attributes(x)[["comments"]]), len))
    if (dif > 0){  
        null <- structure(list(NULL), .Names = "")
        attributes(x)[["comments"]] <- unlist(list(attributes(x)[["comments"]], 
            rep(null, dif)), recursive=FALSE)
    }
    x[[1]] <- paste(unlist(attributes(x)[["regex"]]), collapse="")
    x
}




#' Get Names of a regexr Object
#' 
#' Get names of a \code{regexr} object.
#' 
#' @param x The \code{regexr} object.
#' @param \ldots Ignored.
#' @export
#' @method names regexr
names.regexr <- function(x, ...){

    names(attributes(x)[["regex"]])

}

#' Set Names of a regexr Regex Chunks
#' 
#' Set names of a \code{regexr} object's regular expression chunks.
#' 
#' @param x The \code{regexr} object.
#' @param value The comment(s) to assign.
#' @param \ldots Ignored.
#' @export
#' @method names<- regexr
`names<-.regexr` <- function(x, value){

    names(attributes(x)[["regex"]]) <- value
    names(attributes(x)[["comments"]]) <- value
    x

}

#' Summarize a regexr Object
#' 
#' Summarize a \code{regexr} object.
#' 
#' @param object The \code{regexr} object 
#' @param \ldots Ignored.
#' @method summary regexr
#' @export
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
    class(out) <- "summary_regexr"
    attributes(out)[["regex"]] <- as.character(object)
    out
}


#' Prints a summary_regexr object
#' 
#' Prints a summary_regexr object.
#' 
#' @param x The summary_regexr object.
#' @param \ldots Ignored.
#' @export
#' @method print summary_regexr
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

#' Test Regular Expression Validity
#' 
#' Test regular expression validity of a \code{regexr} object.
#' 
#' test Method for regex<-
#' @param x The \code{regexr} object.
#' @param quiet logical.  Should \code{test} print warnings about the 
#' concatenated expression and individual chunks?
#' @param \ldots Ignored.
#' @export
#' @method test regexr
test.regexr <- function(x, quiet = FALSE, ...){

    out1 <- is.regex(x)
    if (!isTRUE(quiet) && !out1){
        warning("The concatenated regex is not valid\n\n", as.character(x), "\n")
    }
    out2 <- sapply(regex(x), is.regex)
    if (!isTRUE(quiet) && any(!out2)){
        warning("The following regex chunks are not valid in isolation:\n\n",
            paste(paste0("(", seq_len(sum(!out2)), ") ", 
                as.character(unlist(regex(x)))[!out2]), collapse="\n")
        )
    }
    list(regex = out1, chunks = out2)
}



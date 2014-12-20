#' Construct Human Readable Regular Expressions
#' 
#' This function is used to construct human readable regular expressions from
#' chunks.  The user may provide additional meta information about each chunk.
#' This meta information is an optional name and comment for the chunk.  This
#' allows one to write regular expressions in a fasion similar to writing code,
#' that is the regular expression is written top to bottom, the syntax is broken
#' up into managable chunks, the expression can be indented to give structural 
#' insight such as nested groups, and the chunks can be commented to provide
#' linguistic grounding for more complex chunks.
#' 
#' @param \ldots A series of comma separated charcter strings (chunks) that may 
#' optionally be named, commented (see \code{?`\%*\%`}, and indented.
#' @return Returns a character vector of the class \code{regexr}. The attributes 
#' of the returned object retaint he original name and comment properties.
#' @keywords regex
#' @export
#' @examples
#' m <- construct(
#'     space = 
#'         "\\s+" 
#'             *"I see",
#' 
#'     simp = 
#'         "(?<=(foo))",
#' 
#'     or = 
#'         "(;|:)\\s*"  
#'             *"comment on what this does",
#' 
#'     "[a]s th[atey]"
#' )
#' 
#' m
#' unglue(m)
#' summary(m)
#' 
#' regex(m)[4] <- "FOO"
#' summary(m)
#' explain(m)
#' 
#' twitter <- construct(
#'         neg_lookbehing = 
#'             "(?<![@@\\w])"
#'                 *"Make sure the string doesn't start with @@ or a word",
#'         at = 
#'             "(@@)"
#'                 *"capture starting with @@ symbol",
#'         s_gr1 = 
#'             "("
#'                 *"Opening parenthesis group 1",            
#'             handle =     
#'                 "([a-z0-9_]{1,15})"
#'                 *"Mix of 15 letters, numbers, or underscores", 
#'             boundary =
#'                 "\\b",
#'         e_gr1 = 
#'             ")"
#'                 *"Closing parenthesis group 1"
#' )
#' 
#' twitter
#' unglue(twitter)
#' comments(twitter)
#' explain(twitter)
#' 
#' x <- c("@@hadley I like #rstats for #ggplot2 work.",
#'     "Difference between #magrittr and #pipeR, both implement pipeline operators for #rstats:
#'         http://renkun.me/r/2014/07/26/difference-between-magrittr-and-pipeR.html @@timelyportfolio",
#'     "Slides from great talk: @@ramnath_vaidya: Interactive slides from Interactive Visualization
#'         presentation #user2014. http://ramnathv.github.io/user2014-rcharts/#1",
#'     "tyler.rinker@@gamil.com is my email",
#'     "A non valid Twitter is @@abcdefghijklmnopqrstuvwxyz"
#' )
#' 
#' rm_default(x, pattern = twitter, extract = TRUE)
#' 
#' 
#' 
#' 
#' minimal <- regex(1, 2, 3)
#' minimal
#' unglue(minimal)
#' comments(minimal)
#' 
#' 
#' combined <- construct(
#'     twitter = 
#'         twitter 
#'             *"Twitter regex created previously",
#'     or =
#'         "|"
#'             *"Join the twitter handle regex and a hash tag regex",
#'     hash =
#'         grab("@@rm_hash")
#'             *"Twitter hash tag regex"
#' )
#' 
#' combined
#' unglue(combined)
#' comments(combined)
#' explain(combined)
#' explain(combined, TRUE)
construct <- function(...){
    out <- paste0(...)
    class(out) <- c("regexr", class(out))
    attributes(out)[["regex"]] <- list(...)
    attributes(out)[["comments"]] <- lapply(list(...), get_comment)
    out
}


print.regexr <- function(x, ...){
    print(as.character(x))
}


unglue.regexr <- function(x, ...){
    out <- attributes(x)[["regex"]]
    class(out) <- unique(c("unglued", class(out)))
    out
}

print.unglued <- function(x, ...){
    class(x) <- "list"
    out <- invisible(lapply(x, function(x) {class(x) <- "character";x}))
    print(out)
}



comments <- function (x, ...){
    UseMethod("comments")
}

comments.regexr <- function(x, ...){
    attributes(x)[["comments"]]
}


regex.regexr <- function(x, ...){
    attributes(x)[["regex"]]
}


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


test.regexr <- function(x, quiet = FALSE, ...){

    out <- sapply(regex(x), is.regex)
    if (!isTRUE(quiet) && any(!out)){
        warning("The following regex chunks are not valid:\n\n",
            paste(paste0(seq_len(sum(!out)), ": ", as.character(unlist(regex(x)))[!out]), collapse="\n")
        )
    }
    out
}


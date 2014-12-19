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
#'             "(?<![@\\w])"
#'                 *"Make sure the string doesn't start with @ or a word",
#'         at = 
#'             "(@)"
#'                 *"capture starting with @ symbol",
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
#' x <- c("@hadley I like #rstats for #ggplot2 work.",
#'     "Difference between #magrittr and #pipeR, both implement pipeline operators for #rstats:
#'         http://renkun.me/r/2014/07/26/difference-between-magrittr-and-pipeR.html @timelyportfolio",
#'     "Slides from great talk: @ramnath_vaidya: Interactive slides from Interactive Visualization
#'         presentation #user2014. http://ramnathv.github.io/user2014-rcharts/#1",
#'     "tyler.rinker@gamil.com is my email",
#'     "A non valid Twitter is @abcdefghijklmnopqrstuvwxyz"
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
#'         grab("@rm_hash")
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




namer <- function(x, ...){
    if (is.null(names(x))) names(x) <- rep("", length(x))
    x
}
 

get_comment <- function(x, ...) {
     attributes(x)[["comment"]]
}












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
#' optionally be named, commented (see \code{?`\%:)\%`}, and indented.
#' @return Returns a character vector of the class \code{regexr}. The attributes 
#' of the returned object retaint he original name and comment properties.
#' @keywords regex
#' @export
#' @examples
#' ## Minimal Example
#' minimal <- construct("a", "b", "c")
#' minimal
#' unglue(minimal)
#' comments(minimal)
#' regex(minimal)
#' test(minimal)
#' summary(minimal)
#' 
#' ## Example 1
#' m <- construct(
#'     space = 
#'         "\\s+" 
#'             %:)%"I see",
#' 
#'     simp = 
#'         "(?<=(foo))",
#' 
#'     or = 
#'         "(;|:)\\s*"  
#'             %:)%"comment on what this does",
#' 
#'     "[a]s th[atey]"
#' )
#' 
#' m
#' unglue(m)
#' summary(m)
#' regex(m)
#' comments(m)
#' regex(m)[4] <- "(F{O}2)|(BAR)"
#' summary(m)
#' test(m)
#' \dontrun{
#' regex(m)[5:7] <- c("(", "([A-Z]|(\\d{5})", ")")
#' test(m)
#' }
#' 
#' library(qdapRegex)
#' explain(m)
#' 
#' ## Exmaple 2 (Twitter Handle)
#' twitter <- construct(
#'         neg_lookbehing = 
#'             "(?<![@@\\w])"
#'                 %:)%"Make sure the string doesn't start with @@ or a word",
#'         at = 
#'             "(@@)"
#'                 %:)%"capture starting with @@ symbol",
#'         s_gr1 = 
#'             "("
#'                 %:)%"Opening parenthesis group 1",            
#'             handle =     
#'                 "([a-z0-9_]{1,15})"
#'                 %:)%"Mix of 15 letters, numbers, or underscores", 
#'             boundary =
#'                 "\\b",
#'         e_gr1 = 
#'             ")"
#'                 %:)%"Closing parenthesis group 1"
#' )
#' 
#' twitter
#' unglue(twitter)
#' comments(twitter)
#' regex(twitter)
#' summary(twitter)
#' test(twitter)
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
#' library(qdapRegex)
#' rm_default(x, pattern = twitter, extract = TRUE)
#' 
#' ## Example 3 (Modular Chunks)
#' combined <- construct(
#'     twitter = 
#'         twitter 
#'             %:)%"Twitter regex created previously",
#'     or =
#'         "|"
#'             %:)%"Join the twitter handle regex and a hash tag regex",
#'     hash =
#'         grab("@@rm_hash")
#'             %:)%"Twitter hash tag regex"
#' )
#' 
#' combined
#' unglue(combined)
#' comments(combined)
#' regex(combined)
#' summary(combined)
#' test(combined)
#' explain(combined)
construct <- function(...){
    out <- paste0(...)
    class(out) <- c("regexr", class(out))
    attributes(out)[["regex"]] <- list(...)
    attributes(out)[["comments"]] <- lapply(list(...), get_comment)
    out
}

regex <- function (x, ...){
    UseMethod("regex")
}


`regex<-` <- function(x, value){
    UseMethod("regex<-")
}



print.regex <- function(x, ...){
    class(x) <- "character"
    print(x)
}
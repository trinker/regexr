context("Checking regex")

test_that("regex grabs component chunks",{

    minimal <- structure("abc", class = c("regexr", "character"), regex = list(
            "a", "b", structure("c", class = c("regex", "character"), comment = "A love note to your future self")), comments = list(
            NULL, NULL, "A love note to your future self"))
    
    x1 <- list("a", "b", structure("c", class = c("regex", "character"), comment = "A love note to your future self"))
    
    expect_equivalent(regex(minimal), x1)

})

test_that("regex is changed by assigment",{
    
    minimal <- structure("abc", class = c("regexr", "character"), regex = list(
            "a", "b", structure("c", class = c("regex", "character"), comment = "A love note to your future self")), comments = list(
            NULL, NULL, "A love note to your future self"))
    
    regex(minimal)[2] <- "\\s+[A-Z]|[0-9]"
    
    x2 <- list("a", "\\s+[A-Z]|[0-9]", structure("c", class = c("regex", 
        "character"), comment = "A love note to your future self"))
    
    expect_equivalent(regex(minimal), x2)
})

test_that("regexes are changed by setting (similar to `setNames`)",{
    
    minimal <- structure("abc", class = c("regexr", "character"), regex = list(
            "a", "b", "c"), comments = list(NULL, NULL, NULL))
    
    out <- set_regex(minimal, c("\\s+", "(?:foo)", "[A-Za-z-]*"))
    
    out_check <- structure("\\s+(?:foo)[A-Za-z-]*", class = c("regexr", "character"
        ), regex = c("\\s+", "(?:foo)", "[A-Za-z-]*"), comments = list(
            NULL, NULL, NULL))
    
    expect_equivalent(out, out_check)

})


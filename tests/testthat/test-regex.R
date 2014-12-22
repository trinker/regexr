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



context("Checking names")

test_that("names are changed by assigment",{
    
    minimal <- structure("abc", class = c("regexr", "character"), regex = list(
        "a", "b", structure("c", class = c("regex", "character"), 
            comment = "A love note to your future self")), comments = list(
        NULL, NULL, "A love note to your future self"))

    
    names(minimal)[2:3] <- c("Foo", "Bar")
    
    x <- c("", "Foo", "Bar")
    
    expect_equivalent(names(minimal), x)
})

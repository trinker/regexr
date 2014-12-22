context("Checking unglue")

test_that("unglue extracts elements chunks from a regecr object",{

    minimal <- structure("abc", class = c("regexr", "character"), regex = list(
            "a", "b", structure("c", class = c("regex", "character"), comment = "A love note to your future self")), comments = list(
            NULL, NULL, "A love note to your future self"))
    
    x <- structure(list("a", "b", structure("c", class = c("regex", "character"
        ), comment = "A love note to your future self")), class = c("unglued", 
        "list"))
    
    
    expect_equivalent(unglue(minimal), x)

})



context("Checking summary")

test_that("summary outputs pieces needed for printing",{

    minimal <- structure("abc", class = c("regexr", "character"), subs = list(
        "a", "b", structure("c", class = c("subcom", "character"), 
            comment = "A love note to your future self")), comments = list(
        NULL, NULL, "A love note to your future self"))

   
    x <- structure(list(`NA` = structure(list(comment = NULL, subs = "a"), .Names = c("comment", 
       "subcom")), Foo = structure(list(comment = NULL, subs = "b"), .Names = c("comment", 
        "subcom")), Bar = structure(list(comment = "A love note to your future self", 
        subs = structure("c", class = c("subcom", "character"), comment = "A love note to your future self")), .Names = c("comment", 
        "subcom"))), .Names = c(NA, "Foo", "Bar"), class = "summary_regexr", subs = "abc")

    
    expect_equivalent(summary(minimal), x)

})


test_that("summary prints as expected",{

    minimal <- structure("abc", class = c("regexr", "character"), subs = list(
        "a", "b", structure("c", class = c("regex", "character"), 
            comment = "A love note to your future self")), comments = list(
        NULL, NULL, "A love note to your future self"))

    expect_equivalent(capture.output(regexr:::print.regexr(minimal)),
        "[1] \"abc\"")

})

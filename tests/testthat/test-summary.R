context("Checking summary")

test_that("summary outputs pieces needed for printing",{

    minimal <- structure("abc", class = c("regexr", "character"), regex = list(
        "a", "b", structure("c", class = c("regex", "character"), comment = "A love note to your future self")), comments = list(
        NULL, NULL, "A love note to your future self"))

   
    x <- structure(list(`NA` = structure(list(comment = NULL, regex = "a"), .Names = c("comment", 
       "regex")), Foo = structure(list(comment = NULL, regex = "b"), .Names = c("comment", 
        "regex")), Bar = structure(list(comment = "A love note to your future self", 
        regex = structure("c", class = c("regex", "character"), comment = "A love note to your future self")), .Names = c("comment", 
        "regex"))), .Names = c(NA, "Foo", "Bar"), class = "summary_regexr", regex = "abc")

    
    expect_equivalent(summary(minimal), x)

})


test_that("summary prints as expected",{

    minimal <- structure("abc", class = c("regexr", "character"), regex = list(
        "a", "b", structure("c", class = c("regex", "character"), 
            comment = "A love note to your future self")), comments = list(
        NULL, NULL, "A love note to your future self"))

    expect_equivalent(capture.output(regexr:::print.regexr(minimal)),
        "[1] \"abc\"")

})

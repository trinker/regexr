context("Checking test")

test_that("test matches epected regular expression validity",{

    m <- structure("\\s+(?<=(foo))(;|:)\\s*[a]s th[atey]", class = c("regexr", 

        "character"), regex = structure(list(space = structure("\\s+", class = c("regex", 
        "character"), comment = "I see"), simp = "(?<=(foo))", or = structure("(;|:)\\s*", class = c("regex", 
        "character"), comment = "comment on what this does"), "[a]s th[atey]"), .Names = c("space", 
        "simp", "or", "")), comments = structure(list(space = "I see", 
            simp = NULL, or = "comment on what this does", NULL), .Names = c("space", 
        "simp", "or", "")))
    
    x1 <- structure(list(regex = TRUE, chunks = structure(c(TRUE, TRUE, 
        TRUE, TRUE), .Names = c("space", "simp", "or", ""))), .Names = c("regex", 
        "chunks"))
    
    expect_equivalent(test(m), x1)
})

test_that("test matches epected regular expression validity",{
    
    m2 <- structure("\\s+(?<=(foo))(;|:)\\s*[a]s th[atey](([A-Z]|(\\d{5}))", class = c("regexr", 
        "character"), regex = structure(list(space = structure("\\s+", class = c("regex", 
        "character"), comment = "I see"), simp = "(?<=(foo))", or = structure("(;|:)\\s*", class = c("regex", 
        "character"), comment = "comment on what this does"), "[a]s th[atey]", 
            "(", "([A-Z]|(\\d{5})", ")"), .Names = c("space", "simp", 
        "or", "", "", "", "")), comments = structure(list(space = "I see", 
            simp = NULL, or = "comment on what this does", NULL, NULL, 
            NULL, NULL), .Names = c("space", "simp", "or", "", "", "", 
        "")))
    
    expect_warning(test(m2))
    
    x2 <- structure(list(regex = FALSE, chunks = structure(c(TRUE, TRUE, 
        TRUE, TRUE, FALSE, FALSE, FALSE), .Names = c("space", "simp", 
        "or", "", "", "", ""))), .Names = c("regex", "chunks"))

    out <- test(m2, quiet=TRUE)
    expect_equivalent(out, x2)
})



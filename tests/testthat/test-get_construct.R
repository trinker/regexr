context("Checking get_construct")

test_that("get_construct creates a construct script that's character when `file = NULL`",{

    x <- structure("\\d{0,2}:\\d{2}(?:[:.]\\d+)?", class = c("regexr", 
        "reverse_construct", "character"), subs = structure(list(`1` = "\\d{0,2}", 
            `2` = ":", `3` = "\\d{2}", `4` = "(?:", `5` = "[:.]", `6` = "\\d+", 
            `7` = ")?"), .Names = c("1", "2", "3", "4", "5", "6", "7"
        )), comments = structure(list(`1` = "digits (0-9) (between 0 and 2 times (matching the most amount possible))", 
            `2` = "':'", `3` = "digits (0-9) (2 times)", `4` = "group, but do not capture (optional (matching the most amount possible)):", 
            `5` = "any character of: ':', '.'", `6` = "digits (0-9) (1 or more times (matching the most amount possible))", 
            `7` = "end of grouping"), .Names = c("1", "2", "3", "4", 
        "5", "6", "7")), reverse_construct = structure(paste0("construct(\n    `1` = \"\\\\d{0,2}\"               ",
            "%:)%  \"digits (0-9) (between 0 and 2 times (matching the most amount possible))\",\n    ",
            "`2` = \":\"                      %:)%  \"':'\",\n    `3` = \"\\\\d{2}\"                 ",
            "%:)%  \"digits (0-9) (2 times)\",\n    `4` = \"(?:\"                    %:)%  \"group, but ",
            "do not capture (optional (matching the most amount possible)):\",\n        `5` = \"[:.]\"                       ",
            "%:)%  \"any character of: ':', '.'\",\n        `6` = \"\\\\d+\"                       ",
            "%:)%  \"digits (0-9) (1 or more times (matching the most amount possible))\",\n    ",
            "`7` = \")?\"                     %:)%  \"end of grouping\"\n)\n"), 
            class = c("reverse_construct", "character")))
      
    out <- paste0("construct(\n    `1` = \"\\\\d{0,2}\"               %:)%  \"digits (0-9) (between 0 and 2 times ",
        "(matching the most amount possible))\",\n    `2` = \":\"                      %:)%  \"':'\",\n    ",
        "`3` = \"\\\\d{2}\"                 %:)%  \"digits (0-9) (2 times)\",\n    `4` = \"(?:\"                    ",
        "%:)%  \"group, but do not capture (optional (matching the most amount possible)):\",\n        `5` = \"[:.]\"                       ",
        "%:)%  \"any character of: ':', '.'\",\n        `6` = \"\\\\d+\"                       ",
        "%:)%  \"digits (0-9) (1 or more times (matching the most amount possible))\",\n    `7` = \")?\"                     ",
        "%:)%  \"end of grouping\"\n)\n"
    )

    expect_equivalent(get_construct(x, file=NULL), out)
})

test_that("get_construct creates a construct script that's pretty printed when `file = \"\"`",{

    x <- structure("\\d{0,2}:\\d{2}(?:[:.]\\d+)?", class = c("regexr", 
        "reverse_construct", "character"), subs = structure(list(`1` = "\\d{0,2}", 
            `2` = ":", `3` = "\\d{2}", `4` = "(?:", `5` = "[:.]", `6` = "\\d+", 
            `7` = ")?"), .Names = c("1", "2", "3", "4", "5", "6", "7"
        )), comments = structure(list(`1` = "digits (0-9) (between 0 and 2 times (matching the most amount possible))", 
            `2` = "':'", `3` = "digits (0-9) (2 times)", `4` = "group, but do not capture (optional (matching the most amount possible)):", 
            `5` = "any character of: ':', '.'", `6` = "digits (0-9) (1 or more times (matching the most amount possible))", 
            `7` = "end of grouping"), .Names = c("1", "2", "3", "4", 
        "5", "6", "7")), reverse_construct = structure(paste0("construct(\n    `1` = \"\\\\d{0,2}\"               ",
            "%:)%  \"digits (0-9) (between 0 and 2 times (matching the most amount possible))\",\n    ",
            "`2` = \":\"                      %:)%  \"':'\",\n    `3` = \"\\\\d{2}\"                 ",
            "%:)%  \"digits (0-9) (2 times)\",\n    `4` = \"(?:\"                    %:)%  \"group, but ",
            "do not capture (optional (matching the most amount possible)):\",\n        `5` = \"[:.]\"                       ",
            "%:)%  \"any character of: ':', '.'\",\n        `6` = \"\\\\d+\"                       ",
            "%:)%  \"digits (0-9) (1 or more times (matching the most amount possible))\",\n    ",
            "`7` = \")?\"                     %:)%  \"end of grouping\"\n)\n"), 
            class = c("reverse_construct", "character")))
    
    out2 <- c("construct(", "    `1` = \"\\\\d{0,2}\"               %:)%  \"digits (0-9) (between 0 and 2 times (matching the most amount possible))\",", 
        "    `2` = \":\"                      %:)%  \"':'\",", "    `3` = \"\\\\d{2}\"                 %:)%  \"digits (0-9) (2 times)\",", 
        "    `4` = \"(?:\"                    %:)%  \"group, but do not capture (optional (matching the most amount possible)):\",", 
        "        `5` = \"[:.]\"                       %:)%  \"any character of: ':', '.'\",", 
        "        `6` = \"\\\\d+\"                       %:)%  \"digits (0-9) (1 or more times (matching the most amount possible))\",", 
        "    `7` = \")?\"                     %:)%  \"end of grouping\"", 
        ")"
    )

    expect_equivalent(capture.output(get_construct(x)), out2)
    
})
NEWS 
====

Versioning
----------

Releases will be numbered with the following semantic versioning format:

&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor 
  and patch)
* New additions without breaking backward compatibility bumps the minor 
  (and resets the patch)
* Bug fixes and misc changes bumps the patch

 <a href="https://github.com/trinker/regexr" target="_blank">regexr</a> 1.0.0
----------------------------------------------------------------

The `regex` function has been removed (not `Deprecated`) as  <a href="https://github.com/trinker/regexr" target="_blank">regexr</a> is in beta 
mode.  This move breaks backward compatibility and thus a bump in major release
to version 1.0.0.

**BUG FIXES**

**NEW FEATURES**

**MINOR FEATURES**

**IMPROVEMENTS**

**CHANGES**

* `regex` function replaced with the `subs` function.  This move is both 
  semantic and pragmatic.  The term "regular expression chunk" has been 
  replaced with "sub-expressions".  The `subs` function reflects the semantic 
  change.  Additionally, Richie Cotton's **regex** package 
  (https://github.com/richierocks/regex), which is complementary to  <a href="https://github.com/trinker/regexr" target="_blank">regexr</a>,
  contains a `regex` function.

* The `regex` class (created from adding a comment to a string) has been 
  replaced with the `subcom` (sub-expression commented) class.  THis name is 
  more informative and avoids conflicts with other regex packages that may 
  contain a `regex` class.

 <a href="https://github.com/trinker/regexr" target="_blank">regexr</a> 0.0.3 - 0.0.4
----------------------------------------------------------------

**NEW FEATURES**

* `as.regexr` added to coerce a regular expression to a `regexr` class using
  the regular expression breakdown of <a href="http://rick.measham.id.au/paste/explain.pl." target="_blank">http://rick.measham.id.au/paste/explain.pl.</a>
  The `get_construct` function extracts a script to create a `construct` regex
  from `regexr` objects that were coerced using `as.regexr`.

**MINOR FEATURES**

* `set_comments`, `set_regex`, and `set_names` added as a  convenience functions
  to set elements of a `regexr` object and return the object.

**IMPROVEMENTS**

* `print.summary_regexr` used `message` to print to the console which had the 
  potential to not return the entire input.  `print.summary_regexr` now uses 
  `cat` rather than `message`. 

**CHANGES**

* The recommended structure for the `construct` code is no longer a separate 
  line for each regular expression chunk's *name*, *regex*, and *comment* but
  *name*, *regex*, and *comment* all go on the same line.   This makes the  code
  less cluttered and easier to navigate, particularity if indentation is used to
  indicate nested grouping structures.  Users may choose whatever configuration 
  that suits their preference, however, examples will generally be shown via the 
  new recommended, single line, structure. 



 <a href="https://github.com/trinker/regexr" target="_blank">regexr</a> 0.0.1 - 0.0.2
----------------------------------------------------------------

 <a href="https://github.com/trinker/regexr" target="_blank">regexr</a> is an R framework for constructing human readable regular expressions.  
It aims to provide tools that enable the user to write regular expressions in a 
way that is similar to the ways R code is written.  The tools allow the user to 
(1) write in smaller, modular, named, regular expression chunks, (2) write top 
to bottom, rather than a single string (3) comment individual chunks, (4) indent 
expressions to represent regular expression groups, and (5) test the validity of 
the concatenated expression and the modular chunks. 

This framework harnesses the power and flexibility of regular expressions but 
provides a structural frame that is more consistent with both coding writing and 
natural language conventions.

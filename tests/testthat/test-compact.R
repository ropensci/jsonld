context("compact")

# Read all test files
tests <- jsonlite::fromJSON(tf("compact-manifest.jsonld"), simplifyVector = FALSE)

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    expect <- tf(x$expect)
    out <- jsonld_compact(tf(x$input), tf(x$context), options = list(
      base = tests$baseIri
    ))
    success <- json_equal(out, expect)
    expect_true(success)
    if(!isTRUE(success)){
      cat("OUT:\n", out, "\nEXPECTED:\n", expect,"\n")
      readline("pause\n")
    }
  })
})

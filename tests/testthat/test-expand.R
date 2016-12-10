context("expand")

# Read all test files
tests <- jsonlite::fromJSON(tf("expand-manifest.jsonld"), simplifyVector = FALSE)

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    expect <- tf(x$expect)
    out <- jsonld_expand(tf(x$input), options = list(
      base = tests$baseIri
    ))
    success <- json_equal(out, expect)
    if(!isTRUE(success)){
      cat("OUT:\n", out, "\nEXPECTED:\n", expect,"\n")
      readline("pause\n")
    }
  })
})

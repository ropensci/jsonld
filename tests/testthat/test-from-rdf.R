context("from_rdf")

# Read all test files
tests <- jsonlite::fromJSON(tf("fromRdf-manifest.jsonld"), simplifyVector = FALSE)

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    expect <- tf(x$expect)
    out <- jsonld_from_rdf(tf(x$input), options = list(
      base = "http://json-ld.org/test-suite/tests/"
    ))
    expect_true(json_equal(out, expect))
  })
})

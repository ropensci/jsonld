context("to_rdf")

# Read all test files
tests <- jsonlite::fromJSON(tf("toRdf-manifest.jsonld"), simplifyVector = FALSE)

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    expect <- tf(x$expect)
    out <- jsonld_to_rdf(tf(x$input))
    expect_equal(trimws(out), trimws(expect))
  })
})
